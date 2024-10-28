class_name PlayAgainAction
extends BaseAction

var card:BaseCard
var amount:int

func _init(target:BaseCreature,source:BaseCreature,card:BaseCard,amount:int):
	super(target,source)
	self.card = card
	self.amount = amount


func act():
	card.acts_amount += amount
