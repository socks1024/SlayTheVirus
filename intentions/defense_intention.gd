class_name DefenseIntention
extends BaseIntention

func _init(amount:int,target:BaseCreature,source:BasePart):
	super(IntentionType.DEFENSE,amount,TargetType.BOSS,target,source)


func act():
	battle_manager.use(DefenseAction.new(target,source,amount))
