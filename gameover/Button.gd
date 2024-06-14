extends Button

func _ready():
	var stylebox = StyleBoxFlat.new()
	stylebox.bg_color = Color(0,100,0)  
	add_theme_stylebox_override("normal", stylebox)

	var hover_stylebox = StyleBoxFlat.new()
	hover_stylebox.bg_color = Color(10,128,0)  
	add_theme_stylebox_override("hover", hover_stylebox)

	var pressed_stylebox = StyleBoxFlat.new()
	pressed_stylebox.bg_color = Color(0,159,107) 
	add_theme_stylebox_override("pressed", pressed_stylebox)


func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu_Spare.tscn")
