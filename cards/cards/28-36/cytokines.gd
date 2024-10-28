class_name Cytokines
extends BaseCard


func initialize():
	
	id = "CYTOKINES"
	card_type_1 = CardType.EXPAND
	card_type_2 = CardType.EXPAND
	target_type = TargetType.SELF
	ability_type = AbilityType.BASIC
	
	img = preload("res://src/resources/cards/cards_imgs/33.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 0
	base_block = 0
	base_magic_number = 4
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func act():
	battle_manager.add_action_to_bot(EnableRandomCellAction.new(card_target,battle_manager.player,magic_number))

func after_play_act():
	battle_manager.add_action_to_bot(ExhaustCardAction.new(card_target,battle_manager.player,self))
