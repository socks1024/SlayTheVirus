class_name NegateTrashAction
extends BaseAction

func _init(target:BaseCreature,source:BaseCreature):
	super(target,source)


func act():
	main.battle_manager.player_card_manager.negate_trash = true
