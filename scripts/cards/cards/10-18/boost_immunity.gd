class_name BoostImmunity
extends BaseCard


func initialize():
	
	id = "BOOST_IMMUNITY"
	card_type_1 = CardType.EXPAND
	card_type_2 = CardType.EXPAND
	target_type = TargetType.SELF
	ability_type = AbilityType.EXPAND
	
	img = preload("res://src/resources/cards/cards_imgs/17.png")
	
	shape = [Vector2.ZERO,Vector2.UP,Vector2.DOWN]
	shape_arrow = [Vector2.UP,Vector2.DOWN]
	arrow_face = [Vector2.UP,Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION")
	
	super()


func arrow_act():
	for i in conditions.size():
		if conditions[i]:
			battle_manager.use(EnableCellAction.new(card_target,battle_manager.player,cell_location+shape_arrow[i]+arrow_face[i],battle_manager.board))


func after_play_act():
	battle_manager.use(ExhaustCardAction.new(card_target,battle_manager.player,self))
