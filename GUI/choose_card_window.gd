class_name ChooseCardWindow
extends CardWindow

@onready var main = get_tree().get_first_node_in_group("main")

var to_pile:CardPile

func set_card_showcase():
	for c in card_showcase.get_children():
		if c != null:
			card_showcase.remove_child(c)
	
	for i in showcase_size:
		if showed_card_number + i < pile.cards.size():
			
			var card_p = pile.cards[showed_card_number + i]
			card_showcase.add_child(card_p)
			
			card_p.card_state_machine.current_state_node.switch_to("state_showed_id",card_p)
			card_p.change_card_in_deck.connect(_on_choose_card)
			
			
			#位置
			card_p.position.x = showcase_unit_x * (i % showcase_row_x + 1)
			card_p.position.y = showcase_unit_y


func _on_choose_card(id:String,amount:int):
	var card = main.get_card(id)
	to_pile.add_card(pile.search_card(card))
	hide_card_window()
