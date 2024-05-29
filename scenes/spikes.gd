extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_detectplayer_body_entered(body):
	if body.is_in_group("player"):
		$AnimatedSprite2D.play("spike_going_up")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.play("spike_up")
		await get_tree().create_timer(5).timeout
		$AnimatedSprite2D.play("spike_going_down")
		await get_tree().create_timer(1).timeout
		$AnimatedSprite2D.play("spike_down")
		
