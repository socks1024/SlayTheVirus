class_name EnableRandomCellAction
extends BaseAction

var amount:int

func _init(target:BaseCreature,source:BaseCreature,amount:int):
	super(target,source)
	self.amount = amount


func act():
	for i in amount:
		var inactive_cells_pos:Array[Vector2]
		
		for cell in main.battle_manager.board.all_cells:
			if !cell.active:
				inactive_cells_pos.append(main.battle_manager.board.get_cell_pos(cell))
		
		main.battle_manager.board.set_active(inactive_cells_pos.pick_random(),true)
	
	
