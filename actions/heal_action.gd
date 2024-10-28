class_name HealAction
extends BaseAction

var heal:int

func _init(target:BaseCreature,source:BaseCreature,heal:int):
	super(target,source)
	self.heal = heal


func act():
	
	target.health += heal

func act_show():
	super()
	if target is BasePart && main.battle_manager.boss != null:
		main.battle_manager.boss._on_focus_part_with_color(target,Color(0.4,1,0.4))
	main.play_sound(main.heal_sound)
