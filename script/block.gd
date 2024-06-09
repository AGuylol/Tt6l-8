extends State

var can_transition: bool = false

func enter():
	super.enter()
	if !global.boss_can_take_damage:
		animation_player.play("block")
		await animation_player.animation_finished
		global.boss_can_take_damage = false
		can_transition = true
		
func exit():
	super.exit()
	
	
		
func transition():
	if can_transition:
		get_parent().change_state("follow")
		
