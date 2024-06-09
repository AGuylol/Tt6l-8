extends CharacterBody2D

@onready var healthbar = $Healthbar
@onready var coin_scene = preload("res://scenes/coins.tscn")
@onready var item_scene = preload("res://scenes/item.tscn")
var speed = 35
var player_chase = false
var player = null
var health = 50
var player_attacked = false

var knockback_force = Vector2()
var knockback_duration = 0.5
var knockback_timer = 0.0
var moving = false

@export var item_drop_chance = 100

func _ready():
	$AnimatedSprite2D.play("default")
	healthbar.init_health(health)
	$hitbox.area_entered.connect(_on_hitbox_area_entered)
	
func _physics_process(_delta):
	movement(_delta)
	slime_damaged()
	
	
func movement(delta):
	if knockback_timer > 0:
		velocity = knockback_force
		knockback_timer -= delta
		
	else:
		if player_chase and player:
			if moving:
				var direction = (player.position -  position).normalized()
				velocity = direction * speed
				
		else:
			velocity = Vector2.ZERO
			
	move_and_slide()
func slime_damaged():
	if player_attacked == true:
		health -= 20
		print("slime health " , health)
		if health <= 0 :
			self.queue_free()

func _on_detection_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_chase = true
		moving = true

func _on_detection_body_exited(_body):
	player = null
	player_chase = false
	moving = false


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
	
	if health <= 0:
		disable_collisions()
		moving = false
		$hitbox.monitoring = false
		$hitbox.area_entered.disconnect(_on_hitbox_area_entered)
		
		$AnimatedSprite2D.play("death")
		await get_tree().create_timer(0.6).timeout
		spawn_coins()
		spawn_item()
		queue_free()
		
	await get_tree().create_timer(6).timeout
	$AnimatedSprite2D.play("default")
		
func disable_collisions():
	$hitarea/CollisionShape2D.disabled = true
	$hitbox/CollisionShape2D.disabled = true
		
func apply_knockback(source_position , knockback_multiplier):
	var direction = (position - source_position).normalized()
	knockback_force = direction * knockback_multiplier
	knockback_timer = knockback_duration
	
func spawn_coins():
	var coin_count = randi() % 3 + 1
	for i in range(coin_count):
		var coin_instance = coin_scene.instantiate()
		coin_instance.position = position
		print("Spawning coin at position: ", coin_instance.position)
		get_parent().add_child(coin_instance)
		print("Coin spawned")

func spawn_item():
	if randi() % 100 < item_drop_chance:
		var item_instance = item_scene.instantiate()
		item_instance.position = position
		get_parent().add_child(item_instance)
		print("Item spawned at position: ", item_instance.position)
