class_name Fever
extends BaseCard


func initialize():
	
	id = "FEVER"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.BUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/16.png")
	
	shape = [Vector2.ZERO,Vector2.UP,Vector2.DOWN,Vector2(1,1),Vector2(-1,1)]
	shape_arrow = [Vector2(1,1),Vector2(-1,1)]
	arrow_face = [Vector2.UP,Vector2.UP]
	
	base_damage = 5
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number,base_damage]
	
	super()



func act():
	battle_manager.add_action_to_bot(ApplyBuffAction.new(battle_manager.player,battle_manager.player,battle_manager.build_buff("vulnerable",magic_number)))


func condition_act():
	for condition in conditions:
		if condition:
			battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))
