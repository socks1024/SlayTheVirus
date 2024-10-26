class_name Inspire
extends BaseCard


func initialize():
	
	id = "INSPIRE"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.BUFF
	
	img = preload("res://src/resources/cards/cards_imgs/11.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.UP]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()



func arrow_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(MagicNumberUpAction.new(card_target,battle_manager.player,location+shape_arrow[0]+arrow_face[0]))
