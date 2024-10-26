class_name Macrophage
extends BaseCard


func initialize():
	
	id = "MACROPHAGE"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.ATTACK
	target_type = TargetType.SELF
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/32.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN,Vector2(1,1),Vector2(-1,1),Vector2(2,1),Vector2(-2,1)]
	shape_arrow = [Vector2.DOWN]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 14
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_damage]
	
	super()


func condition_act():
	if conditions[0]:
		battle_manager.add_action_to_bot(AttackAction.new(card_target,battle_manager.player,damage))

func after_play_act():
	battle_manager.add_action_to_bot(ExhaustCardAction.new(card_target,battle_manager.player,self))
