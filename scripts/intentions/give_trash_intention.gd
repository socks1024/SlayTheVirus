class_name GiveTrashIntention
extends BaseIntention

var id:String
var random:bool

func _init(amount:int,target:BaseCreature,source:BasePart,random:bool,id:String):
	super(IntentionType.DEBUFF,amount,TargetType.PLAYER,target,source)
	self.id = id
	self.random = random


func act():
	battle_manager.use(GainTrashAction.new(target,source,amount,random,id))
