extends Node2D


func _ready():
	if scene_manager2.transition_target == "maze_exit":
		$player.position.x = scene_manager2.end_of_maze_posx
		$player.position.y = scene_manager2.end_of_maze_posy
	if scene_manager2.transition_target == "maze":
		$player.position.x = scene_manager2.enter_maze_posx
		$player.position.y = scene_manager2.enter_maze_posy
		
func _physics_process(delta):
	change_scenes()



func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = true
		scene_manager2.transition_target = "world"
	


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = false


func change_scenes():
	if scene_manager2.scene_transition:
		if scene_manager2.current_scene == "maze":
			if scene_manager2.transition_target == "world":
				scene_manager2.finish_scene_changes()
				get_tree().change_scene_to_file("res://scenes/world.tscn")
				
			elif scene_manager2.transition_target == "maze_exit":
				scene_manager2.finish_scene_changes()
				get_tree().change_scene_to_file("res://scenes/world.tscn")
				
			elif scene_manager2.transition_target == "secret_room":
				scene_manager2.finish_scene_changes()
				get_tree().change_scene_to_file("res://scenes/world.tscn")
				
		elif scene_manager2.current_scene == "world":
			scene_manager2.finish_scene_changes()
			get_tree().change_scene_to_file("res://scenes/maze.tscn")
			
		elif scene_manager2.current_scene == "secret_room" and scene_manager2.transition_target == "maze_exit":
			scene_manager2.finish_scene_changes()
			get_tree().change_scene_to_file("res://scenes/maze.tscn")
			



func _on_secret_room_body_entered(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = true
		scene_manager2.transition_target = "secret_room"



func _on_secret_room_body_exited(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = false
		
