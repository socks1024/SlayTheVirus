class_name RenewalOrgan
extends BaseCard


func initialize():
	
	id = "RENEWAL_ORGAN"
	card_type_1 = CardType.HEAL
	card_type_2 = CardType.HEAL
	target_type = TargetType.SELF
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/36.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2(1,1),Vector2(-1,1),Vector2(1,-1),Vector2(-1,-1)]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 5
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number,base_magic_number]
	
	super()


func act():
	battle_manager.use(HealAction.new(battle_manager.player,battle_manager.player,magic_number))

func condition_act():
	if conditions[0]:
		battle_manager.use(HealAction.new(battle_manager.player,battle_manager.player,magic_number))
