class_name Boss1
extends Boss

@onready var hard_nozzle = $HardNozzle
@onready var smile_nozzle = $SmileNozzle
@onready var heart_lump = $HeartLump
@onready var lazy_viru = $LazyViru

func _ready():
	super()
	parts_queue[hard_nozzle.part_id] = hard_nozzle
	parts_queue[smile_nozzle.part_id] = smile_nozzle
	parts_queue[heart_lump.part_id] = heart_lump
	parts_queue[lazy_viru.part_id] = lazy_viru


func decide_intention():
	
	#region hard nozzle
	if hard_nozzle.destroyed:
		set_part_intention(hard_nozzle,StunIntention.new(hard_nozzle,hard_nozzle))
	else:
		set_part_intention(hard_nozzle,DefenseIntention.new(1,hard_nozzle,hard_nozzle))
		if heart_lump.destroyed:
			set_part_intention(hard_nozzle,DefenseIntention.new(2,lazy_viru,hard_nozzle))
		else:
			set_part_intention(hard_nozzle,DefenseIntention.new(2,heart_lump,hard_nozzle))
	
	#endregion
	
	#region heart lump
	
	if heart_lump.destroyed:
		set_part_intention(heart_lump,StunIntention.new(heart_lump,heart_lump))
	else:
		set_part_intention(heart_lump,HealIntention.new(2,lazy_viru,heart_lump))
	
	#endregion
	
	#region smile nozzle
	
	if smile_nozzle.destroyed:
		set_part_intention(smile_nozzle,StunIntention.new(smile_nozzle,smile_nozzle))
	else:
		set_part_intention(smile_nozzle,AttackIntention.new(1,battle_manager.player,smile_nozzle))
	
	#endregion
	
	#region lazy viru
	
	set_part_intention(lazy_viru,DefenseIntention.new(2,lazy_viru,lazy_viru))
	set_part_intention(lazy_viru,AttackIntention.new(4,battle_manager.player,lazy_viru))
	
	#endregion
