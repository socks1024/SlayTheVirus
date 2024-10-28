class_name Main
extends Node

@onready var camera = $Camera2D
@onready var battle_manager = $"BattleScreen/BattleManager"

func _ready():
	var b = load_game()
	
	for i in choose_level_screen.levels_pass_condition.size():
		if choose_level_screen.levels_pass_condition[i]:
			select_deck_screen.unlock_card_list(i+1)
	
	battle_screen.level_unlock.connect(choose_level_screen._on_level_unlock)
	battle_screen.level_try.connect(choose_level_screen._on_level_try)
	battle_screen.level_pass.connect(choose_level_screen._on_level_pass)
	
	player.dead.connect(battle_manager.player_lose)
	
	current_screen = start_screen
	current_screen.enter()
	
	if !b:
		for i in master_deck_list:
			master_deck.append(card_list.keys()[i-1])
	
	player.initialize()
	battle_manager.player = player
	battle_manager.trash_cards = select_deck_screen.boss_8_unlocked_card_list
	
	
	change_music(main_opening)

#region global

var card_list:= {}
func get_card(id:String) -> BaseCard:
	return $CardBuilder.build_empty_card(card_list[id])

var master_deck:Array[String]

@onready var player = $PlayerNode

#endregion

#region screens & GUI
@onready var battle_screen = $BattleScreen
@onready var start_screen = $StartScreen
@onready var settings_screen = $SettingsScreen
@onready var choose_level_screen = $ChooseLevelScreen
@onready var select_deck_screen = $SelectDeckScreen
@onready var credits_screen = $CreditScreen
@onready var term_screen = $TermScreen

var current_screen

var in_battle = false

func switch_screen(new_screen:BaseScreen):
	
	current_screen.exit()
	current_screen = new_screen
	current_screen.enter()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit() 

#endregion

#region audio

@onready var bgm_player = $BGMPlayer
#@onready var se_player = $SEPlayer

#region bgm

var battle_1_loop = preload("res://src/resources/audio/Level/Level1_Loop.mp3")
var battle_1_opening = preload("res://src/resources/audio/Level/Level1_Opening.mp3")
var battle_2 = preload("res://src/resources/audio/Level/Level3.mp3")
var battle_3 = preload("res://src/resources/audio/Level/Level5.mp3")
var battle_4 = preload("res://src/resources/audio/Level/Level7.mp3")
var battle_5_loop = preload("res://src/resources/audio/Level/Level8_Loop.mp3")
var battle_5_opening = preload("res://src/resources/audio/Level/Level8_Opening.mp3")

var main_loop = preload("res://src/resources/audio/UI/MainTheme_Loop.mp3")
var main_opening = preload("res://src/resources/audio/UI/MainTheme_Opening.mp3")

#endregion

#region se

var press_button = preload("res://src/resources/audio/SFX/按钮点击1(Button Click 1)_爱给网_aigei_com.mp3")
var select_card = preload("res://src/resources/audio/SFX/select_card.MP3")
var go_sound = preload("res://src/resources/audio/SFX/Attack3.ogg")
var blow_sound = preload("res://src/resources/audio/SFX/Blow1.ogg")
var cancel_sound = preload("res://src/resources/audio/SFX/Cancel1.ogg")
var equip_sound = preload("res://src/resources/audio/SFX/Equip1.ogg")
var defense_sound = preload("res://src/resources/audio/SFX/Parry.ogg")
var shock_sound = preload("res://src/resources/audio/SFX/Shock2.ogg")
var victory_sound = preload("res://src/resources/audio/SFX/Victory2.ogg")
var heal_sound = preload("res://src/resources/audio/SFX/英雄恢复(hero_recover)_爱给网_aigei_com.mp3")

#endregion

func change_music(music):
	bgm_player.stream = music
	bgm_player.play()


func _on_bgm_player_finished():
	if bgm_player.stream == battle_1_opening:
		change_music(battle_1_loop)
	if bgm_player.stream == battle_5_opening:
		change_music(battle_5_loop)
	if bgm_player.stream == main_opening:
		change_music(main_loop)
	else:
		bgm_player.play()


func play_sound(sound):
	var se_player = AudioStreamPlayer.new()
	add_child(se_player)
	se_player.finished.connect(se_player.queue_free)
	se_player.stream = sound
	se_player.play()

#endregion

#region initialization

var master_deck_list = [1,1,1,2,2,2,17,35,9,5,6,10,10]

#endregion

#region save&load

var config = ConfigFile.new()

func save_game():
	config.set_value("Deck","master_deck",master_deck)
	config.set_value("Level","levels_unlock_condition",choose_level_screen.levels_unlock_condition)
	config.set_value("Level","levels_try_condition",choose_level_screen.levels_try_condition)
	config.set_value("Level","levels_pass_condition",choose_level_screen.levels_pass_condition)
	
	config.save("res://save.cfg")


func load_game() -> bool:
	var err = config.load("res://save.cfg")
	
	if err != OK:
		return false
	
	master_deck = config.get_value("Deck","master_deck")
	choose_level_screen.levels_unlock_condition = config.get_value("Level","levels_unlock_condition")
	choose_level_screen.levels_try_condition = config.get_value("Level","levels_try_condition")
	choose_level_screen.levels_pass_condition = config.get_value("Level","levels_pass_condition")
	
	return true


#endregion
