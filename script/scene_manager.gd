class_name scene_manager extends Node


const world = preload("res://scenes/world.tscn")
const maze = preload("res://scenes/maze_room.tscn")

signal on_trigger_spawn_level



var scene_to_load

			
			
var spawn_door_tag

func go_to_scene(level_tag , destination_tag):
	
	match level_tag:
		"world":
			scene_to_load = world
		"maze_room":
			scene_to_load = maze
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)
		
func trigger_player_spawn(position:Vector2):
	on_trigger_spawn_level.emit(position)
			
