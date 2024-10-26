class_name InactivitionBuff
extends BaseBuff

func initialize(amount:int):
	id = "INACTIVITION"
	buff_texture = inactivation_texture
	
	super(amount)

func act():
	pass

func act_on_turn_end():
	pass
