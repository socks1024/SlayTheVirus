class_name SettingsScreen
extends BaseScreen

func _ready():
	$Operation.self_modulate = Color(0.4,0.4,0.4)
	$Game.self_modulate = Color(1,1,1)


#region volume settings

var bus_id = AudioServer.get_bus_index("Master")


func _on_main_slider_value_changed(value):
	bus_id = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_id,linear_to_db(value))


func _on_music_slider_value_changed(value):
	bus_id = AudioServer.get_bus_index("BGM")
	AudioServer.set_bus_volume_db(bus_id,linear_to_db(value))


func _on_sound_slider_value_changed(value):
	bus_id = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(bus_id,linear_to_db(value))

#endregion


func _on_game_pressed():
	$GameRoot.show()
	$OperationRoot.hide()
	$Operation.self_modulate = Color(0.4,0.4,0.4)
	$Game.self_modulate = Color(1,1,1)
	main.play_sound(main.press_button)


func _on_operation_pressed():
	$GameRoot.hide()
	$OperationRoot.show()
	$Operation.self_modulate = Color(1,1,1)
	$Game.self_modulate = Color(0.4,0.4,0.4)
	main.play_sound(main.press_button)


func _on_return_pressed():
	if main.in_battle:
		main.switch_screen(main.battle_screen)
	else:
		main.switch_screen(main.start_screen)
	main.play_sound(main.press_button)


#region display settings

var fullscreen = true

func _on_check_box_pressed():
	main.play_sound(main.press_button)
	if !fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false


func _on_language_option_button_item_selected(index):
	main.play_sound(main.press_button)
	match index:
		0:
			TranslationServer.set_locale("zh")
		1:
			#TranslationServer.set_locale("en")
			pass


func _on_resolution_option_button_item_selected(index):
	main.play_sound(main.press_button)
	match index:
		0:
			DisplayServer.window_set_size(Vector2(2560,1440))
		1:
			DisplayServer.window_set_size(Vector2(1920,1080))



func _on_term_button_pressed():
	main.switch_screen(main.term_screen)

#endregion
