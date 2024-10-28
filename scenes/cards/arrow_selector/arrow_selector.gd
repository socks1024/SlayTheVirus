class_name ArrowSelector
extends Node2D

@onready var main = get_tree().get_first_node_in_group("main")

var battle_manager
var height = 840


func _process(delta):
	select_target_process()


#region selector

var mouse_pos:Vector2

signal arrow_targeted(part:BaseCreature)

func select_target_process():
	mouse_pos = get_viewport().get_mouse_position()
	self.look_at(mouse_pos)
	
	self.scale.x = (mouse_pos - global_position).length()/height
	
	if Input.is_action_just_pressed("Drag Card"):
		var target:BaseCreature
		
		target = battle_manager.boss.get_targeted_part()
		
		arrow_targeted.emit(target)
		main.play_sound(main.equip_sound)
		self.queue_free()

#endregion
