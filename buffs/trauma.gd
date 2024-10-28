class_name TraumaBuff
extends BaseBuff

func initialize(amount:int):
	id = "trauma"
	buff_texture = trauma_texture
	
	super(amount)

func act():
	pass

func act_on_turn_end():
	battle_manager.use(AttackAction.new(buff_owner,buff_owner,amount))
	amount -= 1
