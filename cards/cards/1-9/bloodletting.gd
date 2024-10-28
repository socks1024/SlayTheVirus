class_name Bloodletting
extends BaseCard


func initialize():
	
	id = "BLOODLETTING"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.DEBUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/7.png")
	
	shape = [Vector2.ZERO,Vector2.DOWN,Vector2(-1,1),Vector2.RIGHT]
	shape_arrow = [Vector2.RIGHT]
	arrow_face = [Vector2.RIGHT]
	
	base_damage = 2
	base_block = 0
	base_magic_number = 2
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number,base_damage]
	
	super()


func act():
	battle_manager.use(ApplyBuffAction.new(card_target,battle_manager.player,battle_manager.build_buff("trauma",magic_number)))

func condition_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))
