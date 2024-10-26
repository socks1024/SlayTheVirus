class_name Bioelectricity
extends BaseCard


func initialize():
	
	id = "BIOELECTRICITY"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.DEBUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/8.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2(1,1),Vector2.DOWN]
	shape_arrow = [Vector2.LEFT]
	arrow_face = [Vector2.LEFT]
	
	base_damage = 2
	base_block = 0
	base_magic_number = 2
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number, base_damage]
	
	super()



func act():
	battle_manager.add_action_to_bot(ApplyBuffAction.new(card_target,battle_manager.player,battle_manager.build_buff("paralysis",magic_number)))

func condition_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))
