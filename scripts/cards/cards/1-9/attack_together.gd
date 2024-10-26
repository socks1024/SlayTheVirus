class_name AttackTogether
extends BaseCard


func initialize():
	
	id = "ATTACK_TOGETHER"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.ATTACK
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/3.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.UP,Vector2.RIGHT]
	shape_arrow = [Vector2.UP]
	arrow_face = [Vector2.UP]
	
	base_damage = 3
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage,base_damage]
	
	super()



func act():
	battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))


func condition_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))
