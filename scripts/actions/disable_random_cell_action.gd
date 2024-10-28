class_name DisableRandomCellAction
extends BaseAction

var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int):
	super(target,source)
	self.amount = amount


func act():
	var board = main.battle_manager.board
	for i in amount:
		
		var inactive_cells_pos:Array[Vector2]
		
		var cells_at_edge:Array[Cell]
		for v in board.initial_inactivated_cells:
			cells_at_edge.append(board.get_cell(v))
		
		for cell in cells_at_edge:
			if cell.active:
				inactive_cells_pos.append(board.get_cell_pos(cell))
		
		if !inactive_cells_pos.is_empty():
			board.set_active(inactive_cells_pos.pick_random(),false)
	
	
