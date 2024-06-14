extends Node

var current_scene = "beach"
var scene_transition = false
var transition_target = ""


var player_start_position_posx = 9
var player_start_position_posy = 138
var exit_maze_posx = 591
var exit_maze_posy = -1001
var exit_maze_to_room_posx =  592
var exit_maze_to_room_posy =  -1348
var enter_maze_posx = 1
var enter_maze_posy = -26
var end_of_maze_posx = -64
var end_of_maze_posy = -460

var game_first_load = true


func finish_scene_changes():
	if scene_transition:
		print("scene trans is true")
		scene_transition = false
		if current_scene == "world" and transition_target == "maze":
			current_scene = "maze"
			print("Changed scene to maze.")
		elif current_scene == "maze" and transition_target == "world":
			current_scene = "world"
			print("Changed scene to world.")
		elif current_scene == "maze" and transition_target == "secret_room":
			current_scene = "secret_room" 
			print("Changed scene to secret room from maze.") 
		elif current_scene == "secret_room" and transition_target == "world":
			current_scene = "world"
			print("Changed scene to world from secret room.")
		elif current_scene == "secret_room" and transition_target == "maze":
			current_scene = "maze"
		elif current_scene == "maze" and transition_target =="maze_exit":
			current_scene = "secret_room"
		elif current_scene == "secret_room" and transition_target == "maze_exit":
			current_scene = "maze"
		elif current_scene == "world" and transition_target == "boss_room":
			current_scene = "boss_room"
		elif current_scene == "outsidemine" and transition_target == "start_world":
			current_scene = "world"
		
