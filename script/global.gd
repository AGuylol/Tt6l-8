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


func finish_changescenes():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "forest"
		else:
			current_scene = "world"

