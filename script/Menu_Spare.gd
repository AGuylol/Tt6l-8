extends Control

var menu
var option
var video
var audio
var instruction

func _ready():
	menu = $Menu
	option = $Option
	video = $Video
	audio = $Audio
	instruction = $Instruction

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle() 

func toggle():
	visible = !visible
	get_tree().paused = visible

func _on_start_pressed():
	toggle()
	get_tree().change_scene_to_file("res://tutorial.tscn")

func _on_option_pressed():
	show_and_hide(option,menu)

func show_and_hide(first,second):
	first.show()
	second.hide()

func _on_quit_pressed():
	get_tree().quit()


func _on_video_pressed():
	show_and_hide(video, option)

func _on_audio_pressed():
	show_and_hide(audio, option)

func _on_back_from_option_pressed():
	show_and_hide(menu, option)


func _on_full_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_v_sync_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)



func _on_back_from_video_pressed():
	show_and_hide(option, video)


func _on_master_value_changed(value):
	volume(0,value)
	
func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)
	


func _on_music_value_changed(value):
	volume(1,value)
	


func _on_sound_fx_value_changed(value):
	volume(2,value)


func _on_back_from_audio_pressed():
	show_and_hide(option, audio)


func _on_instruction_pressed():
	show_and_hide(instruction, menu)

func _on_back_from_instruction_pressed():
	show_and_hide(menu, instruction)
