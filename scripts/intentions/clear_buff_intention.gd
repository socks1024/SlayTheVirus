class_name ClearBuffIntention
extends BaseIntention

func _init(target:BaseCreature,source:BasePart):
	super(IntentionType.UNKNOWN,1,TargetType.BOSS,target,source)


func act():
	battle_manager.use(ClearBuffAction.new(target,source))
