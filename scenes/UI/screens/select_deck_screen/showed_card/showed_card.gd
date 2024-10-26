class_name ShowedCard
extends Control

var showed_card_id:String

signal pressed(showed_card_id)

func _on_button_pressed():
	pressed.emit(showed_card_id)
