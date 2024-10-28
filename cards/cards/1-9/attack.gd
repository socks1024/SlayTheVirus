class_name Attack
extends BaseCard


func initialize():
	
	id = "ATTACK"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.ATTACK
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.BASIC
	
	img = preload("res://src/resources/cards/cards_imgs/1.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.UP,Vector2.RIGHT]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 4
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage]
	
	super()



func act():
	#battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))
	battle_manager.use(AttackAction.new(card_target,battle_manager.player,damage))
