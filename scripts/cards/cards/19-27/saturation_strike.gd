class_name SaturationStrike
extends BaseCard


func initialize():
	
	id = "SATURATION_STRIKE"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.ATTACK
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/25.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.DOWN,Vector2(1,1),Vector2(-1,-1),Vector2(-1,1)]
	shape_arrow = [Vector2(1,1),Vector2(-1,-1)]
	arrow_face = [Vector2.RIGHT,Vector2.UP]
	
	base_damage = 7
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage]
	
	super()



func condition_act():
	for condition in conditions:
		if condition:
			battle_manager.use(AttackAction.new(card_target,battle_manager.player,damage))

func after_play_act():
	battle_manager.use(ExhaustCardAction.new(card_target,battle_manager.player,self))
