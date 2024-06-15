extends Node2D


@onready var interaction_area: InteractionArea = $Flag1/InteractionArea
@onready var sprite = $Flag1

func _ready():
	interaction_area.interact = Callable(self, "_open_map")
	
func _open_map():
	get_tree().change_scene_to_file("res://level_select.tscn")
