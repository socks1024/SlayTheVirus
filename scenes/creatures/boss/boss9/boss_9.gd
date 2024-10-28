class_name Boss9
extends Boss

@onready var brain_viru = $BrainViru
@onready var bubble = $Bubble
@onready var label = $Bubble/Label

@export var text1:String
@export var text2:String
@export var text3:String

func _ready():
	super()
	
	battle_manager.get_parent().enemy_stat_bar.health_bar.scale.x = 0.1
	
	pass_play = true
	
	parts_queue[brain_viru.part_id] = brain_viru
	parts_queue[bubble.part_id] = bubble


func decide_intention():
	
	match turn_count:
		1:
			label.text = text1
			brain_viru.img.texture = brain_viru.normal_img
		2:
			label.text = text2
			brain_viru.img.texture = brain_viru.angry_img
		3:
			label.text = text3
			brain_viru.img.texture = brain_viru.destroyed_img
		4:
			brain_viru.health = 0
