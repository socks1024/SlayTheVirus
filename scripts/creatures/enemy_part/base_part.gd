class_name BasePart
extends BaseCreature

#region initialize

#region resources

@export var normal_img:Texture2D
@export var angry_img:Texture2D
@export var destroyed_img:Texture2D

@export var appear_line:String
@export var angry_line:String
@export var dead_line:String

#endregion

@onready var texture_size = Vector2(normal_img.get_width(),normal_img.get_height())

@export var part_name:String
@export var part_mhp:int
@export var part_id:String

func initialize():
	self.creature_name = part_name
	self.maxhealth = part_mhp
	self.health = part_mhp
	
	self.id = part_id
	
	self.dead.connect(_on_destroyed)

#endregion

@onready var main = get_tree().get_first_node_in_group("main")
@onready var boss = get_parent()

@onready var img = $TextureRect
@export var is_main_part:bool

func _ready():
	initialize()
	
	#img.texture = normal_img
	
	img.mouse_entered.connect(_on_texture_rect_mouse_entered)
	img.mouse_exited.connect(_on_texture_rect_mouse_exited)
	
	damaged.connect(_on_damaged)
	dead.connect(_on_destroyed)


func _process(delta):
	pass


#region intention

@export var intention_offset:Vector2

var intentions:Array[BaseIntention]
var intention_width = 120

func set_intention(intention:BaseIntention):
	add_child(intention)
	intention.battle_manager = main.battle_manager
	intentions.append(intention)
	sort_intention()

func sort_intention():
	for i in intentions.size():
		intentions[i].position = intention_offset + Vector2( - (intentions.size() - 1) * intention_width + intention_width * i,0)

var tween:Tween

var player_position = Vector2(2000,600)
var boss_position = Vector2(-100,600)
var no_position = Vector2(300,2000)

func play_intention(intention:BaseIntention):
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	
	if intention.target_type == intention.TargetType.PLAYER:
		tween.parallel().tween_property(intention, "position", player_position, 0.2)
	if intention.target_type == intention.TargetType.BOSS:
		tween.parallel().tween_property(intention, "position", boss_position, 0.2)
	if intention.target_type == intention.TargetType.NO_TARGET:
		tween.parallel().tween_property(intention, "position", no_position, 0.2)
	
	tween.finished.connect(func():remove_child(intention))

#endregion

var skip_next_turn = false

func act():
	pass

#region part states

@export var hurt_color = Color(1,0.4,0.4)

func _on_damaged():
	pass

var destroyed = false

func _on_destroyed():
	destroyed = true
	img.texture = destroyed_img
	modulate_color = Color(0.2,0.2,0.2)
	
	if is_main_part:
		boss._on_main_part_dead()

#endregion


#region GUI & animation

signal focus_part(part:BasePart)

var modulate_color = Color.WHITE

#var is_highlight = false

func _on_texture_rect_mouse_entered():
	#is_highlight = true
	if is_main_part:
		boss.modulate = boss.highlight_color
	focus_part.emit(self)

func _on_texture_rect_mouse_exited():
	#is_highlight = false
	if is_main_part:
		boss.modulate = Color.WHITE
	focus_part.emit(boss.main_part)

#endregion
