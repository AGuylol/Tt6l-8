@tool
extends Control

@export var world_index: int = 1

func _ready():
	$Label.text = "World" + str(world_index)
	
func _process(delta):
	if Engine.is_editor_hint():
		$Label.text = "World" + str(world_index)
