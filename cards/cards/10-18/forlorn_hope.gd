class_name ForlornHope
extends BaseCard


func initialize():
	
	id = "FORLORN_HOPE"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.DEBUFF
	
	img = preload("res://src/resources/cards/cards_imgs/14.png")
	
	shape = [Vector2.ZERO,Vector2.DOWN,Vector2.RIGHT]
	shape_arrow = [Vector2.DOWN]
	arrow_face = [Vector2.RIGHT]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 3
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func arrow_act():
	if conditions[0]:
		battle_manager.use(NegateAction.new(battle_manager.player,battle_manager.player,condition_cards[0]))



func act():
	battle_manager.use(DrawAction.new(battle_manager.player,battle_manager.player,magic_number))
