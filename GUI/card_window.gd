class_name CardWindow
extends Control

var pile:CardPile

func show_card_window():
	pile.shuffle()
	showed_card_number = 0
	set_card_showcase()
	show()



func hide_card_window():
	for c in card_showcase.get_children():
		if c != null:
			card_showcase.remove_child(c)
	if pile != null:
		pile.shuffle()
	hide()

@onready var card_showcase = $CardShowcase

var showcase_unit_x = 250
var showcase_row_x = 3#列
var showcase_unit_y = 200
var showcase_size = showcase_row_x

var showed_card_number = 0#左上角的展示牌

func set_card_showcase():
	for c in card_showcase.get_children():
		if c != null:
			card_showcase.remove_child(c)
	
	for i in showcase_size:
		if showed_card_number + i < pile.cards.size():
			
			var card_p = pile.cards[showed_card_number + i]
			card_showcase.add_child(card_p)
			
			card_p.card_state_machine.current_state_node.switch_to("state_draw_id",card_p)
			
			
			
			#位置
			card_p.position.x = showcase_unit_x * (i % showcase_row_x + 1)
			card_p.position.y = showcase_unit_y
			
			card_p.rotation = 0

func _on_page_up_button_pressed():
	
	if showed_card_number + showcase_size < pile.cards.size():
		
		showed_card_number += showcase_size
		
		
		set_card_showcase()


func _on_page_down_button_pressed():
	
	if showed_card_number - showcase_size >= 0:
		
		showed_card_number -= showcase_size
		
		
		set_card_showcase()


func _on_return_button_pressed():
	hide_card_window()
