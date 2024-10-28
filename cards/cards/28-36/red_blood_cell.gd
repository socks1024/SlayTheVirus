class_name RedBloodCell
extends BaseCard


func initialize():
	
	id = "RED_BLOOD_CELL"
	card_type_1 = CardType.HEAL
	card_type_2 = CardType.HEAL
	target_type = TargetType.SELF
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/35.png")
	
	shape = [Vector2.ZERO,Vector2.UP,Vector2.DOWN]
	shape_arrow = [Vector2.DOWN]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 5
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func act():
	battle_manager.use(HealAction.new(battle_manager.player,battle_manager.player,magic_number))


func after_play_act():
	battle_manager.use(ExhaustCardAction.new(card_target,battle_manager.player,self))
