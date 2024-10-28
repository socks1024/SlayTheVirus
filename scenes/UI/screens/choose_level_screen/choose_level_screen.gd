class_name ChooseLevelScreen
extends BaseScreen

func _ready():
	for button in $LevelRoot.get_children():
		if button is BaseButton:
			level_buttons.append(button)
			button.disabled = true


func enter():
	super()
	
	if !secret_level_entered && levels_pass_condition[7]:
		enter_battle(9)
	
	refresh_levels()

func _on_return_pressed():
	main.switch_screen(main.start_screen)
	main.play_sound(main.press_button)

func _on_card_library_pressed():
	main.switch_screen(main.select_deck_screen)
	main.play_sound(main.press_button)

var level_buttons:Array[BaseButton]

#region level img

var lock:= preload("res://src/resources/GUI/levels/lock.png")

var lv1_1:= preload("res://src/resources/GUI/levels/level1-1.png")
var lv1_2:= preload("res://src/resources/GUI/levels/level1-2.png")
var lv1_3:= preload("res://src/resources/GUI/levels/level1-3.png")

var lv2_1:= preload("res://src/resources/GUI/levels/level2-1.png")
var lv2_2:= preload("res://src/resources/GUI/levels/level2-2.png")
var lv2_3:= preload("res://src/resources/GUI/levels/level2-3.png")

var lv3_1:= preload("res://src/resources/GUI/levels/level3-1.png")
var lv3_2:= preload("res://src/resources/GUI/levels/level3-2.png")
var lv3_3:= preload("res://src/resources/GUI/levels/level3-3.png")

var lv4_1:= preload("res://src/resources/GUI/levels/level4-1.png")
var lv4_2:= preload("res://src/resources/GUI/levels/level4-2.png")
var lv4_3:= preload("res://src/resources/GUI/levels/level4-3.png")

var lv5_1:= preload("res://src/resources/GUI/levels/level5-1.png")
var lv5_2:= preload("res://src/resources/GUI/levels/level5-2.png")
var lv5_3:= preload("res://src/resources/GUI/levels/level5-3.png")

var lv6_1:= preload("res://src/resources/GUI/levels/level6-1.png")
var lv6_2:= preload("res://src/resources/GUI/levels/level6-2.png")
var lv6_3:= preload("res://src/resources/GUI/levels/level6-3.png")

var lv7_1:= preload("res://src/resources/GUI/levels/level7-1.png")
var lv7_2:= preload("res://src/resources/GUI/levels/level7-2.png")
var lv7_3:= preload("res://src/resources/GUI/levels/level7-3.png")

var lv8_1:= preload("res://src/resources/GUI/levels/level8-1.png")
var lv8_2:= preload("res://src/resources/GUI/levels/level8-2.png")
var lv8_3:= preload("res://src/resources/GUI/levels/level8-3.png")

var unlocked_imgs = [lv1_1,lv2_1,lv3_1,lv4_1,lv5_1,lv6_1,lv7_1,lv8_1]
var tried_imgs = [lv1_2,lv2_2,lv3_2,lv4_2,lv5_2,lv6_2,lv7_2,lv8_2]
var passed_imgs = [lv1_3,lv2_3,lv3_3,lv4_3,lv5_3,lv6_3,lv7_3,lv8_3]

#endregion

#region level logic

var secret_level_entered = false

var level_amount = 8

var levels_unlock_condition = [true,false,false,false,false,false,false,false]
var levels_try_condition = [false,false,false,false,false,false,false,false]
var levels_pass_condition = [false,false,false,false,false,false,false,false]

func refresh_levels():
	for i in level_amount:
		if levels_unlock_condition[i]:
			_on_level_unlock(i+1)
		if levels_try_condition[i]:
			_on_level_try(i+1)
		if levels_pass_condition[i]:
			_on_level_pass(i+1)

func _on_level_unlock(index:int):
	if index <= level_amount:
		levels_unlock_condition[index - 1] = true
		level_buttons[index - 1].disabled = false
		level_buttons[index - 1].texture_normal = unlocked_imgs[index - 1]

func _on_level_try(index:int):
	if index <= level_amount:
		levels_try_condition[index - 1] = true
		level_buttons[index - 1].texture_normal = tried_imgs[index - 1]

func _on_level_pass(index:int):
	if !levels_pass_condition[index - 1]:
		main.select_deck_screen.unlock_card_list(index)
	if index <= level_amount:
		levels_pass_condition[index - 1] = true
		level_buttons[index - 1].texture_normal = passed_imgs[index - 1]


#region level button signal receivers

func _on_level_1_button_pressed():
	if levels_unlock_condition[0]:
		enter_battle(1)
		_on_level_try(1)

func _on_level_2_button_pressed():
	if levels_unlock_condition[1]:
		enter_battle(2)
		_on_level_try(2)

func _on_level_3_button_pressed():
	if levels_unlock_condition[2]:
		enter_battle(3)
		_on_level_try(3)

func _on_level_4_button_pressed():
	if levels_unlock_condition[3]:
		enter_battle(4)
		_on_level_try(4)

func _on_level_5_button_pressed():
	if levels_unlock_condition[4]:
		enter_battle(5)
		_on_level_try(5)

func _on_level_6_button_pressed():
	if levels_unlock_condition[5]:
		enter_battle(6)
		_on_level_try(6)

func _on_level_7_button_pressed():
	if levels_unlock_condition[6]:
		enter_battle(7)
		_on_level_try(7)

func _on_level_8_button_pressed():
	if levels_unlock_condition[7]:
		enter_battle(8)
		_on_level_try(8)

#endregion

func enter_battle(index:int):
	main.battle_screen.index = index
	main.switch_screen(main.battle_screen)

#endregion
