class_name Boss4
extends Boss

@onready var arm_tentacle = $ArmTentacle
@onready var mouth_tentacle = $MouthTentacle
@onready var shield = $Shield
@onready var mr_chaos = $Mr_chaos

func _ready():
	super()
	parts_queue[arm_tentacle.part_id] = arm_tentacle
	parts_queue[mouth_tentacle.part_id] = mouth_tentacle
	parts_queue[shield.part_id] = shield
	parts_queue[mr_chaos.part_id] = mr_chaos


func decide_intention():
	
	#region arm tentacle
	if arm_tentacle.destroyed || arm_tentacle.get_buff_amount("stun") > 0:
		set_part_intention(arm_tentacle,StunIntention.new(arm_tentacle,arm_tentacle))
	else:
		if turn_count % 2 == 0:
			set_part_intention(arm_tentacle,GiveTrashIntention.new(1,battle_manager.player,arm_tentacle,false,"WEAKEN_IMMUNITY"))
		elif turn_count % 2 == 1:
			set_part_intention(arm_tentacle,GiveTrashIntention.new(1,battle_manager.player,arm_tentacle,false,"WEAKNESS"))
			set_part_intention(arm_tentacle,GiveTrashIntention.new(1,battle_manager.player,arm_tentacle,false,"EXHAUSTION"))
	
	#endregion
	
	#region mouth tentacle
	
	if mouth_tentacle.destroyed || mouth_tentacle.get_buff_amount("stun") > 0:
		set_part_intention(mouth_tentacle,StunIntention.new(mouth_tentacle,mouth_tentacle))
	else:
		set_part_intention(mouth_tentacle,AttackIntention.new(randi_range(1,7),battle_manager.player,mouth_tentacle))
		set_part_intention(mouth_tentacle,ApplyDebuffIntention.new(randi_range(1,2),battle_manager.player,mouth_tentacle,"trauma"))
	
	#endregion
	
	#region shield
	
	if shield.destroyed || shield.get_buff_amount("stun") > 0:
		set_part_intention(shield,StunIntention.new(shield,shield))
	else:
		set_part_intention(shield,DefenseIntention.new(randi_range(1,7),mr_chaos,shield))
	
	#endregion
	
	#region mr.chaos
	
	var rand = randi_range(4,6)
	
	if mr_chaos.get_buff_amount("stun") > 0:
		set_part_intention(mr_chaos,StunIntention.new(mr_chaos,mr_chaos))
	else:
		if arm_tentacle.destroyed:
			rand -= 1
		if mouth_tentacle.destroyed:
			rand -= 1
		if shield.destroyed:
			rand -= 1
		
		match rand:
			1:
				set_part_intention(mouth_tentacle,GainDebuffIntention.new(2,mr_chaos,mr_chaos,"trauma"))
			2:
				set_part_intention(mouth_tentacle,AttackIntention.new(randi_range(1,5),battle_manager.player,mr_chaos))
			3:
				set_part_intention(mr_chaos,HealIntention.new(randi_range(1,5),mr_chaos,mr_chaos))
			4:
				set_part_intention(mr_chaos,GiveTrashIntention.new(1,battle_manager.player,mr_chaos,true,""))
			5:
				set_part_intention(mr_chaos,AttackIntention.new(randi_range(1,7),battle_manager.player,mr_chaos))
			6:
				set_part_intention(mr_chaos,AttackIntention.new(3,battle_manager.player,mr_chaos))
				set_part_intention(mr_chaos,AttackIntention.new(3,battle_manager.player,mr_chaos))
	
	#endregion
