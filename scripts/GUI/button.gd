class_name ButtonFX
extends TextureButton

@onready var main = get_tree().root.get_child(0)

func _ready():
	self.button_up.connect(up)
	self.button_down.connect(down)

func up():
	self_modulate = Color(1,1,1)
	main.play_sound(main.press_button)

func down():
	self_modulate = Color(0.6,0.6,0.6)
	main.play_sound(main.press_button)
