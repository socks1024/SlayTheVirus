class_name IllnessCharge
extends BaseCard


func initialize():
	
	id = "ILLNESS_CHARGE"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.BUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/23.png")
	
	shape = [Vector2.ZERO,Vector2.UP,Vector2.RIGHT,Vector2(1,1),Vector2(-1,-1)]
	shape_arrow = [Vector2.UP]
	arrow_face = [Vector2.RIGHT]
	
	base_damage = 9
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage,base_magic_number]
	
	super()


func act():
	battle_manager.use(AttackAction.new(card_target,battle_manager.player,damage))


func condition_act():
	if conditions[0]:
		battle_manager.use(GainTrashAction.new(battle_manager.player,battle_manager.player,magic_number,true,0))
