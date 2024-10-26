class_name Cell
extends Node2D

var active = false

func set_active(a:bool):
	active = a
	if active:
		self.hide()
	else:
		self.show()



var has_card:bool

var card:BaseCard
