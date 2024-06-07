extends Area2D


@onready var animated_sprite = $AnimatedSprite2D
@onready var player = get_parent().find_child("player")
 
var acceleration: Vector2 = Vector2.ZERO 
var velocity: Vector2 = Vector2.ZERO
 
func _physics_process(delta):
 
	acceleration = (player.position - position).normalized() * 700
 
	velocity += acceleration * delta
	rotation = velocity.angle()
 
	velocity = velocity.limit_length(150)
 
	position += velocity * delta
 
	await get_tree().create_timer(3).timeout
	queue_free()
	
func _on_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
