class_name AttackBlockUpAction
extends BaseAction

var card:BaseCard
var amount:int

func _init(target:BaseCreature,source:BaseCreature,card:BaseCard,amount:int):
	super(target,source)
	self.card = card
	self.amount = amount


func act():
	card.damage_modifier += amount
	card.block_modifier += amount
