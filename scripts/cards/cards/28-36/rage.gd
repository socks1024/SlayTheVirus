class_name Rage
extends BaseCard


func initialize():
	
	id = "RAGE"
	card_type_1 = CardType.ATTACK
	card_type_2 = CardType.ATTACK
	target_type = TargetType.SINGLE_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/30.png")
	
	shape = [Vector2.ZERO,Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2(1,1),Vector2(-1,1)]
	shape_arrow = [Vector2.ZERO]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION")
	
	super()


func act():
	battle_manager.add_action_to_bot(DealDamageByLostHPAction.new(card_target,battle_manager.player))


func after_play_act():
	battle_manager.add_action_to_bot(ExhaustCardAction.new(card_target,battle_manager.player,self))
