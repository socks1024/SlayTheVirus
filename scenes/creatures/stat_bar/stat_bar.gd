class_name StatBar
extends Node2D

var creature:BaseCreature
@onready var backgroundfront = $BackGroundFront
@onready var backgroundback = $BackGroundBack
@onready var buff_root = $BuffRoot
@onready var health_bar = $HealthBar



func connect_creature(new_creature:BaseCreature):
	
	if creature != null:
		creature.healed.disconnect(refresh_health_bar)
		creature.damaged.disconnect(refresh_health_bar)
		creature.gained_block.disconnect(refresh_block)
		creature.damage_blocked.disconnect(refresh_block)
		creature.buff_changed.disconnect(refresh_buffs)
	
	self.creature = new_creature
	
	set_back_ground()
	
	$Name.text = creature.creature_name
	
	health_bar_max_value = creature.maxhealth
	health_bar_value = creature.health
	block_value = creature.block
	
	refresh_health_bar()
	refresh_block()
	
	refresh_buffs()
	
	creature.healed.connect(refresh_health_bar)
	creature.damaged.connect(refresh_health_bar)
	creature.gained_block.connect(refresh_block)
	creature.damage_blocked.connect(refresh_block)
	creature.buff_changed.connect(refresh_buffs)

#region health & block

var health_bar_max_value:int
var health_bar_value:int

func refresh_health_bar():
	health_bar_max_value = creature.maxhealth
	health_bar_value = creature.health
	
	$HealthBar.max_value = health_bar_max_value
	$HealthBar.value = health_bar_value
	
	$HealthNum.text = str(health_bar_value) + "/" + str(health_bar_max_value)

var block_value:int

func refresh_block():
	block_value = creature.block
	
	if block_value > 0:
		$BlockTexture.show()
	elif block_value <= 0:
		$BlockTexture.hide()
	$BlockTexture/BlockNum.text = str(block_value) 

#endregion

#region buffs

########新建buff节点本来应该写在这里，但因为某些弱智操作导致它现在在battle_screen里

var buff_count = 0

func refresh_buffs():
	buff_count = 0
	
	for b in $BuffRoot.get_children():
		remove_child(b)
	
	for buff in creature.buffs:
		$BuffRoot.add_child(buff)
		buff.position.x = buff_count * 90
		buff_count += 1


#endregion

#region backgrounds

func set_back_ground():
	match creature.id:
		"player":
			$BackGroundFront.texture = player_bg_front
			$BackGroundBack.texture = player_bg_back
		"boss_1_main":
			$BackGroundFront.texture = boss_1_bg_front
			$BackGroundBack.texture = boss_1_bg_back
		"boss_2_main":
			$BackGroundFront.texture = boss_2_bg_front
			$BackGroundBack.texture = boss_2_bg_back
		"boss_3_main":
			$BackGroundFront.texture = boss_3_bg_front
			$BackGroundBack.texture = boss_3_bg_back
		"boss_4_main":
			$BackGroundFront.texture = boss_4_bg_front
			$BackGroundBack.texture = boss_4_bg_back
		"boss_5_main":
			$BackGroundFront.texture = boss_5_bg_front
			$BackGroundBack.texture = boss_5_bg_back
		"boss_6_main":
			$BackGroundFront.texture = boss_6_bg_front
			$BackGroundBack.texture = boss_6_bg_back
		"boss_7_main":
			$BackGroundFront.texture = boss_7_bg_front
			$BackGroundBack.texture = boss_7_bg_back
		"boss_8_main":
			$BackGroundFront.texture = boss_8_bg_front
			$BackGroundBack.texture = boss_8_bg_back
		"boss_9_main":
			$BackGroundFront.texture = boss_9_bg_front
			$BackGroundBack.texture = boss_9_bg_back


#region background texture

var player_bg_front = preload("res://src/resources/statbar/你的血条-1.png")
var player_bg_back = preload("res://src/resources/statbar/你的血条-2.png")

var boss_1_bg_front = preload("res://src/resources/statbar/level1-1.png")
var boss_1_bg_back = preload("res://src/resources/statbar/level1-2.png")

var boss_2_bg_front = preload("res://src/resources/statbar/level2-1.png")
var boss_2_bg_back = preload("res://src/resources/statbar/level2-2.png")

var boss_3_bg_front = preload("res://src/resources/statbar/level3-1.png")
var boss_3_bg_back = preload("res://src/resources/statbar/level3-2.png")

var boss_4_bg_front = preload("res://src/resources/statbar/level4-1.png")
var boss_4_bg_back = preload("res://src/resources/statbar/level4-2.png")

var boss_5_bg_front = preload("res://src/resources/statbar/level5-1.png")
var boss_5_bg_back = preload("res://src/resources/statbar/level5-2.png")

var boss_6_bg_front = preload("res://src/resources/statbar/level6-1.png")
var boss_6_bg_back = preload("res://src/resources/statbar/level6-2.png")

var boss_7_bg_front = preload("res://src/resources/statbar/level7-1.png")
var boss_7_bg_back = preload("res://src/resources/statbar/level7-2.png")

var boss_8_bg_front = preload("res://src/resources/statbar/level8-1.png")
var boss_8_bg_back = preload("res://src/resources/statbar/level8-2.png")

var boss_9_bg_front = preload("res://src/resources/statbar/level9-1.png")
var boss_9_bg_back = preload("res://src/resources/statbar/level9-2.png")


#endregion

#endregion
