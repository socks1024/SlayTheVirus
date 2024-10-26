class_name StemCell
extends BaseCard


func initialize():
	
	id = "STEM_CELL"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.BUFF
	
	img = preload("res://src/resources/cards/cards_imgs/27.png")
	
	shape = [Vector2.ZERO,Vector2.DOWN]
	shape_arrow = [Vector2.DOWN]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func arrow_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(CopyCardToDrawpileAction.new(card_target,battle_manager.player,magic_number,location+shape_arrow[0]+arrow_face[0]))

func after_play_act():
	battle_manager.add_action_to_bot(ExhaustCardAction.new(card_target,battle_manager.player,self))
