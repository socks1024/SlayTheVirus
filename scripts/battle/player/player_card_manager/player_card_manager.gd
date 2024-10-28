class_name PlayerCardManager
extends Node2D

const HAND_DRAW_INTERVAL := 0.25
const HAND_DISCARD_INTERVAL := 0.25
const HAND_PLAY_INTERVAL := 0.25

@export var hand_limit = 8

@onready var main = get_tree().get_first_node_in_group("main")
@onready var battle_screen = main.battle_screen
@onready var battle_manager = get_parent()

@onready var hand = $Hand
@onready var board = $Board

var player:Player

func connect_battle_signal():
	main.battle_screen.battle_start.connect(start_battle)
	
	main.battle_screen.turn_start.connect(start_turn)
	
	main.battle_screen.player_play_card.connect(player_end_turn)
	
	main.battle_screen.battle_end.connect(end_battle)
	#.connect(_on_card_played)


func start_battle() -> void:
	
	for c in hand.get_children():
		c.queue_free()
	
	#region card&player initialize
	
	player = main.player
	player.deck = main.master_deck
	player.buffs.clear()
	
	player.draw_pile = CardPile.new()
	for c in player.deck:
		player.draw_pile.add_card(main.get_card(c))
	player.draw_pile.shuffle()
	
	player.discard = CardPile.new()
	player.exhausted_pile = CardPile.new()
	
	#endregion
	
	board.initialize()


func start_turn() -> void:
	var draw_amount = player.get_cards_per_turn()
	if draw_amount > hand_limit:
		draw_amount = hand_limit
	if draw_amount < 0:
		draw_amount = 0
	draw_cards(draw_amount)


func player_end_turn() -> void:
	#hand.disable_hand()
	discard_cards()


func end_battle():
	player.buffs.clear()
	discard_cards()


#region hand & card piles

func draw_card() -> void:
	reshuffle_deck_from_discard()
	if !player.draw_pile.empty():
		hand.add_card(player.draw_pile.draw_card())
	reshuffle_deck_from_discard()


func draw_cards(amount: int) -> void:
	var tween := create_tween()
	for i in range(amount):
		tween.tween_callback(draw_card)
		tween.tween_interval(HAND_DRAW_INTERVAL)
	
	#tween.finished.connect(
		#func(): Events.player_hand_drawn.emit()
	#)

var negate_trash = false

func discard_cards() -> void:
	var empty_hand = true
	
	for c in hand.get_children():
		if c.card_state_machine.current_state == "state_hand_id":
			empty_hand = false
	
	if empty_hand:
		play_cards()
		return
	
	for card in hand.get_children():
		if card.card_state_machine.current_state == "state_hand_id" && !negate_trash:
			card.not_play_act()
	
	var tween := create_tween()
	for card: BaseCard in hand.get_children():
		if card.card_state_machine.current_state == "state_hand_id":
			tween.tween_callback(player.discard.add_card.bind(card))
			tween.tween_callback(hand.discard_card.bind(card))
			tween.tween_interval(HAND_DISCARD_INTERVAL)
	tween.finished.connect(play_cards)

func reshuffle_deck_from_discard() -> void:
	if not player.draw_pile.empty():
		return
	
	while not player.discard.empty():
		player.draw_pile.add_card(player.discard.draw_card())
	
	player.draw_pile.shuffle()

func _on_card_played(card: BaseCard) -> void:
	player.discard.add_card(card)

#endregion

#region board & placed card

signal cards_played

func play_cards():
	var cards_placed = board.get_cards_placed()
	
	if cards_placed.is_empty():
		cards_played.emit()
	
	for card in cards_placed:
		if card.acts_amount > 0:
			board.set_condition(card)
	
	for card in cards_placed:
		for i in card.acts_amount:
			card.arrow_act()
	
	#battle_manager.queue_act()
	
	var tween := create_tween()
	for card: BaseCard in cards_placed:
		if card.card_state_machine.current_state == "state_placed_id":
			
			for i in card.acts_amount:
				card.act()
				card.condition_act()
				card.after_play_act()
			
			card.set_modifier()
			#battle_manager.queue_finished.connect(func():battle_manager.boss._on_focus_part(battle_manager.boss.main_part))
			#battle_manager.queue_act()
			
			tween.tween_callback(board.remove_cell_card.bind(card))
			if card.exhausted:
				tween.tween_callback(player.exhausted_pile.add_card.bind(card))
			else:
				tween.tween_callback(player.discard.add_card.bind(card))
			tween.tween_callback(hand.play_card.bind(card))
			tween.tween_interval(HAND_PLAY_INTERVAL)
	
	
	#for card in cards_placed:
		#card.after_play_act()
	
	#battle_manager.queue_act()
	if battle_manager.boss is Boss:
		tween.finished.connect(func():battle_manager.boss._on_focus_part(battle_manager.boss.main_part))
	tween.finished.connect(cards_played.emit)
	#cards_played.emit()

#endregion
