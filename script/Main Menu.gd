extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_instruction_pressed():
	get_tree().change_scene_to_file("res://icon.svg")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Options_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
