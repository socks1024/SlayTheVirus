class_name ParalysisBuff
extends BaseBuff

func initialize(amount:int):
	id = "paralysis"
	buff_texture = paralysis_texture
	
	super(amount)

func act():
	pass

func act_on_turn_end():
	amount -= 1
