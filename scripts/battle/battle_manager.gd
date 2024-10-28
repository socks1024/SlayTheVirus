class_name BattleManager
extends Node2D

@onready var player_card_manager = $PlayerCardManager
@onready var board = $PlayerCardManager/Board
@onready var hand = $PlayerCardManager/Hand
@onready var main = get_parent().get_parent()
@onready var battle_screen = get_parent()

var player:Player
var boss:Boss

func _ready():
	
	initialize_buff()
	
	$PlayerCardManager.cards_played.connect(change_side)


#region PROCESS

#signal enemy_intention_refresh
#signal player_draw_card
#signal player_place_card
#signal player_card_act
#signal enemy_parts_act


func player_win():
	battle_screen.battle_end.emit(true)

func player_lose():
	battle_screen.battle_end.emit(false)

@export var wait_time = 0.6

func change_side():
	get_tree().create_timer(wait_time).timeout.connect(get_parent().enemy_parts_act.emit)


#endregion

#region buff

@export var buff_sample_packed:PackedScene

var buff_scripts:Array[GDScript]
var buff_list:= {}

func initialize_buff():
	
	buff_scripts.append(preload("res://src/scripts/buffs/inactivition_buff.gd"))
	buff_scripts.append(preload("res://src/scripts/buffs/vulnerable.gd"))
	buff_scripts.append(preload("res://src/scripts/buffs/trauma.gd"))
	buff_scripts.append(preload("res://src/scripts/buffs/paralysis.gd"))
	buff_scripts.append(preload("res://src/scripts/buffs/proliferation.gd"))
	buff_scripts.append(preload("res://src/scripts/buffs/spike.gd"))
	buff_scripts.append(preload("res://src/scripts/buffs/stun.gd"))
	
	for b in buff_scripts:
		var node = b.new()
		node.initialize(1)
		buff_list[node.id] = b
		node.queue_free()

func build_buff(id:String,amount:int) -> BaseBuff:
	var buff = buff_sample_packed.instantiate()
	buff.set_script(buff_list[id])
	buff.battle_manager = self
	buff.initialize(amount)
	
	return buff

var trash_cards = [37,38,39,40,41,42]

func gain_trash(amount:int,random:bool,id:String):
	for i in amount:
		var trash_card:BaseCard
		
		if random:
			trash_card = main.get_card(main.card_list.keys()[trash_cards.pick_random()-1])
		else:
			trash_card = main.get_card(id)
		
		player.draw_pile.add_card(trash_card)


#endregion

#region ACTION QUEUE

var action_queue:Array[BaseAction]

signal queue_finished

func add_action_to_bot(action):
	action_queue.append(action)

func queue_act():
	if !action_queue.is_empty():
		for i in action_queue.size():
			var action = action_queue.pop_front()
			self.add_child(action)
			action.act()
			action.act_show()
			action.queue_free()
	
	queue_finished.emit()

func use(action:BaseAction):
	self.add_child(action)
	action.act()
	action.act_show()
	action.queue_free()

#endregion
