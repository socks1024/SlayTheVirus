class_name CardBuilder
extends Node

@onready var main = $".."

var card_sample_packed = preload("res://src/scenes/cards/cards/card_sample.tscn")
var card_state_machine_script:= preload("res://src/scripts/cards/card_state_machine/state_machine/card_state_machine.gd")

var card_scripts:Array[GDScript]


signal card_build_finished()

func build_empty_card(card_script:GDScript) -> BaseCard:
	var card = card_sample_packed.instantiate()
	self.add_child(card)
	
	card.set_script(card_script)
	card.initialize()
	card_build_finished.connect(card._on_card_build_finished)
	card.battle_manager = main.battle_manager
	
	#region card state img
	
	var card_back = card.get_node("CardTemp/card_back")
	var card_img = card.get_node("CardTemp/card_img")
	var light_left = card.get_node("CardTemp/light_left")
	var light_right = card.get_node("CardTemp/light_right")
	var icon_left = card.get_node("CardTemp/icon_left")
	var icon_right = card.get_node("CardTemp/icon_right")
	
	card_back.texture = card.img
	#card_back.texture = card_back_texture
	
	#if card.card_type_1 > card.card_type_2:
		#var t = card.card_type_2
		#card.card_type_1 = card.card_type_2
		#card.card_type_1 = t
	
	match card.card_type_1:
		card.CardType.ATTACK:
			light_left.texture = light_atk_left_texture
			icon_left.texture = icon_atk_left
		card.CardType.DEFEND:
			light_left.texture =  light_def_left_texture
			icon_left.texture = icon_def_left
		card.CardType.HEAL:
			light_left.texture = light_cure_left_texture
			icon_left.texture = icon_cure_left
		card.CardType.BUFF:
			light_left.texture = light_power_left_texture
			icon_left.texture = icon_power_left
		card.CardType.DEBUFF:
			pass
		card.CardType.EXPAND:
			light_left.texture = light_expand_left_texture
			icon_left.texture = icon_expand_left
		card.CardType.TRASH:
			light_left.texture = light_trash_left_texture
			icon_left.texture = icon_trash_left
	
	#match card.card_type_2:
	match card.card_type_1:
		card.CardType.ATTACK:
			light_right.texture = light_atk_right_texture
			icon_right.texture = icon_atk_left
			icon_right.flip_h = true
		card.CardType.DEFEND:
			light_right.texture = light_def_right_texture
			icon_right.texture = icon_def_right
		card.CardType.HEAL:
			light_right.texture = light_cure_left_texture
			light_right.flip_h = true
			icon_right.texture = icon_cure_right
		card.CardType.BUFF:
			light_right.texture = light_power_right_texture
			icon_right.texture = icon_power_right
		card.CardType.DEBUFF:
			light_right.texture = light_power_right_texture
			icon_right.texture = icon_dispower_right
		card.CardType.EXPAND:
			light_right.texture = light_expand_right_texture
			icon_right.texture = icon_expand_right
		card.CardType.TRASH:
			light_right.texture = light_trash_right_texture
			icon_right.texture = icon_trash_right
	
	#endregion
	
	#region tetris state img
	
	for v in card.shape:
		var trect = TextureRect.new()
		
		$CardSample/CardTetris.add_child(trect)
		trect.position.x = 100 * v.x - 50
		trect.position.y = 100 * v.y - 50
		
		#region background tetris block
		
		if card.ability_type == card.AbilityType.TRASH:
			trect.texture = tetris_play_or
		elif card.ability_type == card.AbilityType.EXPAND:
			trect.texture = tetris_expand
		elif card.card_type_1 == card.CardType.ATTACK:
			trect.texture = tetris_attack
		elif card.card_type_1 == card.CardType.DEFEND:
			trect.texture = tetris_defend
		elif card.card_type_1 == card.CardType.HEAL:
			trect.texture = tetris_heal
		else:
			trect.texture = tetris_buff
		
		#endregion
		
		#region arrow tetris block
		
		if card.shape_arrow.size() > 0:
			
			var num = 0
			
			for a in card.shape_arrow:
				if v == a:
					
					var arr_rect = TextureRect.new()
					
					match card.ability_type:
						card.AbilityType.BUFF:
							arr_rect.texture = tetris_arrow_buff
						card.AbilityType.DEBUFF:
							arr_rect.texture = tetris_arrow_debuff
						card.AbilityType.SELF_EFFECT:
							arr_rect.texture = tetris_arrow_self_buff
						card.AbilityType.EXPAND:
							arr_rect.texture = tetris_arrow_stay_close
					
					trect.add_child(arr_rect)
					arr_rect.position = Vector2.ZERO
					arr_rect.pivot_offset.x = arr_rect.size.x/2
					arr_rect.pivot_offset.y = arr_rect.size.y/2
					
					match card.arrow_face[num]:
						Vector2.LEFT:
							pass
						Vector2.RIGHT:
							arr_rect.flip_h = true
						Vector2.DOWN:
							arr_rect.rotation -= PI/2
						Vector2.UP:
							arr_rect.rotation += PI/2
				else:
					num += 1
		#endregion
	
	#endregion
	
	#region card state machine
	
	var card_state_machine = CardStateMachine.new()
	card.add_child(card_state_machine)
	card.card_state_machine = card_state_machine
	
	#endregion
	
	for n in get_children():
		remove_child(n)
	
	card_build_finished.emit()
	
	return card


#region texture

var card_img_texture:Texture
var light_left_texture:Texture
var light_right_texture:Texture
var icon_left_texture:Texture
var icon_right_texture:Texture

#按照卡牌类型分的6种砖块（未调整）
var tetris_attack:= preload("res://src/resources/cards/tetris/2.png")
var tetris_defend:= preload("res://src/resources/cards/tetris/3.png")
var tetris_buff:= preload("res://src/resources/cards/tetris/4.png")
var tetris_play_or:= preload("res://src/resources/cards/tetris/5.png")
var tetris_expand:= preload("res://src/resources/cards/tetris/6.png")
var tetris_heal:= preload("res://src/resources/cards/tetris/1.png")

#4种箭头（未调整）
var tetris_arrow_buff:= preload("res://src/resources/cards/tetris/增益.png")
var tetris_arrow_debuff:= preload("res://src/resources/cards/tetris/减益.png")
var tetris_arrow_self_buff:= preload("res://src/resources/cards/tetris/双向.png")
var tetris_arrow_stay_close:= preload("res://src/resources/cards/tetris/扩展.png")

##细胞
#var cells_atk_texture:= preload("res://src/resources/cards/cells/atk.png")
#var cells_def_texture:= preload("res://src/resources/cards/cells/def.png")
#var cells_power_texture:= preload("res://src/resources/cards/cells/power.png")
#var cells_dispower_texture:= preload("res://src/resources/cards/cells/dispower.png")
#var cells_extend_texture:= preload("res://src/resources/cards/cells/extend.png")
#var cells_cure_texture:= preload("res://src/resources/cards/cells/cure.png")

#背景炫光
var light_atk_left_texture:= preload("res://src/resources/cards/light/basic_atk_light_left.png")#左侧攻击
var light_atk_right_texture:= preload("res://src/resources/cards/light/basic_atk_light_right.png")#右侧攻击
var light_def_left_texture:= preload("res://src/resources/cards/light/basic_def_light_left.png")#右侧防御
var light_def_right_texture:= preload("res://src/resources/cards/light/basic_def_light_right.png")#右侧防御
var light_power_left_texture:= preload("res://src/resources/cards/light/basic_power_light_left.png")#左侧buff
var light_power_right_texture:= preload("res://src/resources/cards/light/basic_power_light_right.png")#右侧buff
var light_expand_left_texture:= preload("res://src/resources/cards/light/basic_extend_light_left.png")#左侧扩展格子
var light_expand_right_texture:= preload("res://src/resources/cards/light/basic_extend_light_right.png")#右侧扩展格子
var light_cure_left_texture:= preload("res://src/resources/cards/light/basic_cure_light_left.png")#左侧治疗
var light_trash_left_texture:= preload("res://src/resources/cards/light/basic_garbage_light_left.png")
var light_trash_right_texture:= preload("res://src/resources/cards/light/basic_garbage_light_right.png")

#ICON
var icon_atk_left:= preload("res://src/resources/cards/logo/basic_atk_knife_left.png")
var icon_def_left:= preload("res://src/resources/cards/logo/basic_def_shield_left.png")
var icon_def_right:= preload("res://src/resources/cards/logo/basic_def_shield_right.png")
var icon_power_left:= preload("res://src/resources/cards/logo/basic_power_arrow_left.png")
var icon_power_right:= preload("res://src/resources/cards/logo/basic_power_arrow_right.png")
var icon_expand_left:= preload("res://src/resources/cards/logo/basic_extend_left.png")
var icon_expand_right:= preload("res://src/resources/cards/logo/basic_extend_right.png")
var icon_cure_left:= preload("res://src/resources/cards/logo/basic_cure_left.png")
var icon_cure_right:= preload("res://src/resources/cards/logo/basic_cure_right.png")
var icon_dispower_right:= preload("res://src/resources/cards/logo/basic_dispower_arrow_right.png")
var icon_trash_left:= preload("res://src/resources/cards/logo/basic_trash_left.png")
var icon_trash_right:= preload("res://src/resources/cards/logo/basic_trash_right.png")


#endregion


func _enter_tree():
	
	#region load card scripts
	
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/attack.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/defend.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/attack_together.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/defend_together.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/surprise_attack.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/delay.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/bloodletting.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/bioelectricity.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/1-9/mass_brawl.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/reservist.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/reserve_team.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/inspire.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/ready_to_go.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/forlorn_hope.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/parry.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/fever.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/boost_immunity.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/10-18/whirlwind_slash.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/epinephrine.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/bleeding_heavily.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/suppress.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/indifference_defense.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/illness_charge.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/more_blood_supply.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/saturation_strike.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/search_the_battlefield.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/19-27/stem_cell.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/killer_cell.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/antibody.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/rage.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/counter_attack.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/macrophage.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/cytokines.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/antibiotic.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/red_blood_cell.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/28-36/renewal_organ.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/37-42/weakness.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/37-42/weaken_immunity.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/37-42/necrosis.gd"))
	
	card_scripts.append(preload("res://src/scripts/cards/cards/37-42/exhaustion.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/37-42/thrombus.gd"))
	card_scripts.append(preload("res://src/scripts/cards/cards/37-42/canceration.gd"))
	
	
	#endregion
	
	for c in card_scripts:
		var node = c.new()
		node.initialize()
		var key = node.id
		get_parent().card_list[key] = c
