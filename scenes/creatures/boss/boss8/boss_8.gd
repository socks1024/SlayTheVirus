class_name Boss8
extends Boss

@onready var virus_king = $VirusKing
@onready var crown = $Crown
@onready var sharp_lump = $SharpLump
@onready var slime_emision_hole = $SlimeEmisionHole
@onready var healing_lump = $HealingLump
@onready var viru_left = $ViruLeft
@onready var viru_right = $ViruRight


func _ready():
	super()
	
	parts_queue[viru_left.part_id] = viru_left
	parts_queue[viru_right.part_id] = viru_right
	
	parts_queue[crown.part_id] = crown
	parts_queue[sharp_lump.part_id] = sharp_lump
	parts_queue[slime_emision_hole.part_id] = slime_emision_hole
	parts_queue[healing_lump.part_id] = healing_lump
	
	parts_queue[virus_king.part_id] = virus_king

func decide_intention():
	
	var viru_followers = 2
	
	#region viru left
	
	if viru_left.destroyed || viru_left.get_buff_amount("stun") > 0:
		set_part_intention(viru_left,StunIntention.new(viru_left,viru_left))
		viru_followers -= 1
	else:
		if turn_count % 2 == 1:
			set_part_intention(viru_left,AttackIntention.new(3,battle_manager.player,viru_left))
		else:
			set_part_intention(viru_left,DefenseIntention.new(3,virus_king,viru_left))
	
	#endregion
	
	#region viru right
	
	if viru_right.destroyed || viru_right.get_buff_amount("stun") > 0:
		set_part_intention(viru_right,StunIntention.new(viru_right,viru_right))
		viru_followers -= 1
	else:
		if turn_count % 2 == 0:
			set_part_intention(viru_right,AttackIntention.new(3,battle_manager.player,viru_right))
		else:
			set_part_intention(viru_right,DefenseIntention.new(3,virus_king,viru_right))
	
	#endregion
	
	#region crown
	
	if viru_followers > 0:
		crown.targetable = true
	else:
		crown.targetable = false
	
	if crown.destroyed || crown.get_buff_amount("stun") > 0:
		set_part_intention(crown,StunIntention.new(crown,crown))
	else:
		if turn_count % 3 == 0:
			set_part_intention(crown,DefenseIntention.new(2,virus_king,crown))
			set_part_intention(crown,ClearBuffIntention.new(virus_king,crown))
		else:
			set_part_intention(crown,DefenseIntention.new(4,virus_king,crown))
	
	#endregion
	
	#region sharp lump
	
	if sharp_lump.destroyed || sharp_lump.get_buff_amount("stun") > 0:
		set_part_intention(sharp_lump,StunIntention.new(sharp_lump,sharp_lump))
	else:
		if turn_count % 2 == 1:
			set_part_intention(sharp_lump,AttackIntention.new(3 - viru_followers,battle_manager.player,sharp_lump))
			set_part_intention(sharp_lump,AttackIntention.new(3 - viru_followers,battle_manager.player,sharp_lump))
		else:
			set_part_intention(sharp_lump,AttackIntention.new(5 - viru_followers,battle_manager.player,sharp_lump))
			set_part_intention(sharp_lump,ApplyDebuffIntention.new(3 - viru_followers,battle_manager.player,sharp_lump,"vulnerable"))
	
	#endregion
	
	#region slime emmission hole
	
	if slime_emision_hole.destroyed || slime_emision_hole.get_buff_amount("stun") > 0:
		set_part_intention(slime_emision_hole,StunIntention.new(slime_emision_hole,slime_emision_hole))
	else:
		if turn_count % 2 == 1:
			set_part_intention(slime_emision_hole,GiveTrashIntention.new(1,battle_manager.player,slime_emision_hole,false,"CANCERATION"))
		else:
			set_part_intention(sharp_lump,ApplyDebuffIntention.new(3 - viru_followers,battle_manager.player,sharp_lump,"trauma"))
	
	#endregion
	
	#region healing lump
	
	if healing_lump.destroyed || healing_lump.get_buff_amount("stun") > 0:
		set_part_intention(healing_lump,StunIntention.new(healing_lump,healing_lump))
	else:
		if !viru_left.destroyed:
			set_part_intention(healing_lump,HealIntention.new(2,viru_left,healing_lump))
		if !viru_left.destroyed:
			set_part_intention(healing_lump,HealIntention.new(2,viru_right,healing_lump))
		
		set_part_intention(healing_lump,HealIntention.new(6 - viru_followers * 2,virus_king,healing_lump))
	
	#endregion
	
	#region virus king
	
	if virus_king.get_buff_amount("stun") > 0:
		set_part_intention(virus_king,StunIntention.new(virus_king,virus_king))
	else:
		if !virus_king.angry:
			if viru_left.destroyed:
				set_part_intention(virus_king,RegenIntention.new(5,viru_left,virus_king))
			if viru_right.destroyed:
				set_part_intention(virus_king,RegenIntention.new(5,viru_right,virus_king))
		
		set_part_intention(virus_king,AttackIntention.new(8 - 2 * viru_followers,battle_manager.player,virus_king))
	
	#endregion
