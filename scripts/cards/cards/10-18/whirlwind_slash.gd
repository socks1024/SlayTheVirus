class_name WhirlwindSlash
extends BaseCard


func initialize():
	
	id = "WHIRLWIND_SLASH"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.BUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/18.png")
	
	shape = [Vector2.ZERO,Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT]
	shape_arrow = [Vector2.UP,Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT]
	arrow_face = [Vector2.LEFT,Vector2.UP,Vector2.RIGHT,Vector2.DOWN]
	
	base_damage = 3
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage,base_magic_number]
	
	super()



func act():
	battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))


func condition_act():
	for condition in conditions:
		if condition:
			battle_manager.add_action_to_bot(ApplyBuffAction.new(card_target,battle_manager.player,battle_manager.build_buff("trauma",magic_number)))
