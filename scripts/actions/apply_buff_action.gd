class_name ApplyBuffAction
extends BaseAction

var buff:BaseBuff

func _init(target:BaseCreature,source:BaseCreature,buff:BaseBuff):
	super(target,source)
	self.buff = buff


func act():
	target.gain_buff(buff)
