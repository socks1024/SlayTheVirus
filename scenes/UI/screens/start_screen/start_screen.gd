class_name StartScreen
extends BaseScreen


#var watch_video = false
func enter():
	super()
	
	#if !watch_video:
		#watch_video = false
		#$VideoStreamPlayer/Timer.start()
	#else:
		#$VideoStreamPlayer.hide()

func _on_start_button_pressed():
	main.switch_screen(main.choose_level_screen)

func _on_settings_button_pressed():
	main.switch_screen(main.settings_screen)

func _on_credits_button_pressed():
	main.switch_screen(main.credits_screen)

func _on_exit_button_pressed():
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)

#region opening video

var has_VideoStreamPlayer = true

func _input(event):
	if has_VideoStreamPlayer:
		if event.is_action_pressed("Play Cards")||event.is_action_pressed("skip"):
			$VideoStreamPlayer.queue_free()
			has_VideoStreamPlayer = false

func _on_timer_timeout():
	main.camera.opening_video_shake()

func _on_video_stream_player_finished():
	#watch_video = true
	$VideoStreamPlayer.autoplay = false
	$VideoStreamPlayer.hide()
	self.show()

#endregion
