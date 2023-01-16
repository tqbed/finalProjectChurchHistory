extends KinematicBody2D

const ACCELERATION = 512
const MAX_SPEED = 96
const FRICTION = 0.25
const AIR_RESISTANCE = 0.02
const GRAVITY = 200
const JUMP_FORCE = 64

var motion = Vector2.ZERO

onready var sprite = $Sprite

func _ready():
	print("please god help me")
	var new_dialog = Dialogic.start('Unit1Temple')
	add_child(new_dialog)
	
	new_dialog.connect("WHY", self, "disable_input")
	new_dialog.connect("HELP", self, "enable_input")
		
func _physics_process(delta):
		var x_input = Input.get_action_raw_strength("ui_right") - Input.get_action_strength("ui_left")
		
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
	
func disable_input():
	print("running disable input")
	Input.set_action_restriction("ui_right", InputEvent.ACTION_RESTRICT_INPUT)
	Input.set_action_restriction("ui_left", InputEvent.ACTION_RESTRICT_INPUT)
	Input.set_action_restriction("ui_up", InputEvent.ACTION_RESTRICT_INPUT)
	
func enable_input():
	print("running enable output")
	Input.set_action_restriction("ui_right", InputEvent.ACTION_RESTRICT_NONE)
	Input.set_action_restriction("ui_left", InputEvent.ACTION_RESTRICT_NONE)
	Input.set_action_restriction("ui_up", InputEvent.ACTION_RESTRICT_NONE)
