class_name MagicNumberUpAction
extends BaseAction

var card:BaseCard
var amount:int

func _init(target:BaseCreature,source:BaseCreature,card:BaseCard,amount:int):
	super(target,source)
	self.card = card
	self.amount = amount


func act():
	card.magic_number_modifier += amount
