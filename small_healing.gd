extends Sprite2D


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		global.player_health = min(global.player_health + 20, global.player_max_health)
		queue_free()
		
