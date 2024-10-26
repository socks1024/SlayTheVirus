class_name Parry
extends BaseCard


func initialize():
	
	id = "PARRY"
	card_type_1 = CardType.DEFEND
	card_type_2 = CardType.ATTACK
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/15.png")
	
	shape = [Vector2.ZERO,Vector2.RIGHT,Vector2.DOWN,Vector2(1,1),Vector2(-1,1)]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.LEFT]
	
	base_damage = 4
	base_block = 4
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_block,base_damage]
	
	super()



func act():
	battle_manager.add_action_to_bot(DefenseAction.new(battle_manager.player,battle_manager.player,block))


func condition_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))
