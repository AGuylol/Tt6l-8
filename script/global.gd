extends Node

var player_current_attack = false

var player_inventory =  []

var button_pressed = false

var player_health = 100.0
var player_max_health = 100.0
var player_sword_damage = 20
var player_gun_damage = 30


var current_scene = "world"
var transition_scene = false

var player_exit_cliffside_posx = 0
var player_exit_cliffside_posy = 0
var player_start_posx = 0
var player_start_posy = 0

func reset_stats():
	player_health = 100.0
	player_max_health = 100.0
	player_sword_damage = 20
	player_gun_damage = 30
	player_inventory = []
	
	
func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "forest"
		else:
			current_scene = "world"
			
func finish_changescenes_gold_mines():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "mine"  # Transition from world to mine
		elif current_scene == "mine":
			current_scene = "maze"  # Transition from mine to maze
		elif current_scene == "maze":
			current_scene = "world"  # Transition from maze back to world
			# You may also adjust player position here based on the exit of the maze
			# For example:
			# player_start_posx = new_x_position
			# player_start_posy = new_y_position
		elif current_scene == "boss_room":
			current_scene = "world"  # Transition from boss room back to world
			# Reset player position or any other relevant game state
		else:
			current_scene = "world"  # Default transition, should not happen unless you add more scenes


var spawn_states = {
	"spawn_area_1": false,
	"spawn_area_2": false,
	"spawn_area_3": false,
	"spawn_area_4": false,
	"spawn_area_5": false,
	"spawn_area_6": false,
	"spawn_area_7": false,
}

func set_spawn_state(area_name: String, state: bool):
	spawn_states[area_name] = state

func get_spawn_state(area_name: String) -> bool:
	return spawn_states.get(area_name, false)
