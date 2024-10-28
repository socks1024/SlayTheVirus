class_name ApplyBuffIntention
extends BaseIntention

var id:String

func _init(amount:int,target:BaseCreature,source:BasePart,id:String):
	super(IntentionType.BUFF,amount,TargetType.PLAYER,target,source)
	self.id = id


func act():
	battle_manager.use(ApplyBuffAction.new(target,source,battle_manager.build_buff(id,amount)))