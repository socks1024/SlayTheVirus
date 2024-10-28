class_name DrawLessNextTurnAction
extends BaseAction

var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int):
	super(target,source)
	self.amount = amount


func act():
	main.battle_manager.use(DrawAction.new(target,source,-amount))
