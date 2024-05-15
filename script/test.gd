extends CharacterBody2D

const accel = 800
const friction = 400
const max_speed = 100

enum {idle , walk}
var state = idle

@onready var animationtree = $AnimationTree
@onready var state_machine = animationtree["parameters/playback"]

var blend_position : Vector2 = Vector2.ZERO
var blend_pos_paths = [
	"parameters/idle/idle_bs2d/blend_position",
	"parameters/walk/walk_bs2d/blend_position"
]
var animtree_state_keys = [
	"idle",
	"walk"
]

func _physics_process(delta):
	move(delta)
	movement_anim()
	look_at(get_global_mouse_position())
	
	
func move(delta):
	var input_vector = Input.get_vector("left" , "right" , "up" , "down")
	if input_vector == Vector2.ZERO:
		state = idle
		apply_friction(friction * delta)
	else:
		state = walk
		apply_movement(input_vector * accel * delta)
		blend_position = input_vector
		
	move_and_slide()
	
func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
		
func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(max_speed)

func movement_anim() -> void:
	state_machine.travel(animtree_state_keys[state])
	animationtree.set(blend_pos_paths[state] , blend_position)
