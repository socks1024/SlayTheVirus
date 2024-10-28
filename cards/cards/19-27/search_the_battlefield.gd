class_name SearchTheBattlefield
extends BaseCard


func initialize():
	
	id = "SEARCH_THE_BATTLEFIELD"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/26.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2(2,0),Vector2(-2,0)]
	shape_arrow = [Vector2.LEFT,Vector2.RIGHT]
	arrow_face = [Vector2.UP,Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number,base_magic_number]
	
	super()


func act():
	battle_manager.use(SearchExhaustedCardAction.new(card_target,battle_manager.player,magic_number,false))


func condition_act():
	for condition in conditions:
		if condition:
			battle_manager.use(GainTrashAction.new(card_target,battle_manager.player,magic_number,true,0))
