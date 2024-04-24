extends CharacterBody2D


const speed = 100.0
var current_dir = "none"
var player_health = 100.0
var player_alive = false

func _physics_process(delta):
	player_movement(delta)
	player_attack(delta)

func player_movement(delta):
	
	if Input.is_action_pressed("ui_right"):
		current_dir= "right"
		player_animation(1)
		velocity.x= speed
		velocity.y=0
	elif Input.is_action_pressed("ui_left"):
		current_dir= "left"
		player_animation(1)
		velocity.x =-speed
		velocity.y =0
	elif Input.is_action_pressed("ui_down"):
		current_dir= "down"
		player_animation(1)
		velocity.x =0
		velocity.y =speed
	elif Input.is_action_pressed("ui_up"):
		current_dir= "up"
		player_animation(1)
		velocity.x =0
		velocity.y =-speed
		
	else:
		player_animation(0)
		velocity.x =0
		velocity.y =0
	
	move_and_slide()
	
func player_animation(movement):
	var anim= $player_animation
	var dir=current_dir
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement ==0:
			anim.play("side_idle")
			
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement ==0:
			anim.play("side_idle")
			
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement ==0:
			anim.play("back_idle")
			
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement ==0:
			anim.play("front_idle")

func player_attack(delta):
	if Input.is_mouse_button_pressed(1): 
		var dir = current_dir
		
		var anim = $player_animation
		
		if dir == "right":
			anim.play("side_attack")
			
		if dir == "left":
			anim.play("side_attack")
			
		if dir == "up":
			anim.play("back_attack")
		
		if dir == "down":
			anim.play("front_attack")

	
