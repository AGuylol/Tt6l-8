extends Node2D


func _ready():
	pass 


func _process(delta):
	change_scene()


func _on_mine_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene =true

func _on_mine_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene =false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.finish_changescenes()
	
