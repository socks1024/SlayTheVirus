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
	
	set_part_intention(hard_nozzle,AttackIntention.new(1,battle_manager.player,hard_nozzle))
	
	#endregion
	
	#region heart lump
	
	#var part_to_heal
	#var lowest_health = 999
	#
	#if turn_count % 3 == 0:
		#
	#else:
		#for part in parts_queue:
			#if !part.destroyed && part.health < lowest_health:
				#part_to_heal = part
				#lowest_health = part.health
	
	set_part_intention(heart_lump,AttackIntention.new(1,battle_manager.player,heart_lump))
	
	#endregion
	
	#region smile nozzle
	
	set_part_intention(smile_nozzle,AttackIntention.new(1,battle_manager.player,smile_nozzle))
	
	#endregion
	
	#region lazy viru
	
	set_part_intention(lazy_viru,AttackIntention.new(1,battle_manager.player,lazy_viru))
	
	#endregion
	
	
	
