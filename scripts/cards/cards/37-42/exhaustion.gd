class_name Exhaustion
extends BaseCard


func initialize():
	
	id = "EXHAUSTION"
	card_type_1 = CardType.TRASH
	card_type_2 = CardType.TRASH
	target_type = TargetType.SELF
	ability_type = AbilityType.TRASH
	
	img = preload("res://src/resources/cards/cards_imgs/40.png")
	
	shape = [Vector2.ZERO]
	shape_arrow = []
	arrow_face = []
	
	base_damage = 0
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number,base_magic_number]
	
	super()


func not_play_act():
	battle_manager.add_action_to_bot(ApplyBuffAction.new(battle_manager.player,battle_manager.player,battle_manager.build_buff("inactivation",magic_number)))
	battle_manager.add_action_to_bot(ApplyBuffAction.new(battle_manager.player,battle_manager.player,battle_manager.build_buff("paralysis",magic_number)))


func after_play_act():
	battle_manager.add_action_to_bot(ExhaustCardAction.new(card_target,battle_manager.player,self))
