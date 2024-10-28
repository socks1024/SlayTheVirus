class_name VulnerableBuff
extends BaseBuff

func initialize(amount:int):
	id = "vulnerable"
	buff_texture = vulnerable_texture
	
	super(amount)

func act():
	pass

func act_on_turn_end():
	amount -= 1
