class_name Hand
extends Node2D


func _process(delta):
	dragged_card_return()


func dragged_card_return():
	for i in get_child_count():
		var card = get_child(i)
		
		var final_pos: Vector2 = -(card.size / 2.0) - Vector2(card_offset_x * (hand_count - (i+1)), 0.0)
		final_pos.x += ((card_offset_x * (hand_count-1)) / 2.0) 
		
		if card.card_state_machine.current_state == "state_hand_id" && card.position != final_pos:
			
			card.position = final_pos
			#if tween and tween.is_running():
				#tween.kill()
			#tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
			#
			#
			## Animate pos
			#tween.parallel().tween_property(card, "position", final_pos, 0.3 + (i * 0.075))


@export var card_offset_x: float = 200.0
@export var rot_max: float = 0.2
@export var time_multiplier: float = 2.0
@onready var draw_position = $"../../../DrawPile".global_position
@onready var discard_position = $"../../../DiscardPile".global_position
@export var enemy_position:Vector2
@export var player_position:Vector2

var tween: Tween

var hand_count:int

func add_card(new_card: BaseCard) -> void:
	
	new_card.card_state_machine.switch_to("state_draw_id",new_card)
	add_child(new_card)
	new_card.global_position = draw_position
	hand_count = get_child_count()
	
	#region hand card animation
	
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	
	for i in get_child_count():
		var card = get_child(i)
		
		var final_pos: Vector2 = -(card.size / 2.0) - Vector2(card_offset_x * (hand_count - (i+1)), 0.0)
		final_pos.x += ((card_offset_x * (hand_count-1)) / 2.0) 
		
		var rot_radians: float = lerp_angle(-rot_max, rot_max, float(i)/float(hand_count-1))
		
		# Animate pos
		tween.parallel().tween_property(card, "position", final_pos, 0.3 + (i * 0.075))
		tween.parallel().tween_property(card.card_temp_textures, "rotation", rot_radians, 0.3 + (i * 0.075))
		
		tween.finished.connect(func():card.card_state_machine.switch_to("state_hand_id",card))
	
	#for n in get_children():
		#n.card_state_machine.switch_to("state_hand_id",n)
	
	#endregion


func discard_card(card: BaseCard) -> void:
	
	card.card_state_machine.switch_to("state_draw_id",card)
	
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	
	tween.parallel().tween_property(card, "position", discard_position, 0.2)
	
	
	tween.finished.connect(func():remove_child(card))


var play_tween:Tween

func play_card(card:BaseCard) -> void:
	if play_tween and play_tween.is_running():
		play_tween.set_parallel(true)
	play_tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	
	if card.target_type == card.TargetType.SELF:
		play_tween.parallel().tween_property(card, "global_position", player_position, 0.2)
	else:
		play_tween.parallel().tween_property(card, "global_position", enemy_position, 0.2)
	
	play_tween.finished.connect(func():remove_child(card))
