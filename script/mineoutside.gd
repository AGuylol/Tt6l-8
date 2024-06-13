extends Node2D


func _ready():
	pass



func _process(delta):
	change_scenes()


func _on_mine_body_entered(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = true
		scene_manager2.transition_target = "start_world"

func change_scenes():
	if scene_manager2.scene_transition:
		scene_manager2.finish_scene_changes()
		get_tree().change_scene_to_file("res://scenes/world.tscn")
		
		
