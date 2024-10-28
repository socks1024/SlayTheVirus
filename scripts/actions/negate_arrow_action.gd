class_name NegateArrowAction
extends BaseAction



func _init(target:BaseCreature,source:BaseCreature):
	super(target,source)


func act():
	main.battle_manager.board.necrosis = true
