class_name StateHand
extends BaseState

var id = "state_hand_id"

#signal at_default_position

var default_position:Vector2

## 进入到这个状态时
func enter(data:BaseCard):
	super(data)
	
	#card_data.global_position = default_position
	#
	##回到默认位置
	#if card_data.use_default_position:
		#if default_position != card_data.global_position:
			#var t = card_data.get_tree().create_tween()
			#t.tween_property(card_data,"global_position",default_position,0.5)
			#t.finished.connect(func():at_default_position.emit())
	
	card_data.card_temp_textures.show()

## 退出这个状态时
func exit():
	card_data.card_temp_textures.hide()

## 执行到当前状态时，会切换为调用这个方法
func state_process(delta):
	if card_data.mouse_in && card_data.can_drag:
		if Input.is_action_just_pressed("Drag Card"):
			switch_to("state_dragging_id",card_data)

## 切换状态
func switch_to(state,data):
	state_machine.switch_to(state,data)
