class_name BaseAction
extends Node

@onready var main = get_tree().get_first_node_in_group("main")

var target:BaseCreature
var source:BaseCreature

signal finished

func _init(target:BaseCreature,source:BaseCreature):
	self.target = target
	self.source = source


func use():
		act()
		act_show()
		queue_free()


func act():
	pass


func act_show():
	pass
