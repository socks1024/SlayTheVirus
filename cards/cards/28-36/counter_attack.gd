class_name CounterAttack
extends BaseCard


func initialize():
	
	id = "COUNTER_ATTACK"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.SELF
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/31.png")
	
	shape = [Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2(1,1),Vector2(-1,1),Vector2(1,-1),Vector2(-1,-1)]
	shape_arrow = [Vector2.UP]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 3
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func condition_act():
	if conditions[0]:
		battle_manager.use(ApplyBuffAction.new(battle_manager.player,battle_manager.player,battle_manager.build_buff("spike",magic_number)))
