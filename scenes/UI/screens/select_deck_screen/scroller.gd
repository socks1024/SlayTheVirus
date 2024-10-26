class_name Scroller
extends VSlider

#var mouse_in = false
#
#var top_limit = 160
#var bot_limit = 980
#
#func _on_mouse_entered():
	#mouse_in = true
#
#
#func _on_mouse_exited():
	#mouse_in = false
#
var dragging = false


signal scrolling(ratio:float)

func _process(delta):
	#if Input.is_action_just_pressed("Drag Card") && mouse_in:
		#dragging = true
	#elif Input.is_action_just_released("Drag Card"):
		#dragging = false
	#
	#if dragging:
		#if global_position.y >= top_limit && global_position.y <= bot_limit:
			#global_position.y = get_viewport().get_mouse_position().y - size.y / 2
		#elif global_position.y < top_limit:
			#global_position.y = top_limit
		#elif global_position.y > bot_limit:
			#global_position.y = bot_limit
	if dragging:
		scrolling.emit(ratio)


func _on_drag_ended(value_changed):
	var dragging = true


func _on_drag_started():
	var dragging = false
