class_name GainTrashAction
extends BaseAction

var is_random:bool
var trash_index:int
var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int,is_random:bool,index:int):
	super(target,source)
	self.amount = amount
	self.is_random = is_random
	self.trash_index = index


func act():
	main.battle_manager.gain_trash(amount,is_random,trash_index)
