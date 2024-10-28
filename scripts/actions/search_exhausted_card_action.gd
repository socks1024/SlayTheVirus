class_name SearchExhaustedCardAction
extends BaseAction

var is_random:bool
var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int,is_random:bool):
	super(target,source)
	self.amount = amount
	self.is_random = is_random


func act():
	main.battle_screen.choose_card_move_pile(main.player.exhausted_pile,main.player.draw_pile)
