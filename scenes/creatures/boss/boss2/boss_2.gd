class_name Boss2
extends Boss

@onready var cone_head = $ConeHead
@onready var tentacle = $Tentacle
@onready var poke_viru = $PokeViru

func _ready():
	super()
	parts_queue[poke_viru.part_id] = poke_viru
	parts_queue[tentacle.part_id] = tentacle
	parts_queue[cone_head.part_id] = cone_head


func decide_intention():
	
	#region poke viru
	
	if poke_viru.get_buff_amount("stun") > 0:
		set_part_intention(poke_viru,StunIntention.new(poke_viru,poke_viru))
	else:
		if poke_viru.angry:
			set_part_intention(poke_viru,ApplyDebuffIntention.new(2,battle_manager.player,poke_viru,"vulnerable"))
		else:
			set_part_intention(poke_viru,ApplyDebuffIntention.new(1,battle_manager.player,poke_viru,"vulnerable"))
		
		if tentacle.destroyed:
			set_part_intention(poke_viru,AttackIntention.new(3,battle_manager.player,poke_viru))
		if cone_head.destroyed:
			set_part_intention(poke_viru,DefenseIntention.new(3,poke_viru,poke_viru))
	
	#endregion
	
	#region tentacle
	
	if tentacle.destroyed || tentacle.get_buff_amount("stun") > 0:
		set_part_intention(tentacle,StunIntention.new(tentacle,tentacle))
	else:
		set_part_intention(tentacle,AttackIntention.new(1,battle_manager.player,tentacle))
		set_part_intention(tentacle,AttackIntention.new(1,battle_manager.player,tentacle))
		set_part_intention(tentacle,AttackIntention.new(1,battle_manager.player,tentacle))
	
	#endregion
	
	#region cone head
	
	if cone_head.destroyed || cone_head.get_buff_amount("stun") > 0:
		set_part_intention(cone_head,StunIntention.new(cone_head,cone_head))
	else:
		if cone_head.block >= 8:
			set_part_intention(cone_head,AttackIntention.new(cone_head.block,battle_manager.player,cone_head))
			cone_head.block = 0
		else:
			set_part_intention(cone_head,DefenseIntention.new(4,cone_head,cone_head))
	
	#endregion
	
