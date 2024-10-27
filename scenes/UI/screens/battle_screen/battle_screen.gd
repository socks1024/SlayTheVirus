class_name BattleScreen
extends BaseScreen

var index = 1

@onready var enemy_stat_bar = $BattleManager/EnemyStatBar
@onready var player_stat_bar = $BattleManager/PlayerStatBar
@onready var battle_manager = $BattleManager


func enter():
	super()
	if !main.in_battle:
		hide_all_card_window()
		initialize_battle()
		main.in_battle = true
	
	main.change_music(music)

func exit():
	super()
	main.change_music(main.main_opening)

var music

func initialize_battle():
	
	
	var boss:Boss
	match index:
		1:
			boss = boss_1.instantiate()
			music = main.battle_1_opening
		2:
			boss = boss_1.instantiate()
			#boss = boss_2.instantiate()
			music = main.battle_1_opening
		3:
			boss = boss_1.instantiate()
			#boss = boss_3.instantiate()
			music = main.battle_2
		4:
			boss = boss_1.instantiate()
			#boss = boss_4.instantiate()
			music = main.battle_2
		5:
			boss = boss_1.instantiate()
			#boss = boss_5.instantiate()
			music = main.battle_3
		6:
			boss = boss_1.instantiate()
			#boss = boss_6.instantiate()
			music = main.battle_3
		7:
			boss = boss_1.instantiate()
			#boss = boss_7.instantiate()
			music = main.battle_4
		8:
			boss = boss_1.instantiate()
			#boss = boss_8.instantiate()
			music = main.battle_5_opening
	
	for b in $BattleManager/MonsterManager.get_children():
		b.queue_free()
	$BattleManager/MonsterManager.add_child(boss)
	battle_manager.boss = boss
	turn_start.connect(boss._on_turn_start)
	enemy_parts_act.connect(boss.boss_act)
	boss.all_intentions_played.connect(turn_end.emit)
	turn_end.connect(_on_turn_end)
	
	$BattleManager/PlayerCardManager.connect_battle_signal()
	
	player_stat_bar.connect_creature(main.player)
	enemy_stat_bar.connect_creature(boss.main_part)
	
	
	#battle_manager
	turn_end.connect(battle_manager.boss.buff_act_on_turn_end)
	turn_end.connect(battle_manager.player.buff_act_on_turn_end)
	
	battle_start.emit()
	turn_start.emit()

signal level_unlock(index:int)
signal level_try(index:int)
signal level_pass(index:int)

#region resource

@export var boss_1:PackedScene
@export var boss_2:PackedScene
@export var boss_3:PackedScene
@export var boss_4:PackedScene
@export var boss_5:PackedScene
@export var boss_6:PackedScene
@export var boss_7:PackedScene
@export var boss_8:PackedScene
@export var boss_9:PackedScene

var boss_1_background:= preload("res://src/resources/board/back1.png")
var boss_2_background:= preload("res://src/resources/board/back1.png")
var boss_3_background:= preload("res://src/resources/board/back1.png")
var boss_4_background:= preload("res://src/resources/board/back1.png")
var boss_5_background:= preload("res://src/resources/board/back1.png")
var boss_6_1_background:= preload("res://src/resources/board/back1.png")
var boss_6_2_background:= preload("res://src/resources/board/back1.png")
var boss_6_3_background:= preload("res://src/resources/board/back1.png")
var boss_7_background:= preload("res://src/resources/board/back1.png")
var boss_8_background:= preload("res://src/resources/board/back1.png")
var boss_9_background:= preload("res://src/resources/board/back1.png")

var win_texture:= preload("res://src/resources/intention&table/win.png")
var lose_texture:= preload("res://src/resources/intention&table/lose.png")

#endregion

#region buttons

func _on_return_pressed():
	main.switch_screen(main.choose_level_screen)
	main.in_battle = false


func _on_settings_pressed():
	main.switch_screen(main.settings_screen)


func _on_go_button_pressed():
	main.play_sound(main.go_sound)
	main.camera._on_go_pressed()
	player_play_card.emit()


#func _input(event):
	#if self.visible && event.is_action_pressed("Play Cards"):
		#$GoButton.button_pressed = true
	#if self.visible && event.is_action_released("Play Cards"):
		#$GoButton.button_pressed = false


func _on_draw_pile_pressed():
	hide_all_card_window()
	set_card_window(main.player.draw_pile,$DrawWindow)


func _on_discard_pile_pressed():
	hide_all_card_window()
	set_card_window(main.player.discard,$DiscardWindow)


func _on_exhaust_pile_pressed():
	hide_all_card_window()
	set_card_window(main.player.exhausted_pile,$ExhaustWindow)

#endregion

#region BATTLE_PROCESS

signal battle_start
signal battle_end(win:bool)

signal turn_start
signal player_play_card
signal enemy_parts_act
signal turn_end

func _on_turn_end():
	get_tree().create_timer(0.5).timeout.connect(turn_start.emit)

func _on_battle_end(win:bool):
	if win:
		level_pass.emit(index)
		level_unlock.emit(index + 1)
		$WinOrLose.texture = win_texture
		main.play_sound(main.victory_sound)
	else:
		$WinOrLose.texture = lose_texture
		main.play_sound(main.shock_sound)
	
	$WinOrLose.show()
	
	var timer = get_tree().create_timer(4)
	timer.timeout.connect($WinOrLose.hide)
	timer.timeout.connect(main.switch_screen.bind(main.choose_level_screen))

#endregion

#region card & board

func show_board_card(card):
	if card is BaseCard:
		if $ShowedBoardCard.get_child(0) is BaseCard:
			$ShowedBoardCard.get_child(0).queue_free()
		
		var c = main.get_card(card.id)
		$ShowedBoardCard.add_child(c)
		c.card_state_machine.switch_to("state_in_deck_showed_id",c)


func set_card_window(pile:CardPile,window:CardWindow):
	window.pile = pile
	window.show_card_window()

func hide_all_card_window():
	$DrawWindow.hide_card_window()
	$DiscardWindow.hide_card_window()
	$ExhaustWindow.hide_card_window()
	$ChooseCardWindow.hide_card_window()

func choose_card_move_pile(from_pile:CardPile,to_pile:CardPile):
	$ChooseCardWindow.pile = from_pile
	$ChooseCardWindow.to_pile = to_pile
	$ChooseCardWindow.show_card_window()

#endregion
