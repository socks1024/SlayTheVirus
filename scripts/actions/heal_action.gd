class_name HealAction
extends BaseAction

var heal:int

func _init(target:BaseCreature,source:BaseCreature,heal:int):
	super(target,source)
	self.heal = heal


func act():
	
	target.health += heal
