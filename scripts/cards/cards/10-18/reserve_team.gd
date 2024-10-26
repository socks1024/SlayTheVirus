class_name ReserveTeam
extends BaseCard


func initialize():
	
	id = "RESERVE_TEAM"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/11.png")
	
	shape = [Vector2.ZERO,Vector2.RIGHT]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.LEFT]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 2
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()



func condition_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(DrawAction.new(card_target,battle_manager.player,magic_number))
