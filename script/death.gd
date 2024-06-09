extends State


@onready var can_transition : bool = false


func enter():
	super.enter()
	animation_player.play("death")
	await animation_player.animation_finished
	queue_free()
