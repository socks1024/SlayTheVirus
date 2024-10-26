class_name BaseBuff
extends Node2D

var id:String
var amount = 0:
	set(value):
		amount = value
		
		if amount <= 0:
			amount = 0
			clear_buff.emit(self)
		
		label.text = str(amount)

signal clear_buff(buff:BaseBuff)

var buff_owner:BaseCreature

var buff_texture:Texture

var sprite:Sprite2D
var label:Label

func initialize(amount:int):
	self.amount = amount
	
	if $Sprite2D != null && $Label != null:
		sprite = $Sprite2D
		label = $Label
		
		sprite.texture = buff_texture
		label.text = str(amount)


#region acts

#正常操作
func act():
	pass

#回合结束时执行的操作
func act_on_turn_end():
	pass

#endregion

#region textures

var inactivation_texture = preload("res://src/resources/buff/1.png")
var trauma_texture = preload("res://src/resources/buff/2.png")
var disinfection_texture = preload("res://src/resources/buff/3.png")
var stun_texture = preload("res://src/resources/buff/4.png")
var vulnerable_texture = preload("res://src/resources/buff/5.png")
var spike_texture = preload("res://src/resources/buff/6.png")
var paralysis_texture = preload("res://src/resources/buff/7.png")
var proliferation_texture = preload("res://src/resources/buff/9.png")

#endregion
