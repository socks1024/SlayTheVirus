class_name DealDamageByLostHPAction
extends BaseAction

var position:Vector2

func _init(target:BaseCreature,source:BaseCreature):
	super(target,source)


func act():
	AttackAction.new(target,source,source.maxhealth - source.health).act()
