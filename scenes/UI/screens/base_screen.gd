class_name BaseScreen
extends Control

@onready var main = get_parent()

func enter():
	self.show()


func exit():
	self.hide()
	main.save_game()
