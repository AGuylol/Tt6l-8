extends Node2D


var current_state: State
var previos_state: State

func _ready():
	current_state = get_child(0) as State
	previos_state = current_state
	current_state.enter()
	
func change_state(state):
	current_state = find_child(state) as State
	current_state.enter()
	
	previos_state.exit()
	previos_state = current_state
