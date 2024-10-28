class_name NegateAction
extends BaseAction

var card:BaseCard

func _init(target:BaseCreature,source:BaseCreature,card:BaseCard):
	super(target,source)
	self.card = card


func act():
	card.acts_amount = 0
