extends CharacterBody2D

@onready var healthbar = $Healthbar
var speed = 35
var player_chase = false
var player = null
var health = 100
var player_attacked = false

func _ready():
	$AnimatedSprite2D.play("default")
	healthbar.init_health(health)
	
func _physics_process(_delta):
	movement()
	slime_damaged()
	
	
func movement():
	if player_chase:
		position += (player.position - position) / speed


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
	if area.is_in_group("bullet"):
		damage = 50
		take_damage(damage)
		healthbar.health = health
		
		
	elif area.is_in_group("sword"):
		print("worked")
		damage = 20
		take_damage(damage)
		healthbar.health = health
		
		
func take_damage(damage):
	
	health -= damage
	print(health)
	if health <= 0:
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(0.8).timeout
		queue_free()
		

	
