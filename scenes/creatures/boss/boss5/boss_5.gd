class_name Boss5
extends Boss

@onready var royal_viru_xiii = $RoyalViruXIII
@onready var coffee_cup = $CoffeeCup
@onready var sword_1 = $Sword1
@onready var sword_2 = $Sword2

func _ready():
	super()
	
	parts_queue[royal_viru_xiii.part_id] = royal_viru_xiii
	parts_queue[coffee_cup.part_id] = coffee_cup
	parts_queue[sword_1.part_id] = sword_1
	parts_queue[sword_2.part_id] = sword_2


func decide_intention():
	
	#region coffee cup
	if coffee_cup.destroyed || coffee_cup.get_buff_amount("stun") > 0:
		set_part_intention(coffee_cup,StunIntention.new(coffee_cup,coffee_cup))
	else:
		set_part_intention(coffee_cup,ClearBuffIntention.new(royal_viru_xiii,coffee_cup))
		set_part_intention(coffee_cup,HealIntention.new(2,royal_viru_xiii,coffee_cup))
	
	#endregion
	
	#region sword1
	
	if sword_1.destroyed || sword_1.get_buff_amount("stun") > 0:
		set_part_intention(sword_1,StunIntention.new(sword_1,sword_1))
	else:
		if coffee_cup.destroyed:
			set_part_intention(sword_1,AttackIntention.new(turn_count / 3,battle_manager.player,sword_1))
			set_part_intention(sword_1,AttackIntention.new(turn_count / 3,battle_manager.player,sword_1))
		else:
			if turn_count % 2 == 1:
				set_part_intention(sword_1,DefenseIntention.new(1,royal_viru_xiii,sword_1))
			else:
				set_part_intention(sword_1,ApplyDebuffIntention.new(1,battle_manager.player,sword_1,"trauma"))
	
	#endregion
	
	#region sword2
	
	if sword_2.destroyed || sword_2.get_buff_amount("stun") > 0:
		set_part_intention(sword_2,StunIntention.new(sword_2,sword_2))
	else:
		if coffee_cup.destroyed:
			set_part_intention(sword_2,AttackIntention.new(turn_count / 3,battle_manager.player,sword_2))
			set_part_intention(sword_2,AttackIntention.new(turn_count / 3,battle_manager.player,sword_2))
		else:
			if turn_count % 2 == 0:
				set_part_intention(sword_2,DefenseIntention.new(1,royal_viru_xiii,sword_2))
			else:
				set_part_intention(sword_2,ApplyDebuffIntention.new(1,battle_manager.player,sword_2,"trauma"))
	
	#endregion
	
	#region royal viru XIII
	
	if royal_viru_xiii.get_buff_amount("stun") > 0:
		set_part_intention(royal_viru_xiii,StunIntention.new(royal_viru_xiii,royal_viru_xiii))
	else:
		if turn_count % 2 == 0:
			if coffee_cup.destroyed:
				royal_viru_xiii.img.texture = royal_viru_xiii.angry_img
				set_part_intention(royal_viru_xiii,ApplyDebuffIntention.new(2,battle_manager.player,royal_viru_xiii,"trauma"))
			else:
				set_part_intention(royal_viru_xiii,ApplyDebuffIntention.new(1,battle_manager.player,royal_viru_xiii,"trauma"))
		else:
			if sword_1.destroyed && sword_2.destroyed:
				royal_viru_xiii.img.texture = royal_viru_xiii.angry_img
				set_part_intention(royal_viru_xiii,AttackIntention.new(turn_count / 2,battle_manager.player,royal_viru_xiii))
			else:
				set_part_intention(royal_viru_xiii,AttackIntention.new(2,battle_manager.player,royal_viru_xiii))
	#endregion
