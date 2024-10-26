class_name Defend
extends BaseCard


func initialize():
	super()
	
	id = "DEFEND"
	card_type_1 = CardType.DEFEND
	card_type_2 = CardType.DEFEND
	target_type = TargetType.SELF
	ability_type = AbilityType.BASIC
	
	img = preload("res://src/resources/cards/cards_imgs/2.png")
	
	shape = [Vector2.ZERO,Vector2.RIGHT,Vector2.DOWN,Vector2(1,1)]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 0
	base_block = 4
	base_magic_number = 0
	
	card_description = tr(id + "_DESCRIPTION") % [base_block]
	
	super()



func act():
	battle_manager.add_action_to_bot(DefenseAction.new(card_target,battle_manager.player,block))
