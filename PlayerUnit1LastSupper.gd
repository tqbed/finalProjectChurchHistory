extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 96
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const JUMP_FORCE = 64

var motion = Vector2.ZERO

var input_enabled = true 

onready var sprite = $Sprite

func _ready():
	var new_dialog = Dialogic.start('Unit1LastSupper')

	new_dialog.connect("timeline_start", self, "disable_input")
	new_dialog.connect("timeline_end", self, "enable_input")
	
	add_child(new_dialog)
	
func _physics_process(delta):
	var x_input

	if input_enabled:
		x_input = Input.get_action_raw_strength("ui_right") - Input.get_action_strength("ui_left")
	else:
		x_input = 0
		
	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0 
		
	else: 
			motion.x = lerp(motion.x, 0, FRICTION)
			
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
			
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE

	motion = move_and_slide(motion, Vector2.UP)

func disable_input(_timeline_name):
	print("running disable input")
	input_enabled = false 
	
	
	
func enable_input(_timeline_name):
	print("running enable output")
	input_enabled = true 
	
