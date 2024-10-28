class_name Player
extends BaseCreature

var player_name = "免疫系统"
var player_mhp = 25

func initialize():
	self.creature_name = player_name
	self.maxhealth = player_mhp
	self.health = player_mhp
	
	id = "player"

var starting_deck: CardPile

var cards_per_turn_modifier = 0
var cards_per_turn = 5

func get_cards_per_turn():
	var c = cards_per_turn + cards_per_turn_modifier
	cards_per_turn_modifier = 0
	return c

var deck: Array[String]
var discard: CardPile
var draw_pile: CardPile
var exhausted_pile:CardPile


#func create_instance() -> Resource:
	#var instance: CharacterStats = self.duplicate()
	#instance.health = max_health
	#instance.block = 0
	#instance.reset_mana()
	#instance.deck = instance.starting_deck.duplicate()
	#instance.draw_pile = CardPile.new()
	#instance.discard = CardPile.new()
	#return instance
