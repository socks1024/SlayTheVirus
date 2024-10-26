class_name BaseIntention
extends Node2D

#region resources

var attack_intention_texture = preload("res://src/resources/intention&table/敌人攻击.png")
var defense_intention_texture = preload("res://src/resources/intention&table/敌人防御.png")
var buff_intention_texture = preload("res://src/resources/intention&table/敌人增益.png")
var debuff_intention_texture = preload("res://src/resources/intention&table/敌人减益.png")
var unknown_intention_texture = preload("res://src/resources/intention&table/敌人未知.png")
var stun_intention_texture = preload("res://src/resources/intention&table/晕眩！.png")

#endregion

enum IntentionType{
	ATTACK,
	DEFENSE,
	BUFF,
	DEBUFF,
	UNKNOWN,
	STUN,}

enum TargetType{
	PLAYER,
	BOSS,
	NO_TARGET
}

var battle_manager

var sprite
var label

var intention_type:IntentionType
var target_type:TargetType

var amount:int
var target:BaseCreature
var source:BasePart

func _init(intention_type:IntentionType,amount:int,target_type:TargetType,target:BaseCreature,source:BasePart):
	self.intention_type = intention_type
	self.amount = amount
	self.target_type = target_type
	
	self.target = target
	self.source = source
	
	sprite = Sprite2D.new()
	label = Label.new()
	
	add_child(sprite)
	add_child(label)
	
	label.label_settings = preload("res://src/resources/global/fonts/Font_60_16.tres")
	
	match intention_type:
		IntentionType.ATTACK:
			sprite.texture = attack_intention_texture
		IntentionType.DEFENSE:
			sprite.texture = defense_intention_texture
		IntentionType.BUFF:
			sprite.texture = buff_intention_texture
		IntentionType.DEBUFF:
			sprite.texture = debuff_intention_texture
		IntentionType.UNKNOWN:
			sprite.texture = unknown_intention_texture
		IntentionType.STUN:
			sprite.texture = stun_intention_texture
	
	label.text = str(amount)


func act():
	pass
