extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D2.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scene()
	
	await $AudioStreamPlayer2D2.finished
	$AudioStreamPlayer2D2.play()


func _on_beach_transition_point_body_entered(body):
	if body.is_in_group("player"):
		global.transition_scene = true


func _on_beach_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene =false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "beach":
			get_tree().change_scene_to_file("res://scenes/malaccahub.tscn")

			global.finish_changescenes()
