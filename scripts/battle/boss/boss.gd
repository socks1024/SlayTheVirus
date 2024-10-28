class_name Boss
extends Node2D

@onready var main = get_tree().get_first_node_in_group("main")
@onready var battle_manager = main.battle_manager


var parts:Array[BasePart]
var main_part:BasePart
var focused_part:BasePart

var move_tween:Tween

func _ready():
	for part in get_children():
		parts.append(part)
		
		part.focus_part.connect(_on_focus_part)
		
		if part.is_main_part:
			main_part = part
			main_part.dead.connect(_on_main_part_dead)
			focused_part = main_part
	
	move_tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	move_tween.tween_property(self,"position",position + 10 * Vector2.DOWN,2)
	move_tween.tween_property(self,"position",position + 10 * Vector2.UP,2)
	move_tween.set_loops()


#region GUI & animation

func focus_main_part():
	for part in parts:
		set_part_color(part,part.modulate_color)
	
	focused_part = main_part
	main.battle_screen.enemy_stat_bar.connect_creature(main_part)

func _on_focus_part(c:BasePart):
	set_part_highlight(c)
	focused_part = c
	main.battle_screen.enemy_stat_bar.connect_creature(c)

func _on_focus_part_with_color(c:BasePart,color:Color):
	set_part_color(c,color)
	focused_part = c
	main.battle_screen.enemy_stat_bar.connect_creature(c)

@export var highlight_color = Color(1.2,1.2,1.2)

func set_part_color(part:BasePart,color:Color):
	part.modulate = color

func set_part_highlight(part:BasePart):
	if !part.destroyed:
		set_part_color(focused_part,focused_part.modulate_color)
		
		if part != main_part:
			set_part_color(part,highlight_color)


func get_targeted_part() -> BasePart:
	if focused_part.targetable:
		return focused_part
	else:
		if main_part.targetable:
			return main_part
		else:
			for part in parts_queue.values():
				if part.targetable:
					return part
	
	return focused_part


#endregion

#region battle

var parts_queue:= {}

var turn_count = 0

func _on_turn_start():
	turn_count += 1
	get_tree().create_timer(0.5).timeout.connect(decide_intention)


func boss_act():
	focus_main_part()
	play_all_intentions()


func _on_main_part_dead():
	battle_manager.player_win()
	battle_manager.boss = null
	self.queue_free()


func buff_act_on_turn_end():
	for part in parts:
		part.buff_act_on_turn_end()


#region intentions

const INTENTION_PLAY_INTERVAL := 0.2


func decide_intention():
	pass


func set_part_intention(part:BasePart,intention:BaseIntention):
	part.set_intention(intention)

var pass_play = false

func play_all_intentions():
	if pass_play:
		all_intentions_played.emit()
	
	
	var tween := create_tween()
	for part in parts_queue.values():
		for intention in part.intentions:
			
			intention.act()
			
			tween.tween_callback(_on_focus_part.bind(part))
			tween.tween_callback(part.play_intention.bind(intention))
			tween.tween_interval(INTENTION_PLAY_INTERVAL)
	
	tween.finished.connect(all_intentions_played.emit)

signal all_intentions_played

#endregion

#endregion
