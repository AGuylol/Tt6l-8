extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
