class_name SelectDeckScreen
extends BaseScreen

var initialized = false

func enter():
	super()
	
	if !initialized:
		initialized = true
		
		cards_list = main.card_list
		
		set_card_showcase()
	
	
	for c in main.master_deck:
		_on_change_card_in_deck(c,1)


func exit():
	main.master_deck.clear()
	
	for editor in deck_root.get_children():
		for i in editor.count:
			main.master_deck.append(editor.card_id)
	
	for editor in deck_root.get_children():
		editor.queue_free()
		editor_amount = 0
	
	super()


func _on_return_button_pressed():
	main.switch_screen(main.choose_level_screen)
	main.play_sound(main.press_button)

#region card_showcase

var cards_list:Dictionary

@onready var card_showcase = $CardLibraryRoot/CardShowcase

var showcase_unit_x = 360
var showcase_row_x = 3#列
var showcase_unit_y = 390
var showcase_row_y = 2#行
var showcase_size = showcase_row_x * showcase_row_y

var showed_card_number = 0#左上角的展示牌


var total_unlocked_card_list = [1,2,3,4,5,6,7,8,9,10,11,12,13,17,35]
var boss_1_unlocked_card_list = [15,20,21]
var boss_2_unlocked_card_list = [16,18,31]
var boss_3_unlocked_card_list = [27,28,36]
var boss_4_unlocked_card_list = [24,25,33]
var boss_5_unlocked_card_list = [14,22,23]
var boss_6_unlocked_card_list = [19,30,32]
var boss_7_unlocked_card_list = [26,29,34]
var boss_8_unlocked_card_list = [37,38,39,40,41,42]

func unlock_card_list(index):
	match index:
		1:
			total_unlocked_card_list.append_array(boss_1_unlocked_card_list)
		2:
			total_unlocked_card_list.append_array(boss_2_unlocked_card_list)
		3:
			total_unlocked_card_list.append_array(boss_3_unlocked_card_list)
		4:
			total_unlocked_card_list.append_array(boss_4_unlocked_card_list)
		5:
			total_unlocked_card_list.append_array(boss_5_unlocked_card_list)
		6:
			total_unlocked_card_list.append_array(boss_6_unlocked_card_list)
		7:
			total_unlocked_card_list.append_array(boss_7_unlocked_card_list)
		8:
			total_unlocked_card_list.append_array(boss_8_unlocked_card_list)

func set_card_showcase():
	for c in card_showcase.get_children():
		if c != null:
			c.queue_free()
	
	for i in showcase_size:
		if showed_card_number + i < total_unlocked_card_list.size():
			
			var card_p = main.get_card(cards_list.keys()[\
				total_unlocked_card_list[showed_card_number + i]-1])
			
			card_showcase.add_child(card_p)
			
			card_p.change_card_in_deck.connect(_on_change_card_in_deck)
			card_p.card_state_machine.current_state_node.switch_to("state_showed_id",card_p)
			
			#位置
			card_p.global_position.x = showcase_unit_x * (i % showcase_row_x + 1)
			card_p.global_position.y = showcase_unit_y * (i / showcase_row_x + 1)

#var page_turning_time = 0.3

func _on_page_up_button_pressed():
	#main.play_sound(main.press_button)
	
	if showed_card_number + showcase_size < total_unlocked_card_list.size():
		
		showed_card_number += showcase_size
		
		#var t = get_tree().create_tween()
		#
		#t.tween_property(card_showcase,"global_position", \
			#Vector2(( - (showcase_unit_x * 3)),0) \
			#,page_turning_time)
		
		#t.finished.connect(
			#func():set_card_showcase()
		#)
		#
		#t.finished.connect(
			#func():card_showcase.global_position.x = (showcase_unit_x * 3)
		#)
		#
		#t.tween_property(card_showcase,"global_position", \
			#Vector2(0,0) \
			#,page_turning_time)
		
		#
		#t.tween_property(card_showcase,"global_position", \
			#Vector2(( + (showcase_unit_x * 3)),0) \
			#,0.00001)
		
		
		#card_showcase.global_position.x += (showcase_unit_x * 6)
		
		set_card_showcase()


func _on_page_down_button_pressed():
	#main.play_sound(main.press_button)
	
	if showed_card_number - showcase_size >= 0:
		
		showed_card_number -= showcase_size
		
		#var t = get_tree().create_tween()
		#
		#t.tween_property(card_showcase,"global_position", \
			#Vector2(( + (showcase_unit_x * 3)),0) \
			#,page_turning_time)
		#
		#t.tween_property(card_showcase,"global_position", \
			#Vector2(( - (showcase_unit_x * 3)),0) \
			#,0.00001)
		
		
		#card_showcase.global_position.x += (showcase_unit_x * 6)
		
		set_card_showcase()
		
		#t.tween_property(card_showcase,"global_position", \
			#Vector2(0,0) \
			#,page_turning_time)

#endregion

#region deck management

@onready var deck_root = $DeckRoot

var deck_card_editor_sample:= preload("res://src/scenes/UI/screens/select_deck_screen/deck_card_editor/deck_card_editor.tscn")

var editor_default_position = Vector2(1575,300)

var editor_space_between = 200

var editor_amount = 0

#修改卡组中的卡牌数目，影响右侧卡组界面
func _on_change_card_in_deck(id:String,amount:int):
	main.play_sound(main.select_card)
	
	var has_editor = false
	
	for editor in deck_root.get_children():
		if editor is DeckCardEditor && editor.card_id == id:
			editor.count += amount
			has_editor = true
	
	if amount > 0 && !has_editor:
		var deck_card_editor = deck_card_editor_sample.instantiate()
		deck_card_editor.card_sample = main.get_card(id)
		
		deck_card_editor.card_id = id
		deck_card_editor.count += amount
		deck_root.add_child(deck_card_editor)
		
		deck_card_editor.position = Vector2(editor_default_position.x,editor_default_position.y + (editor_space_between * editor_amount))
		
		editor_amount += 1
		
		deck_card_editor.change_card_in_deck.connect(_on_change_card_in_deck)
		deck_card_editor.cancel_editor.connect(_on_editor_cancelled)


func _on_editor_cancelled():
	editor_amount -= 1
	
	for i in deck_root.get_child_count():
		deck_root.get_child(i).position = Vector2(editor_default_position.x,editor_default_position.y + (editor_space_between * i))



func _on_scroller_scrolling(ratio):
	if editor_amount > 4:
		var l = editor_space_between * (editor_amount - 4) * ratio
		deck_root.global_position.y = - l

#endregion
