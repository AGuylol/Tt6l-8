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
		
	elif distance >70 and distance < 80:
		get_parent().change_state("dash")
		
		
	elif distance > 110:
		var chance = randi() % 2
		match chance:
			0:
				get_parent().change_state("HomingMissle")
			1:
				get_parent().change_state("laser")
