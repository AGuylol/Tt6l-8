extends Node2D


@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label

const base_text = '[e] to interact'

var active_area = []
var can_interact : bool = true

func register_area(area : interaction_area):
	active_area.push_back(area)
	
func unregistered_area(area : interaction_area):
	var index = active_area.find(area)
	if index != -1:
		active_area.remove_at(index)
		
		
func _process(delta):
	if active_area.size() > 0 and can_interact:
		active_area.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + active_area[0].action_name
		label.global_position = active_area[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()

func _sort_by_distance_to_player(area1 , area2):
	if player == null or area1 == null or area2 == null:
		print("One of the instances is null:", area1, area2, player)
		return 0  
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player
	
	
func _input(event):
	if event.is_action_pressed("interaction") and can_interact:
		if active_area.size() > 0:
			can_interact = false
			label.hide()
			
			await active_area[0].interact.call()
			can_interact = true
