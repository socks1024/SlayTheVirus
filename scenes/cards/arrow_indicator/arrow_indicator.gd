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
	self.look_at(target.global_position + target.texture_size/2)
	self.scale.x = (target.global_position + target.texture_size/2 - global_position).length()/height

#endregion
