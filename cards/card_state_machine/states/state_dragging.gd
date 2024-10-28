class_name StateDragging
extends BaseState

var id = "state_dragging_id"

## 进入到这个状态时
func enter(data:BaseCard):
	super(data)
	card_data.card_tetris_textures.show()

## 退出这个状态时
func exit():
	card_data.card_tetris_textures.hide()

## 执行到当前状态时，会切换为调用这个方法
func state_process(delta):
	card_data.global_position = card_data.get_viewport().get_mouse_position()
	
	get_location_in_board()
	
	if Input.is_action_just_pressed("Rotate Card"):
		card_data.rotate_tetris(PI/2)
	
	if Input.is_action_just_released("Drag Card"):
		if card_data.location != Vector2.ZERO && card_data.battle_manager.board.can_place(card_data):
			switch_to("state_placed_id",card_data)
		else:
			switch_to("state_hand_id",card_data)

func get_location_in_board():
	var board = card_data.battle_manager.board
	
	var location_in_board = Vector2.ZERO
	
	for cell in board.all_cells:
		var size = Vector2(50,50)
		
		#if (cell.global_position + Vector2(50,50) - card_data.get_viewport().get_mouse_position()).length() <= Vector2(50,50).length():
		if cell.global_position.distance_to(card_data.get_viewport().get_mouse_position()) < size.length()/2:
			location_in_board = cell.global_position
			print(cell.cell_pos)
	
	card_data.location = location_in_board

## 切换状态
func switch_to(state,data):
	state_machine.switch_to(state,data)
