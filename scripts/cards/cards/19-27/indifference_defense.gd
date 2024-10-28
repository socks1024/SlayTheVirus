class_name IndifferenceDefense
extends BaseCard


func initialize():
	
	id = "INDIFFERENCE_DEFENSE"
	card_type_1 = CardType.DEFEND
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.DEBUFF
	
	img = preload("res://src/resources/cards/cards_imgs/22.png")
	
	shape = [Vector2(1,-1),Vector2.UP,Vector2.RIGHT,Vector2(1,1),Vector2(-1,-1)]
	shape_arrow = [Vector2.UP]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 11
	base_magic_number = 0
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_block]
	
	super()


func arrow_act():
	if conditions[0]:
		battle_manager.use(NegateAction.new(card_target,battle_manager.player,condition_cards[0]))


func act():
	battle_manager.use(DefenseAction.new(battle_manager.player,battle_manager.player,block))
