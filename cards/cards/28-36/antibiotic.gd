class_name Antibiotic
extends BaseCard


func initialize():
	
	id = "ANTIBIOTIC"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.BASIC
	
	img = preload("res://src/resources/cards/cards_imgs/34.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN,Vector2(1,1),Vector2(-1,1),Vector2(1,-1),Vector2(-1,-1)]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 0
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION")
	
	super()


func act():
	battle_manager.use(NegateTrashAction.new(card_target,battle_manager.player))
