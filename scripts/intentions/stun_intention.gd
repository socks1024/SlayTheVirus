class_name StunIntention
extends BaseIntention

func _init(target:BaseCreature,source:BasePart):
	super(IntentionType.STUN,1,TargetType.BOSS,target,source)


func act():
	pass
