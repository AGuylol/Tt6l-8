extends Node

var current_scene = "world"
var scene_transition = false

var player_start_position_posx = 9
var player_start_position_posy = 138
var exit_maze_posx = 591
var exit_maze_posy = -1001


var game_first_load = true


func finish_scene_changes():
	if scene_transition:
		print("scene ttrans is true")
		scene_transition = false
		if current_scene == "world":
			current_scene = "maze"
			print("Changed scene to maze.")
		elif current_scene == "maze":
			current_scene = "world"
			print("Changed scene to world.")
