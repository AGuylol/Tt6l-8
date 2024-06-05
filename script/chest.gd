extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("idle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("player") and "key" in global.player_inventory:
		$AnimationPlayer.play("open")
		global.player_inventory.erase("key")
		print(global.player_inventory)
		await get_tree().create_timer(1).timeout
		queue_free()
