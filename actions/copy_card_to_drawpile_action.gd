class_name CopyCardToDrawpileAction
extends BaseAction

var amount:int
var card:BaseCard

func _init(target:BaseCreature,source:BaseCreature,amount:int,card:BaseCard):
	super(target,source)
	self.amount = amount
	self.card = card


func act():
	main.player.draw_pile.add_card(main.get_card(card.card_id))
