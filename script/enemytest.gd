extends CharacterBody2D

@onready var healthbar = $Healthbar
var speed = 35
var player_chase = false
var player = null
var health = 100
var player_attacked = false

var knockback_force = Vector2()
var knockback_duration = 0.5
var knockback_timer = 0.0


func _ready():
	$AnimatedSprite2D.play("default")
	healthbar.init_health(health)
	
func _physics_process(_delta):
	movement(_delta)
	slime_damaged()
	
	
func movement(_delta):
	if knockback_timer > 0:
		velocity = knockback_force
		knockback_timer -= _delta
		move_and_slide()
	else:
		if player_chase and player:
			var direction = (player.position - position).normalized()
			velocity = direction * speed
			move_and_slide()
		else:
			velocity = Vector2.ZERO

func slime_damaged():
	if player_attacked == true:
		health -= 20
		print("slime health " , health)
		if health <= 0 :
			self.queue_free()

func _on_detection_body_entered(body):
	if not body.is_in_group("enemy"):
		player = body
		player_chase = true

func _on_detection_body_exited(_body):
	player = null
	player_chase = false


func _on_hitbox_area_entered(area):
	var damage
	var knockback_multiplier 
	if area.is_in_group("bullet"):
		damage = 50
		knockback_multiplier = 100
		take_damage(damage)
		healthbar.health = health
		apply_knockback(area.position , knockback_multiplier)
		
	elif area.is_in_group("sword"):
		knockback_multiplier = 10
		print("worked")
		damage = 20
		take_damage(damage)
		healthbar.health = health
		apply_knockback(area.position , knockback_multiplier)
		
func take_damage(damage):
	
	health -= damage
	print(health)
	$AnimatedSprite2D.play("hit")
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.play("default")
	if health <= 0:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(0.8).timeout
		queue_free()
		
func apply_knockback(source_position , knockback_multiplier):
	var direction = (position - source_position).normalized()
	knockback_force = direction * knockback_multiplier
	knockback_timer = knockback_duration
	
