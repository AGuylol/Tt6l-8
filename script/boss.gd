extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var sprite = $Sprite2D
@onready var healthbar = $CanvasLayer/ProgressBar

var direction: Vector2
var defence: float = 0.0

var health = 100:
	set(value):
		health = value
		healthbar.value = value
		if value <= 0:
			healthbar.visible = false
			find_child("FiniteStateMachine")
		elif value <= healthbar.max_value / 2 and defence == 0:
			defence = 5
			find_child("FiniteStateMachine").change_state("ArmorBuff")
			
			
func _ready():
	set_physics_process(false)

func _process(delta):
	direction = player.position - position

	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
		
		
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
	
	

func _on_hitbox_area_entered(area):
	if area.is_in_group("sword"):
		health -= 10 - defence
		
	elif area.is_in_group("arrow"):
		health -= 30 - defence
		
