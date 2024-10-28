class_name GainDebuffIntention
extends BaseIntention

var id:String

func _init(amount:int,target:BaseCreature,source:BasePart,id:String):
	super(IntentionType.DEBUFF,amount,TargetType.BOSS,target,source)
	self.id = id


func act():
	battle_manager.use(ApplyBuffAction.new(target,source,battle_manager.build_buff(id,amount)))