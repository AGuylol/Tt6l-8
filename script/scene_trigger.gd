extends Area2D
class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String


@onready var spawn =$spawn


func _on_body_entered(body):
	if body.is_in_group("player"):
		SceneManager.go_to_scene(destination_level_tag , destination_door_tag)
		

		
