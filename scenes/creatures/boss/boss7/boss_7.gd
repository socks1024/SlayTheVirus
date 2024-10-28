class_name Boss7
extends Boss

@onready var computer_virus = $ComputerVirus
@onready var e_shield = $E_Shield
@onready var defibrillator = $Defibrillator
@onready var wire_operator = $WireOperator


func _ready():
	super()
	parts_queue[wire_operator.part_id] = wire_operator
	parts_queue[e_shield.part_id] = e_shield
	parts_queue[defibrillator.part_id] = defibrillator
	parts_queue[computer_virus.part_id] = computer_virus

var emergency_restart = true

func decide_intention():
	
	if !e_shield.destroyed:
		wire_operator.targetable = false
		defibrillator.targetable = false
		computer_virus.targetable = false
	else:
		wire_operator.targetable = true
		defibrillator.targetable = true
		computer_virus.targetable = true
	
	#region wire operator
	
	if wire_operator.destroyed || wire_operator.get_buff_amount("stun") > 0:
		set_part_intention(wire_operator,StunIntention.new(wire_operator,wire_operator))
	else:
		var i = randi_range(1,4)
		
		match i:
			1:
				set_part_intention(wire_operator,ApplyDebuffIntention.new(2,battle_manager.player,wire_operator,"paralysis"))
			2:
				set_part_intention(wire_operator,ApplyDebuffIntention.new(2,battle_manager.player,wire_operator,"inactivation"))
			3:
				set_part_intention(wire_operator,ApplyDebuffIntention.new(2,battle_manager.player,wire_operator,"vulnerable"))
			4:
				set_part_intention(wire_operator,ApplyDebuffIntention.new(2,battle_manager.player,wire_operator,"trauma"))
	
	
	#endregion
	
	#region electronic shield
	
	if e_shield.destroyed || e_shield.get_buff_amount("stun") > 0:
		set_part_intention(e_shield,StunIntention.new(e_shield,e_shield))
	else:
		set_part_intention(e_shield,DefenseIntention.new(3,e_shield,e_shield))
	
	#endregion
	
	#region defibrillator
	
	var shock = true
	
	if defibrillator.destroyed || defibrillator.get_buff_amount("stun") > 0:
		if defibrillator.destroyed && shock:
			set_part_intention(defibrillator,AttackIntention.new(8,battle_manager.player,defibrillator))
		else:
			set_part_intention(defibrillator,StunIntention.new(defibrillator,defibrillator))
		
	else:
		var damage = 0
		
		for buff in battle_manager.player.buffs:
			damage += buff.amount
		
		set_part_intention(defibrillator,AttackIntention.new(damage / 2 + 2,battle_manager.player,defibrillator))
	
	#endregion
	
	
	var damage = 1
	
	#region computer virus
	
	if computer_virus.get_buff_amount("stun") > 0:
		set_part_intention(computer_virus,StunIntention.new(computer_virus,computer_virus))
	else:
		if emergency_restart && e_shield.destroyed:
			set_part_intention(computer_virus,RegenIntention.new(7,e_shield,computer_virus))
			emergency_restart = false
		elif e_shield.destroyed:
			set_part_intention(computer_virus,DefenseIntention.new(3,computer_virus,computer_virus))
		
		if computer_virus.angry:
			damage += 2
		
		set_part_intention(computer_virus,AttackIntention.new(damage,battle_manager.player,computer_virus))
	
	#endregion
