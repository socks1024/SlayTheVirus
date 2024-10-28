class_name AttackAction
extends BaseAction

var damage:int

func _init(target:BaseCreature,source:BaseCreature,damage:int):
	super(target,source)
	self.damage = damage


func act():
	damage += target.get_buff_amount("vulnerable")
	damage -= source.get_buff_amount("inactivation")
	
	if target.get_buff_amount("spike") > 0:
		main.battle_manager.use(CounterAction.new(source,target,target.get_buff_amount("spike")))
	
	target.get_hurt(damage)

func act_show():
	super()
	if target is BasePart && main.battle_manager.boss != null:
		main.battle_manager.boss._on_focus_part_with_color(target,Color(1,0.4,0.4))
	main.play_sound(main.blow_sound)
	#main.camera.camera_shake(20)
