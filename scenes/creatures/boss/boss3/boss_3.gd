class_name Boss3
extends Boss

@onready var shield_virus = $ShieldVirus
@onready var hammer_virus = $HammerVirus
@onready var heart_virus = $HeartVirus
@onready var virus_army = $VirusArmy

func _ready():
	super()
	parts_queue[shield_virus.part_id] = shield_virus
	parts_queue[hammer_virus.part_id] = hammer_virus
	parts_queue[heart_virus.part_id] = heart_virus
	parts_queue[virus_army.part_id] = virus_army


var shield_regen_count = 0
var hammer_regen_count = 0
var heart_regen_count = 0

var regen_delay = 3

func decide_intention():
	
	#region shield virus
	if shield_virus.destroyed || shield_virus.get_buff_amount("stun") > 0:
		set_part_intention(shield_virus,StunIntention.new(shield_virus,shield_virus))
	else:
		if !heart_virus.destroyed:
			set_part_intention(shield_virus,DefenseIntention.new(1,heart_virus,shield_virus))
		if !hammer_virus.destroyed:
			set_part_intention(shield_virus,DefenseIntention.new(1,hammer_virus,shield_virus))
		set_part_intention(shield_virus,DefenseIntention.new(1,shield_virus,shield_virus))
		set_part_intention(shield_virus,DefenseIntention.new(2,virus_army,shield_virus))
	
	#endregion
	
	#region hammer virus
	
	if hammer_virus.destroyed || hammer_virus.get_buff_amount("stun") > 0:
		set_part_intention(hammer_virus,StunIntention.new(hammer_virus,hammer_virus))
	else:
		set_part_intention(hammer_virus,AttackIntention.new(4,battle_manager.player,hammer_virus))
	
	#endregion
	
	#region heart virus
	
	if heart_virus.destroyed || heart_virus.get_buff_amount("stun") > 0:
		set_part_intention(heart_virus,StunIntention.new(heart_virus,heart_virus))
	else:
		if virus_army.health == virus_army.maxhealth:
			set_part_intention(heart_virus,ApplyDebuffIntention.new(2,battle_manager.player,heart_virus,"paralysis"))
		else:
			set_part_intention(heart_virus,HealIntention.new(4,virus_army,heart_virus))
	
	#endregion
	
	#region lazy viru
	
	if shield_virus.destroyed:
		shield_regen_count += 1
	if hammer_virus.destroyed:
		hammer_regen_count += 1
	if heart_virus.destroyed:
		heart_regen_count += 1
	
	if virus_army.get_buff_amount("stun") > 0:
		set_part_intention(virus_army,StunIntention.new(virus_army,virus_army))
	else:
		if shield_regen_count >= regen_delay:
			shield_regen_count = 0
			set_part_intention(virus_army,RegenIntention.new(shield_virus.maxhealth,shield_virus,virus_army))
		if hammer_regen_count >= regen_delay:
			hammer_regen_count = 0
			set_part_intention(virus_army,RegenIntention.new(shield_virus.maxhealth,hammer_virus,virus_army))
		if heart_regen_count >= regen_delay:
			heart_regen_count = 0
			set_part_intention(virus_army,RegenIntention.new(shield_virus.maxhealth,heart_virus,virus_army))
		
		set_part_intention(virus_army,DefenseIntention.new(1,virus_army,virus_army))
		set_part_intention(virus_army,AttackIntention.new(1,battle_manager.player,virus_army))
	
	#endregion
