class_name BaseCreature
extends Node2D

var id:String

func initialize():
	pass

#region signals

signal gained_block
signal damage_blocked
signal block_broken

signal healed
signal damaged
signal dead

#endregion

var creature_name:String

#region health & block

var maxhealth:int
var health:int:
	set(value):
		
		var original_health = health
		health = value
		
		if health > maxhealth:
			health = maxhealth
		
		if health <= 0:
			health = 0
			dead.emit()
		
		if health < original_health:
			damaged.emit()
		elif health > original_health:
			healed.emit()
var block:int:
	set(value):
		
		if value < block:
			block = value
			if block <= 0:
				block = 0
				block_broken.emit()
			else:
				damage_blocked.emit()
		elif value > block:
			gained_block.emit()
			block = value

func get_hurt(damage):
	if damage > block:
		damage -= block
		block = 0
		health -= damage
	else:
		block -= damage

#endregion

#region buffs

var buffs:Array[BaseBuff]

signal buff_changed

func gain_buff(new_buff:BaseBuff):
	
	var has_same_buff = false
	
	for b in buffs:
		if b.id == new_buff.id:
			b.amount += new_buff.amount
			has_same_buff = true
	
	if !has_same_buff:
		buffs.append(new_buff)
		new_buff.clear_buff.connect(on_clear_buff)
	
	buff_changed.emit()

func get_buff_amount(id:String) -> int:
	for b in buffs:
		if b.id == id:
			return b.amount
	
	return 0

func on_clear_buff(buff):
	for b in buffs:
		if b == buff:
			b.queue_free()
	
	buff_changed.emit()

#endregion
