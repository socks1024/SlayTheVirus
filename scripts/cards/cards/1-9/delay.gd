class_name Delay
extends BaseCard


func initialize():
	
	id = "DELAY"
	card_type_1 = CardType.DEFEND
	card_type_2 = CardType.DEBUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/6.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2(1,1),Vector2.RIGHT]
	shape_arrow = [Vector2(1,1)]
	arrow_face = [Vector2.LEFT]
	
	base_damage = 0
	base_block = 2
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_block,base_magic_number]
	
	super()



func act():
	battle_manager.use(DefenseAction.new(battle_manager.player,battle_manager.player,block))


func condition_act():
	if conditions[0]:
		battle_manager.use(ApplyBuffAction.new(card_target,battle_manager.player,battle_manager.build_buff("inactivation",magic_number)))
