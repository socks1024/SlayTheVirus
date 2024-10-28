class_name Antibody
extends BaseCard


func initialize():
	
	id = "ANTIBODY"
	card_type_1 = CardType.BUFF
	card_type_2 = CardType.BUFF
	target_type = TargetType.ALL_PART
	ability_type = AbilityType.SELF_EFFECT
	
	img = preload("res://src/resources/cards/cards_imgs/29.png")
	
	shape = [Vector2.UP,Vector2.DOWN,Vector2.LEFT,Vector2.RIGHT,Vector2(1,1),Vector2(-1,1),Vector2(1,-1),Vector2(-1,-1)]
	shape_arrow = [Vector2.UP]
	arrow_face = [Vector2.DOWN]
	
	base_damage = 0
	base_block = 0
	base_magic_number = 1
	
	
	card_description = tr(id + "_DESCRIPTION") % [base_magic_number]
	
	super()


func condition_act():
	if conditions[0]:
		var all_part = battle_manager.enemy.get_all_parts()
		for part in all_part:
			battle_manager.use(ApplyBuffAction.new(part,battle_manager.player,battle_manager.build_buff("stun",magic_number)))


func after_play_act():
	battle_manager.use(ExhaustCardAction.new(card_target,battle_manager.player,self))
