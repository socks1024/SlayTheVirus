class_name Epinephrine
extends BaseCard


func initialize():
	
	id = "EPINEPHRINE"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.BUFF
	
	img = preload("res://src/resources/cards/cards_imgs/19.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2(1,1),Vector2(-1,1)]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 2
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func condition_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(PlayAgainAction.new(card_target,battle_manager.player,location+shape_arrow[0]+arrow_face[0]))


func after_play_act():
	battle_manager.add_action_to_bot(ExhaustCardAction.new(card_target,battle_manager.player,self))
