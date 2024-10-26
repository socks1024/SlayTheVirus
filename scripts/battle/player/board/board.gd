class_name Board
extends Node2D

@onready var main = get_tree().get_first_node_in_group("main")

func _ready():
	for row in cells:
		all_cells.append_array(row)


func initialize():
	
	for row in cells:
		for c in row:
			c.set_active(false)
	
	for v in initial_activated_cells:
		set_active(v,true)

#region cell & cell's card

#@onready var cell_row_1 = [$"1-1",$"1-2",$"1-3",$"1-4",$"1-5"]
#@onready var cell_row_2 = [$"2-1",$"2-2",$"2-3",$"2-4",$"2-5"]
#@onready var cell_row_3 = [$"3-1",$"3-2",$"3-3",$"3-4",$"3-5"]
#@onready var cell_row_4 = [$"4-1",$"4-2",$"4-3",$"4-4",$"4-5"]
#@onready var cell_row_5 = [$"5-1",$"5-2",$"5-3",$"5-4",$"5-5"]

@onready var cell_row_1 = [$"1-1",$"2-1",$"3-1",$"4-1",$"5-1"]
@onready var cell_row_2 = [$"1-2",$"2-2",$"3-2",$"4-2",$"5-2"]
@onready var cell_row_3 = [$"1-3",$"2-3",$"3-3",$"4-3",$"5-3"]
@onready var cell_row_4 = [$"1-4",$"2-4",$"3-4",$"4-4",$"5-4"]
@onready var cell_row_5 = [$"1-5",$"2-5",$"3-5",$"4-5",$"5-5"]

@onready var cells = [cell_row_1,cell_row_2,cell_row_3,cell_row_4,cell_row_5]

var all_cells:Array[Cell]

var initial_activated_cells = [
	Vector2(2,2),Vector2(2,3),Vector2(2,4),
	Vector2(3,2),Vector2(3,3),Vector2(3,4),
	Vector2(4,2),Vector2(4,3),Vector2(4,4),]


func get_cell(pos:Vector2) -> Cell:
	return cells[pos.x - 1][pos.y - 1]


func get_cell_pos(cell:Cell) -> Vector2:
	var index = cell.get_index()
	
	return Vector2(index % 5 + 1,index / 5 + 1)


func set_active(cell_pos:Vector2,a:bool):
	var cell = get_cell(cell_pos)
	cell.set_active(a)


func set_cell_card(card:BaseCard):
	for cell in all_cells:
		var v = get_cell_pos(cell)
		
		if cell.global_position == card.global_position:
			
			print("placed")
			for s in card.shape:
				
				get_cell(v+s).card = card
				get_cell(v+s).has_card = true
				
				print(v+s)


func remove_cell_card(card:BaseCard):
	for cell in all_cells:
		if cell.card == card:
			cell.card = null
			cell.has_card = false


func can_place(card:BaseCard) -> bool:
	var v
	
	for cell in all_cells:
		if cell.global_position == card.location:
			
			v = get_cell_pos(cell)
	
	if v == null:
		print("out_of_bound")
		return false
	
	for s in card.shape:
		if !get_cell(v + s).active:
			print(v + s)
			print("inactive")
			return false
		if get_cell(v + s).has_card:
			print(v + s)
			print("has_card")
			return false
	
	return true

#endregion

#region play placed card

##获取板子上的所有卡牌
func get_cards_placed() -> Array[BaseCard]:
	var cards_placed:Array[BaseCard]
	
	for cell in all_cells:
		if cell.has_card:
			
			var repeated = false
			
			if cards_placed.is_empty():
				cards_placed.append(cell.card)
			else:
				for card in cards_placed:
					
					if cell.card == card:
						repeated = true
				
				if !repeated:
					cards_placed.append(cell.card)
	
	return cards_placed


func set_condition(card:BaseCard):
	pass


#endregion
