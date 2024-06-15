extends Node2D

var player_in_area = false
var chatting = false

func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("interaction"):
			if chatting:
				pass
			else:
				run_dialogue("tutorial but no")
			
func run_dialogue(dialogue_string):
	Dialogic.start(dialogue_string)
	chatting = true
	

func _on_chat_detection_body_entered(body):
	if body.has_method("player"):
		player_in_area = true

func _on_chat_detection_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
