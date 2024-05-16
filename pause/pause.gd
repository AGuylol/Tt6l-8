extends Control

var pause
var option
var video
var audio


func _ready():
	pause = $Pause
	option = $Option
	video = $Video
	audio = $Audio

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle() 


func toggle():
	visible = !visible
	get_tree().paused = visible

func show_and_hide(first,second):
	first.show()
	second.hide()


func _on_continue_pressed():
	pass # Replace with function body.


func _on_option_pressed():
	show_and_hide(option,pause)


func _on_mainmenu_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu_Spare.tscn")


func _on_video_pressed():
	show_and_hide(video, option)


func _on_audio_pressed():
	show_and_hide(audio, option)


func _on_back_from_option_pressed():
	show_and_hide(pause, option)


func _on_fullscreen_toggled(button_pressed):
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
