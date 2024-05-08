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
	if player_attacked == true:
		health -= 20
		print("slime health " , health)
		if health <= 0 :
			self.queue_free()

func _on_detection_body_entered(body):
	player = body
	player_chase = true

func _on_detection_body_exited(body):
	player = null
	player_chase = false

func enemy():
	pass

func _on_timer_timeout():
	$Timer.stop()
	player_attacked = false
	
	
func _on_hitbox_area_entered(area):
	var damage
	if area.has_method("arrow_deal_damage"):
		damage = 50
		take_damage(damage)
		
func take_damage(damage):
	health -= damage
	print(health)
	if health <= 0:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(0.8).timeout
		queue_free()
	
