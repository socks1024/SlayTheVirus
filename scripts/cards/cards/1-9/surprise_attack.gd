class_name SurpriseAttack
extends BaseCard


func initialize():
	
	id = "SURPRISE_ATTACK"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.DEBUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/5.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2(-1,1),Vector2.RIGHT]
	shape_arrow = [Vector2(-1,1)]
	arrow_face = [Vector2.RIGHT]
	
	base_damage = 2
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage,base_magic_number]
	
	super()



func act():
	battle_manager.use(AttackAction.new(card_target,battle_manager.player,damage))


func condition_act():
	if conditions[0]:
		battle_manager.use(ApplyBuffAction.new(card_target,battle_manager.player,battle_manager.build_buff("vulnerable",magic_number)))
