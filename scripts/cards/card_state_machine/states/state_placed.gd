class_name StatePlaced
extends BaseState

var selector_sample = preload("res://src/scenes/cards/arrow_selector/arrow_selector.tscn")
var indicator_sample = preload("res://src/scenes/cards/arrow_indicator/arrow_indicator.tscn")
var indicator

var id = "state_placed_id"

## 进入到这个状态时
func enter(data:BaseCard):
	super(data)
	card_data.global_position = card_data.location
	card_data.battle_manager.board.set_cell_card(card_data)
	card_data.card_tetris_textures.show()
	card_data.z_index -= 1;
	
	card_data.battle_manager.main.play_sound(card_data.battle_manager.main.equip_sound)
	
	if card_data.target_type == card_data.TargetType.SINGLE_PART:
		var selector = selector_sample.instantiate()
		selector.battle_manager = card_data.battle_manager
		selector.arrow_targeted.connect(card_data.get_target)
		card_data.add_child(selector)

## 退出这个状态时
func exit():
	card_data.battle_manager.board.remove_cell_card(card_data)
	card_data.card_tetris_textures.hide()
	card_data.z_index += 1
	
	card_data.battle_manager.main.play_sound(card_data.battle_manager.main.cancel_sound)

## 执行到当前状态时，会切换为调用这个方法
func state_process(delta):
	if card_data.mouse_in:
		
		card_data.battle_manager.get_parent().show_board_card(card_data)
		
		if card_data.card_target is BasePart:
			indicator = indicator_sample.instantiate()
			card_data.add_child(indicator)
			card_data.mouse_exited.connect(indicator.queue_free)
			indicator.indicate(card_data.card_target)
		
		if Input.is_action_just_pressed("Drag Card"):
			switch_to("state_dragging_id",card_data)
			if indicator != null:
				indicator.queue_free()
		
		
	#else:
		#if indicator != null:
			#card_data.remove_child(indicator)
			#indicator.queue_free()

## 切换状态
func switch_to(state,data):
	state_machine.switch_to(state,data)
