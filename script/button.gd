extends Node2D


@onready var interaction_area :interaction_area = $Interaction_area
@onready var button_anim = $AnimationPlayer


func _ready():
	interaction_area.interact = Callable (self, "_on_button_pressed")


func _on_button_pressed():
	button_anim.play("pressed")
	global.button_pressed = true
	print("button_pressed")
	
