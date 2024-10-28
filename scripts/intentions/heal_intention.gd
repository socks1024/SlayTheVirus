class_name HealIntention
extends BaseIntention

func _init(amount:int,target:BaseCreature,source:BasePart):
	super(IntentionType.HEAL,amount,TargetType.BOSS,target,source)


func act():
	battle_manager.use(HealAction.new(target,source,amount))
