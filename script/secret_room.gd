extends Node2D


func _ready():
	pass

func _physics_process(delta):
	change_scenes()



func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = true
		
	


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = false


func change_scenes():
	if scene_manager2.scene_transition:
		if scene_manager2.current_scene == "maze":
			scene_manager2.finish_scene_changes()
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			


