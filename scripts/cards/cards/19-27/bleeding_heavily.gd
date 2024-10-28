class_name BleedingHeavily
extends BaseCard


func initialize():
	
	id = "BLEEDING_HEAVILY"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/20.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2(1,-1),Vector2(-1,1)]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 3
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()



func condition_act():
	if conditions[0]:
		battle_manager.use(ApplyBuffAction.new(card_target,battle_manager.player,battle_manager.build_buff("vulnerable",magic_number)))
