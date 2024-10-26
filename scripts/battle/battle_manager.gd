class_name BattleManager
extends Node2D

@onready var board = $PlayerCardManager/Board
@onready var hand = $PlayerCardManager/Hand
@onready var main = get_parent().get_parent()
@onready var battle_screen = get_parent()

var player:Player
var boss:Boss

func _ready():
	
	#region buff
	
	buff_scripts.append("res://src/scripts/buffs/inactivition_buff.gd")
	
	for b in buff_scripts:
		var node = b.new()
		node.initialize()
		var key = node.id
		buff_list[key] = b
	
	#endregion
	
	$PlayerCardManager.cards_played.connect(get_parent().enemy_parts_act.emit)
	

#region TURN_PROCESS

#signal enemy_intention_refresh
#signal player_draw_card
#signal player_place_card
#signal player_card_act
#signal enemy_parts_act


func player_win():
	battle_screen.battle_end.emit(true)

func player_lose():
	battle_screen.battle_end.emit(false)


#endregion

#region buff

@export var buff_sample_packed:PackedScene

var buff_scripts:Array[GDScript]
var buff_list:= {}

func build_buff(id:String,amount:int) -> BaseBuff:
	var buff = buff_sample_packed.instantiate()
	buff.set_script(buff_list[id])
	buff.initialize(amount)
	
	return buff


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

#region player <-> enemy

func get_highlight_part() -> BaseCreature:	
	return boss.focused_part

#endregion
