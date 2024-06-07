extends State


func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("idle")
	
func exit():
	super.exit()
	owner.set_physics_process(false)
	
func transition():
	var distance = owner.direction.length()
	
	if distance < 40:
		get_parent().change_state("MeleeAttack")
		
	elif distance >1000 and distance < 100000:
		var chance = randi() % 4
		match chance:
			0: 
				get_parent().change_state("dash")
		
		
	elif distance > 100:
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("HomingMissle")
			1:
				get_parent().change_state("laser")
