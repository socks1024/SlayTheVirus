class_name SpikeBuff
extends BaseBuff

func initialize(amount:int):
	id = "spike"
	buff_texture = spike_texture
	
	super(amount)

func act():
	pass

func act_on_turn_end():
	amount -= 1
