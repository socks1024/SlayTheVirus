class_name EnableCellAction
extends BaseAction

var position:Vector2
var board:Board

func _init(target:BaseCreature,source:BaseCreature,position:Vector2,board:Board):
	super(target,source)
	self.position = position
	self.board = board


func act():
	board.set_active(position,true)
