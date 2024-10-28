class_name ProliferationBuff
extends BaseBuff

func initialize(amount:int):
	id = "proliferation"
	buff_texture = proliferation_texture
	
	super(amount)

func act():
	pass

func act_on_turn_end():
	pass
