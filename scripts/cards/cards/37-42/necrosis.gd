class_name Necrosis
extends BaseCard


func initialize():
	
	id = "NECROSIS"
	card_type_1 = CardType.TRASH
	card_type_2 = CardType.TRASH
	target_type = TargetType.SELF
	ability_type = AbilityType.TRASH
	
	img = preload("res://src/resources/cards/cards_imgs/39.png")
	
	shape = [Vector2.ZERO,Vector2.DOWN,Vector2.RIGHT]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 0
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION")
	
	super()


func not_play_act():
	battle_manager.add_action_to_bot(NegateArrowAction.new(card_target,battle_manager.player))

func after_play_act():
	battle_manager.add_action_to_bot(ExhaustCardAction.new(card_target,battle_manager.player,self))
