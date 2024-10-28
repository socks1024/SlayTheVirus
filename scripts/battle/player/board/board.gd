class_name Board
extends Node2D

@onready var main = get_tree().get_first_node_in_group("main")


func initialize():
	for cell in all_cells:
		var index = cell.get_index()
		cell.cell_pos = Vector2(index % 5 + 1,index / 5 + 1)
	
	for cell in all_cells:
		cell.set_active(true)
		cell.card = null
	
	for v in initial_inactivated_cells:
		set_active(v,false)

#region cell & cell's card

#@onready var cell_row_1 = [$"1-1",$"1-2",$"1-3",$"1-4",$"1-5"]
#@onready var cell_row_2 = [$"2-1",$"2-2",$"2-3",$"2-4",$"2-5"]
#@onready var cell_row_3 = [$"3-1",$"3-2",$"3-3",$"3-4",$"3-5"]
#@onready var cell_row_4 = [$"4-1",$"4-2",$"4-3",$"4-4",$"4-5"]
#@onready var cell_row_5 = [$"5-1",$"5-2",$"5-3",$"5-4",$"5-5"]

#@onready var cell_row_1 = [$"1-1",$"2-1",$"3-1",$"4-1",$"5-1"]
#@onready var cell_row_2 = [$"1-2",$"2-2",$"3-2",$"4-2",$"5-2"]
#@onready var cell_row_3 = [$"1-3",$"2-3",$"3-3",$"4-3",$"5-3"]
#@onready var cell_row_4 = [$"1-4",$"2-4",$"3-4",$"4-4",$"5-4"]
#@onready var cell_row_5 = [$"1-5",$"2-5",$"3-5",$"4-5",$"5-5"]
#
#@onready var cells = [cell_row_1,cell_row_2,cell_row_3,cell_row_4,cell_row_5]

@onready var all_cells = [
	$"1-1",$"2-1",$"3-1",$"4-1",$"5-1",
	$"1-2",$"2-2",$"3-2",$"4-2",$"5-2",
	$"1-3",$"2-3",$"3-3",$"4-3",$"5-3",
	$"1-4",$"2-4",$"3-4",$"4-4",$"5-4",
	$"1-5",$"2-5",$"3-5",$"4-5",$"5-5",
]

var initial_inactivated_cells = [
	Vector2(1,1),Vector2(2,1),Vector2(3,1),Vector2(4,1),Vector2(5,1),
	Vector2(1,2),Vector2(5,2),
	Vector2(1,3),Vector2(5,3),
	Vector2(1,4),Vector2(5,4),
	Vector2(1,5),Vector2(2,5),Vector2(3,5),Vector2(4,5),Vector2(5,5)]


func get_cell(pos:Vector2) -> Cell:
	var retCell:Cell
	
	for cell in all_cells:
		if cell.cell_pos.is_equal_approx(pos):
			retCell = cell
	
	return retCell


func get_cell_pos(cell:Cell) -> Vector2:
	return cell.cell_pos


func set_active(cell_pos:Vector2,a:bool):
	var cell = get_cell(cell_pos)
	cell.set_active(a)


func set_cell_card(card:BaseCard):
	for cell in all_cells:
		if cell.global_position == card.global_position:
			
			var v = get_cell_pos(cell)
			
			card.cell_location = v
			for s in card.shape:
				
				var pos = v + s
				
				var to_cell = get_cell(pos)
				
				to_cell.card = card
				
				print("placed" + str(pos))
		
		#print_cells_activation()


func remove_cell_card(card:BaseCard):
	for cell in all_cells:
		if cell.card == card:
			cell.card = null
			cell.has_card = false


func can_place(card:BaseCard) -> bool:
	var v = Vector2.ZERO
	
	for cell in all_cells:
		if cell.global_position == card.location:
			v = get_cell_pos(cell)
	
	if v == null:
		print("out_of_bound")
		return false
	
	for s in card.shape:
		var pos = v + s
		
		if pos.x < 1 || pos.x > 5 || pos.y < 1 || pos.y > 5:
			return false
		
		var cell = get_cell(pos)
		
		if cell != null:
			if !cell.active:
				print(pos)
				print("inactive")
				return false
			if cell.has_card:
				print(pos)
				print("has_card")
				return false
	
	return true


func print_cells_activation():
	for cell in all_cells:
		print(str(get_cell_pos(cell)),cell.active)

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


var necrosis = false

func set_condition(card:BaseCard):
	
	if card.shape_arrow.is_empty():
		return
	
	for i in card.shape_arrow.size():
		var cell = get_cell(card.cell_location + card.shape_arrow[i] + card.arrow_face[i])
		
		if cell == null:
			card.conditions[i] = false
		elif necrosis && (card.ability_type == card.AbilityType.BUFF || card.ability_type == card.AbilityType.DEBUFF):
			card.conditions[i] = false
		else:
			if card.ability_type != card.AbilityType.EXPAND:
				if cell.has_card:
					card.conditions[i] = true
					card.condition_cards[i] = cell.card
			else:
				if !cell.active:
					card.conditions[i] = true
					set_active(get_cell_pos(cell),true)


#endregion
