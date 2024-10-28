class_name Reservist
extends BaseCard


func initialize():
	
	id = "RESERVIST"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.BASIC
	
	img = preload("res://src/resources/cards/cards_imgs/10.png")
	
	shape = [Vector2.ZERO]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 0
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()



func act():
	pass
	#battle_manager.use(DrawAction.new(battle_manager.player,battle_manager.player,magic_number))
