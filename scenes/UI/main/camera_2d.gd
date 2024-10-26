extends Camera2D

@export var camera_shake_noise:FastNoiseLite

func _on_go_pressed():
	var t = get_tree().create_tween()
	t.tween_method(camera_shake,5.0,1.0,0.2)



func camera_shake(intensity):
	var cameraOffset = camera_shake_noise.get_noise_1d(Time.get_ticks_msec()) * intensity
	offset.x = cameraOffset
	cameraOffset = camera_shake_noise.get_noise_1d(Time.get_ticks_msec()) * intensity
	offset.y = cameraOffset


func opening_video_shake():
	var t = get_tree().create_tween()
	t.tween_method(camera_shake,100.0,1.0,0.7)
