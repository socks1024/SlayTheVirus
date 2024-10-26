class_name DefenseAction
extends BaseAction

var block:int

func _init(target:BaseCreature,source:BaseCreature,block:int):
	super(target,source)
	self.block = block


func act():
	block -= source.get_buff_amount("paralysis")
	
	target.block += block
