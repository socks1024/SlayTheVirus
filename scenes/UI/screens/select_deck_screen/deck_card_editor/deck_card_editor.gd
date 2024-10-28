class_name DeckCardEditor
extends Control

var card_id:String

signal change_card_in_deck(id:String,amount)
signal cancel_editor

var card_sample:BaseCard:
	set(card):
		card_sample = card
		add_child(card)
		card.card_state_machine.switch_to("state_in_deck_showed_id",card)
		card.position = self.position
		self.card_id = card.id


var count = 0:
	set(value):
		
		if value >= 3:
			value = 3
		
		count = value
		$Count.text = str(count)
		if count <= 0:
			cancel_editor.emit()
			self.queue_free()


func _on_more_pressed():
	change_card_in_deck.emit(card_id,1)


func _on_less_pressed():
	change_card_in_deck.emit(card_id,-1)
