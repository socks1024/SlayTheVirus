class_name Boss6
extends Boss

@onready var beautiful_virus = $BeautifulVirus
@onready var left_ponytail = $LeftPonytail
@onready var right_ponytail = $RightPonytail

func _ready():
	super()
	
	parts_queue[left_ponytail.part_id] = left_ponytail
	parts_queue[right_ponytail.part_id] = right_ponytail
	parts_queue[beautiful_virus.part_id] = beautiful_virus


func decide_intention():
	
	if beautiful_virus.health <= 490 && !beautiful_virus.angry:
		beautiful_virus.angry = true
		main.battle_screen.left_back.texture = main.battle_screen.boss_6_3_background
		main.change_music(main.main_opening)
		beautiful_virus.health = 36
	
	
	#region left ponytail
	
	if left_ponytail.destroyed || left_ponytail.get_buff_amount("stun") > 0:
		set_part_intention(left_ponytail,StunIntention.new(left_ponytail,left_ponytail))
	else:
		if beautiful_virus.angry:
			set_part_intention(left_ponytail,AttackIntention.new(2,battle_manager.player,left_ponytail))
			set_part_intention(left_ponytail,ApplyBuffIntention.new(1,beautiful_virus,left_ponytail,"spike"))
		else:
			if turn_count % 2 == 1:
				set_part_intention(left_ponytail,GiveTrashIntention.new(1,battle_manager.player,left_ponytail,false,"WEAKEN_IMMUNITY"))
			else:
				set_part_intention(left_ponytail,ApplyDebuffIntention.new(1,battle_manager.player,left_ponytail,"inactivation"))
	
	#endregion
	
	#region right ponytail
	
	if right_ponytail.destroyed || right_ponytail.get_buff_amount("stun") > 0:
		set_part_intention(right_ponytail,StunIntention.new(right_ponytail,right_ponytail))
	else:
		if beautiful_virus.angry:
			set_part_intention(right_ponytail,AttackIntention.new(2,battle_manager.player,right_ponytail))
			set_part_intention(right_ponytail,ApplyBuffIntention.new(1,beautiful_virus,right_ponytail,"spike"))
		else:
			if turn_count % 2 == 0:
				set_part_intention(right_ponytail,GiveTrashIntention.new(1,battle_manager.player,right_ponytail,false,"THROMBUS"))
			else:
				set_part_intention(right_ponytail,ApplyDebuffIntention.new(1,battle_manager.player,right_ponytail,"inactivation"))
	
	#endregion
	
	#region beautiful virus
	
	if beautiful_virus.get_buff_amount("stun") > 0:
		set_part_intention(beautiful_virus,StunIntention.new(beautiful_virus,beautiful_virus))
	else:
		if beautiful_virus.angry:
			var damage = 2
			if left_ponytail.destroyed:
				damage += 2
			if right_ponytail.destroyed:
				damage += 2
			
			set_part_intention(beautiful_virus,AttackIntention.new(2,battle_manager.player,beautiful_virus))
		else:
			set_part_intention(beautiful_virus,DefenseIntention.new(2,beautiful_virus,beautiful_virus))
	
	
	#endregion
