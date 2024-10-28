class_name DefendTogether
extends BaseCard


func initialize():
	
	id = "DEFEND_TOGETHER"
	card_type_1 = CardType.DEFEND
	card_type_2 = CardType.DEFEND
	target_type = TargetType.SELF
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/4.png")
	
	shape = [Vector2.ZERO,Vector2.RIGHT,Vector2.DOWN,Vector2(1,1)]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.ZERO]
	
	base_damage = 0
	base_block = 3
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_block,base_block]
	
	super()



func act():
	battle_manager.use(DefenseAction.new(battle_manager.player,battle_manager.player,block))


func condition_act():
	if conditions[0]:
		battle_manager.use(DefenseAction.new(battle_manager.player,battle_manager.player,block))
