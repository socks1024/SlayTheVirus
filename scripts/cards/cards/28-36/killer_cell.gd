class_name KillerCell
extends BaseCard


func initialize():
	
	id = "KILLER_CELL"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.DEBUFF
	
	img = preload("res://src/resources/cards/cards_imgs/28.png")
	
	shape = [Vector2.ZERO,Vector2.DOWN]
	shape_arrow = [Vector2.DOWN]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION")
	
	super()


func after_play_act():
	if conditions[0]:
		battle_manager.use(ExhaustCardAction.new(card_target,battle_manager.player,condition_cards[0]))
	
	battle_manager.use(ExhaustCardAction.new(card_target,battle_manager.player,self))
