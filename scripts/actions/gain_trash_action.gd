class_name GainTrashAction
extends BaseAction

var is_random:bool
var trash_id:String
var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int,is_random:bool,id:String):
	super(target,source)
	self.amount = amount
	self.is_random = is_random
	self.trash_id = id


func act():
	pass
