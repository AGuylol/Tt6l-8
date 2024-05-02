extends CharacterBody2D

var speed = 35
var player_chase = false
var player = null
var health = 100
var player_attacked = false

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	movement()
	slime_damaged()
	
func movement():
	if player_chase:
		position += (player.position - position) / speed

func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		player_attacked = true
	

func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		player_attacked = false
		

func slime_damaged():
	if player_attacked and Global.player_current_attacked == true:
		health = health - 20
		print("slime health " , health)
		if health <= 0 :
			self.queue_free()


func _on_detection_body_entered(body):
	player = body
	player_chase = true

func _on_detection_body_exited(body):
	player = null
	player_chase = false
