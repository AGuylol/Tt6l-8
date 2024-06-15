extends Node

var player_current_attack = false

var player_inventory =  []

var button_pressed = false

var player_health = 100.0
var player_max_health = 100.0
var player_sword_damage = 20
var player_gun_damage = 30
var gun_cooldown = 10
var player_defence = 0

var current_scene = "beach"
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
	gun_cooldown = 10
	player_inventory = []
	reset_spawn_states()
	
func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "beach":
			current_scene = "forest"
		else:
			current_scene = "beach"
			



var spawn_states = {
	"spawn_area_1": false,
	"spawn_area_2": false,
	"spawn_area_3": false,
	"spawn_area_4": false,
	"spawn_area_5": false,
	"spawn_area_6": false,
	"spawn_area_7": false,
}

func reset_spawn_states():
	for key in spawn_states.keys():
		spawn_states[key] = false
		
		
func set_spawn_state(area_name: String, state: bool):
	spawn_states[area_name] = state

func get_spawn_state(area_name: String) -> bool:
	return spawn_states.get(area_name, false)
