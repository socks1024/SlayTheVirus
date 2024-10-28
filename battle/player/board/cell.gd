class_name Cell
extends Node2D

var cell_pos:Vector2

var active = false:set = set_active

func set_active(a:bool):
	active = a
	self.visible = !active



var has_card = false

var card:BaseCard:
	set(value):
		card = value
		if value is BaseCard:
			has_card = true
		else:
			has_card = false
