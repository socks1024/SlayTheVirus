class_name StunBuff
extends BaseBuff

func initialize(amount:int):
	id = "stun"
	buff_texture = stun_texture
	
	super(amount)

func act():
	pass

func act_on_turn_end():
	if buff_owner is BasePart:
		buff_owner.skip_next_turn = true
	amount -= 1
