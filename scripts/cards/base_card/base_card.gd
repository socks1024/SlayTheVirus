class_name BaseCard
extends Control

var battle_manager

var location:Vector2
var cell_location:Vector2

func initialize():
	
	card_name = tr(id + "_NAME")
	
	conditions.resize(shape_arrow.size())
	condition_cards.resize(shape_arrow.size())
	
	if $CardTemp/Name != null && $CardTemp/Description != null:
		card_temp_textures = $CardTemp
		card_tetris_textures = $CardTetris
		
		$CardTemp/Name.text = card_name
		$CardTemp/Description.text = card_description


##通过箭头的方式选定目标
func get_target(target:BasePart):
	if target_type == TargetType.SINGLE_PART:
		card_target = target


func _on_card_build_finished():
	
	if !card_temp_textures.mouse_entered.is_connected(_on_mouse_entered):
		card_temp_textures.mouse_entered.connect(_on_mouse_entered)
	if !card_temp_textures.mouse_entered.is_connected(_on_mouse_exited):
		card_temp_textures.mouse_exited.connect(_on_mouse_exited)
	
	for t in card_tetris_textures.get_children():
		if !t.mouse_entered.is_connected(_on_mouse_entered):
			t.mouse_entered.connect(_on_mouse_entered)
		if !t.mouse_entered.is_connected(_on_mouse_exited):
			t.mouse_exited.connect(_on_mouse_exited)


#region types

enum CardType{
	ATTACK,
	DEFEND,
	HEAL,
	BUFF,
	DEBUFF,
	EXPAND,
	TRASH,
}

enum TargetType{
	SELF,
	SINGLE_PART,
	ALL_PART,
}

enum AbilityType{
	BASIC,
	BUFF,
	DEBUFF,
	SELF_EFFECT,
	EXPAND,
	TRASH,
}

#endregion

#region data

var exhausted = false
var acts_amount = 1

var use_default_position = true
var default_position = Vector2.ZERO

var card_target:BaseCreature

var id:String
var card_type_1:CardType
var card_type_2:CardType
var target_type:TargetType
var ability_type:AbilityType

var card_name:String
var card_description:String

var img:Resource

var shape:Array[Vector2] = [Vector2.ZERO,Vector2.LEFT,Vector2.UP,Vector2.RIGHT]
var shape_arrow:Array[Vector2]
var arrow_face:Array[Vector2]

var card_tetris_textures:TextureRect
var card_temp_textures:TextureRect

var base_damage = 0
var base_block = 0
var base_magic_number = 0

var damage_modifier = 0
var block_modifier = 0
var magic_number_modifier = 0

var damage = 0:
	get():
		damage = damage_modifier + base_damage
		return damage
var block = 0:
	get():
		block = block_modifier + base_block
		return block
var magic_number = 0:
	get():
		magic_number = magic_number_modifier + base_magic_number
		return magic_number

func set_modifier():
	damage_modifier = 0
	block_modifier = 0
	magic_number_modifier = 0
	acts_amount = 1

#endregion

#region acts

var conditions:Array[bool]
var condition_cards:Array[BaseCard]

#箭头需求满足时执行，回合结束时最先执行的操作
func arrow_act():
	pass


#回合末时与整张卡牌一起进行的操作
func act():
	pass


#箭头需求满足时与正常操作一起执行的操作
func condition_act():
	pass


#打出后执行的操作
func after_play_act():
	pass


#未打出时执行的操作
func not_play_act():
	pass


#endregion

#region animation state machine

var card_state_machine:CardStateMachine

var mouse_in = false
var can_drag = true


func rotate_tetris(degree):
	for i in shape.size():
		shape[i] = shape[i].rotated(-degree)
	for i in shape_arrow.size():
		shape_arrow[i] = shape_arrow[i].rotated(-degree)
	for i in arrow_face.size():
		arrow_face[i] = arrow_face[i].rotated(-degree)
	card_tetris_textures.rotation -= degree

##鼠标进入时
func _on_mouse_entered():
	mouse_in = true
	print(card_name)

##鼠标离开时
func _on_mouse_exited():
	mouse_in = false


#endregion

#region UI state machine

signal change_card_in_deck(id:String,amount:int)

#endregion
