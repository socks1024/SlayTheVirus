class_name CardPile
extends Node


signal card_pile_size_changed(cards_amount)

var cards: Array[BaseCard] = []

func empty() -> bool:
	return cards.is_empty()


func search_card(card_s:BaseCard):
	var j = 0
	for i in cards.size():
		if cards[i] == card_s:
			j = i
	
	var card = cards.pop_at(j)
	card_pile_size_changed.emit(cards.size())
	return card
	
	#for i in cards.size():
		#if cards[i] == card:
			#
			#var retCard = cards[i]
			#
			#cards.remove_at(i)
			#card_pile_size_changed.emit(cards.size())
			#
			#return retCard


func draw_card() -> BaseCard:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card


func add_card(card: BaseCard) -> void:
	cards.append(card)
	card_pile_size_changed.emit(cards.size())


func shuffle() -> void:
	cards.shuffle()


func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())


#func _to_string() -> String:
	#var _card_strings: PackedStringArray = []
	#for i in range(cards.size()):
		#_card_strings.append("%s: %s" % [i+1, cards[i].id])
	#return "\n".join(_card_strings)
