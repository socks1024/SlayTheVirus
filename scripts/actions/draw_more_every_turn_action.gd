class_name DrawMoreEveryTurnAction
extends BaseAction

var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int):
	super(target,source)
	self.amount = amount


func act():
	if target is Player:
		target.cards_per_turn += amount
