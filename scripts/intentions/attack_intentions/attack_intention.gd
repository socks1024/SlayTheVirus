class_name AttackIntention
extends BaseIntention

func _init(amount:int,target:BaseCreature,source:BasePart):
	super(IntentionType.ATTACK,amount,TargetType.PLAYER,target,source)


func act():
	battle_manager.use(AttackAction.new(target,source,amount))
