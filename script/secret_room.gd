extends Node2D


var specific_spawn_position: Vector2 = Vector2(-1, -24)

func _ready():
	if SceneManager.spawn_door_tag != null:
		_on_level_spawn(SceneManager.spawn_door_tag)
		
func _on_level_spawn(destination_tag : String):
	var door = get_node("doorS") as Door
	if door != null:
		SceneManager.trigger_player_spawn(door.spawn.global_position)
	else:
		print("Error: Door not found at path: " + door)


