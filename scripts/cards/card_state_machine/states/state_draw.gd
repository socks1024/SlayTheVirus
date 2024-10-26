class_name StateDraw
extends BaseState

var id = "state_draw_id"

## 进入到这个状态时
func enter(data:BaseCard):
	super(data)
	card_data.card_temp_textures.show()
	card_data.can_drag = false

## 退出这个状态时
func exit():
	super()
	card_data.card_temp_textures.hide()
	card_data.can_drag = true

## 执行到当前状态时，会切换为调用这个方法
func state_process(delta):
	pass

## 切换状态
func switch_to(state,data):
	state_machine.switch_to(state,data)
