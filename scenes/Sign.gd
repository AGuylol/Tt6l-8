extends Node2D

@onready var interaction_area = $Interaction_area
@onready var sprite = $"cool sign sprite"

func _ready():
	interaction_area.interact = Callable(self, "_open_map")
	
func _open_map():
		get_tree().change_scene_to_file("res://level_select.tscn")
