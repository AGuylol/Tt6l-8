extends CharacterBody2D
class_name Player

var enemy_inattack_range = false
var enemy_attack_cooldown = true


var player_alive = false
var attacking = false
var sword_equiped = true

var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")

var max_speed = 100
var accel = 800
var friction = 600
enum {idle , walk}
var state = idle

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var healthbar = $Healthbar
@onready var regen_timer = $regen_timer
var blend_position : Vector2 = Vector2.ZERO

var dash_speed = 400
var dash_duration = 0.075
var is_dashing = false
var can_dash = true
var dash_direction : Vector2
var can_move : bool = true


@onready var dash_period = $dash_period
@onready var dash_cooldown_timer = $dash_cooldown
@onready var anim_player = $AnimationPlayer
var knockback_force = 100
var knockback_duration = 0.5
var is_knocked_back = false


@onready var camera = $Camera2D
var normal_zoom = Vector2(1.5, 1.5)
var zoomed_in = Vector2(0.5, 0.5)

var took_damage : bool = false



func _ready():
	animation_tree.active = true
	healthbar.init_health(global.player_health)
	$playerhitbox.area_entered.connect(_on_playerhitbox_area_entered)
	SceneManager.on_trigger_spawn_level.connect(_on_spawn)
	

func _on_spawn():
	global_position = position
	
func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	_on_attack_timeout()
	bow_shoot()
	current_camera()

	if global.player_health <= 0:
		player_alive = false 
		$playerhitbox.monitoring = false
		$playerhitbox.area_entered.disconnect(_on_playerhitbox_area_entered)
		get_tree().change_scene_to_file("res://gameover/gameover.tscn")
		global.reset_stats()
	
		
	
func player_movement(delta):
	if can_move:
		var input_vector = Input.get_vector("left", "right", "up", "down")
		if is_knocked_back:
			apply_friction(friction * delta)
		else:
			
			if input_vector == Vector2.ZERO and not is_dashing:
				state = idle
				apply_friction(friction * delta)
			elif not is_dashing:
				state = walk
				apply_movement(input_vector * accel * delta)
				blend_position = input_vector

			if Input.is_action_just_pressed("dash") and can_dash:
				start_dash(input_vector)
		
		move_and_slide()
		update_parameters(input_vector)



func start_dash(input_vector):
	is_dashing = true
	can_dash = false
	dash_direction = input_vector.normalized()
	velocity = dash_direction * dash_speed
	dash_period.start(dash_duration)
	$dash_cooldown.start()


	
	
func update_parameters(input_vector):
	if input_vector == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"]= false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"]= true
		
	if Input.is_action_just_pressed("attack"):
		animation_tree["parameters/conditions/attacking"]= true
		$AudioStreamPlayer2D.play()
		print(scene_manager2.current_scene)
	else:
		animation_tree["parameters/conditions/attacking"]= false
	
	if input_vector != Vector2.ZERO:
		animation_tree["parameters/idle/blend_position"] = input_vector
		animation_tree["parameters/walk/blend_position"] = input_vector
		animation_tree["parameters/attacking/blend_position"] = input_vector


func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO
		
		
		
func apply_movement(amount) -> void:
	velocity += amount
	velocity = velocity.limit_length(max_speed)
	


func _on_playerhitbox_body_entered(body):
	if body.is_in_group("enemy"):
		enemy_inattack_range = true
		$enemy_attack_timer.start()
		
		var knockback_direction = (global_position - body.global_position).normalized()
		apply_knockback(knockback_direction)
		global.player_health -= 10
		healthbar.health = global.player_health
		print("Player health:", global.player_health)
		if global.player_health <= 0:
			player_alive = false
			
			
	


func _on_playerhitbox_body_exited(body):
	if body.is_in_group("enemy"):
		enemy_inattack_range= false
		$enemy_attack_timer.stop()

		
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown:
		global.player_health -= 15
		print(global.player_health)
		print("enemy attacked you")
		took_damage = true
		await get_tree().create_timer(0.5).timeout
		enemy_attack_cooldown = false
		healthbar.health = global.player_health
		regen_timer.start()
		
func _on_attack_timeout():
	enemy_attack_cooldown = false

func bow_shoot():
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("bow") and bow_cooldown:
		$AudioStreamPlayer2D2.play()
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation 
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
		
		
		if "arquebus" in global.player_inventory:
			shoot_arrow($Marker2D.global_position, $Marker2D.rotation + 0.4)
		
		await get_tree().create_timer(global.gun_cooldown).timeout
		bow_cooldown = true
		
func shoot_arrow(position, rotation):
	var arrow_instance = arrow.instantiate()
	arrow_instance.rotation = rotation
	arrow_instance.global_position = position
	add_child(arrow_instance)
	
	
func _on_enemy_attack_timer_timeout():
	enemy_attack_cooldown = true


func _on_dash_period_timeout():
	is_dashing = false
	max_speed = 100
	accel = 800

func _on_dash_cooldown_timeout():
	can_dash = true
	
func apply_knockback(direction: Vector2):
	is_knocked_back = true
	velocity = direction * knockback_force
	await get_tree().create_timer(knockback_duration).timeout
	is_knocked_back = false
	

# damage to player
func _on_playerhitbox_area_entered(area):
	if area.is_in_group("spikes"):
		global.player_health -=5
	elif area.is_in_group("lava"):
		global.player_health -=10
	elif area.is_in_group("flame"):
		global.player_health -=5
	elif area.is_in_group("key"):
		global.player_inventory.append("key")
		print(global.player_inventory)
	elif area.is_in_group("coin"):
		global.player_inventory.append("coin")
		print(global.player_inventory)
	elif area.is_in_group("flamethrower"):
		global.player_health -=10
	elif area.is_in_group("BossProjectile"):
		global.player_health -= 20
		can_move = false
		await get_tree().create_timer(2).timeout
		can_move = true
	elif area.is_in_group("bossmelee"):
		global.player_health -= 25
	elif area.is_in_group("laser"):
		global.player_health -= 40
		

	
	healthbar.health = global.player_health
	print(global.player_health)
	regen_timer.start()
	




func _on_regen_timer_timeout():
	if global.player_health < global.player_max_health/3:
		global.player_health = min(global.player_health + (global.player_max_health / 3), global.player_max_health) 
		healthbar.health = global.player_health
		print("Player health after regen:", global.player_health)
		
func current_camera():
	if scene_manager2.current_scene == "world":
		$normal_zoom.enabled = true
		$zoom_in.enabled = false
	elif scene_manager2.current_scene == "maze":
		$normal_zoom.enabled = false
		$zoom_in.enabled = true
		
func get_item(itemData):
	$Bag.get


func player():
	pass
