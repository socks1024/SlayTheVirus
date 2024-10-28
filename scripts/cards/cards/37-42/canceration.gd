class_name Canceration
extends BaseCard


func initialize():
	
	id = "CANCERATION"
	card_type_1 = CardType.TRASH
	card_type_2 = CardType.TRASH
	target_type = TargetType.SELF
	ability_type = AbilityType.TRASH
	
	img = preload("res://src/resources/cards/cards_imgs/42.png")
	
	shape = [Vector2.ZERO,Vector2.DOWN]
	shape_arrow = [] 
	arrow_face = []
	
	base_damage = 0
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func not_play_act():
	battle_manager.use(GainTrashAction.new(card_target,battle_manager.player,magic_number,true,""))
