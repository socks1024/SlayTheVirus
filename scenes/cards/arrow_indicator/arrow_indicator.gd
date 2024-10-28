class_name ArrowIndicator
extends Node2D

var battle_manager
var height = 840

func indicate(t):
	modulate = confirmed_color
	target = t
	indicate_target_process()

#region indicator

var confirmed_color = Color(1,0.4,0.4)

var target:BasePart

func indicate_target_process():
	var size = Vector2(target.img.size.x * target.img.scale.x,target.img.size.y * target.img.scale.y) / 2
	self.look_at(target.global_position + size)
	self.scale.x = (target.global_position + size - global_position).length()/height

#endregion
