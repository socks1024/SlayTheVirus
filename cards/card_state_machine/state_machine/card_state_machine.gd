class_name CardStateMachine
extends Node


signal state_changed(last_state, current_state)

@onready var card_data = get_parent()

var current_state
var current_state_node : BaseState
var states := {}


#============================================================
#   Set/Get
#============================================================
func get_state_node_list() -> Array:
	return states.values()

func get_state_node(state) -> BaseState:
	return states[state] as BaseState

#============================================================
#   内置
#============================================================
func _ready():
	# 找到所有子状态机
	
	var children:Array[BaseState]
	get_child_states(children,preload("res://src/scripts/cards/card_state_machine/states/state_dragging.gd"))
	get_child_states(children,preload("res://src/scripts/cards/card_state_machine/states/state_hand.gd"))
	get_child_states(children,preload("res://src/scripts/cards/card_state_machine/states/state_placed.gd"))
	get_child_states(children,preload("res://src/scripts/cards/card_state_machine/states/state_showed.gd"))
	get_child_states(children,preload("res://src/scripts/cards/card_state_machine/states/state_in_deck_showed.gd"))
	get_child_states(children,preload("res://src/scripts/cards/card_state_machine/states/state_draw.gd"))
	
	for child in children:
		states[child.id] = child
	
	
	current_state = "state_draw_id"
	current_state_node = get_state_node(current_state)
	current_state_node.enter(card_data)


func get_child_states(children:Array,state_script:GDScript):
	var s1 = Node.new()
	s1.set_script(state_script)
	s1.state_machine = self
	add_child(s1)
	children.append(s1)


func _physics_process(delta):
	current_state_node.state_process(delta)

#============================================================
#   自定义
#============================================================
func switch_to(state,data):
	if state != current_state:
		current_state_node.exit()
		emit_signal("state_changed", current_state, state)
		# 切换到当前
		current_state = state
		current_state_node = get_state_node(current_state)
		current_state_node.enter(data)
