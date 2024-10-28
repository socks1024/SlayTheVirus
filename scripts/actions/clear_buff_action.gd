class_name ClearBuffAction
extends BaseAction

func _init(target:BaseCreature,source:BaseCreature):
	super(target,source)


func act():
	if !target.buffs.is_empty():
		for b in target.buffs:
			target.on_clear_buff(b)
