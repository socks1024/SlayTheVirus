class_name CopyCardToDrawpileAction
extends BaseAction

var position:Vector2
var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int,position:Vector2):
	super(target,source)
	self.position = position
	self.amount = amount


func act():
	pass
