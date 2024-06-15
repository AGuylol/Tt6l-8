extends Node2D



func _ready():
	$AudioStreamPlayer.play()
	global.player_health = global.player_max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	await $AudioStreamPlayer.finished
	$AudioStreamPlayer.play()


func _on_dertect_player_body_entered(body):
	$boss/player_detection.monitoring = true
