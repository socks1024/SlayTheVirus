class_name PlayAgainAction
extends BaseAction

var position:Vector2

func _init(target:BaseCreature,source:BaseCreature,position:Vector2):
	super(target,source)
	self.position = position


func act():
	pass
