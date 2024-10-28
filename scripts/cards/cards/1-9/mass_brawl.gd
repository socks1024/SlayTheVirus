class_name MassBrawl
extends BaseCard


func initialize():
	
	id = "MASS_BRAWL"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.ATTACK
	target_type = TargetType.ALL_PART
	ability_type = AbilityType.BASIC
	
	img = preload("res://src/resources/cards/cards_imgs/9.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2(2,0)]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 4
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage]
	
	super()


func act():
	var all_part = battle_manager.boss.parts
	
	for part in all_part:
		battle_manager.use(AttackAction.new(part,battle_manager.player,damage))
