extends Node2D


@onready var interaction_area :interaction_area = $Interaction_area

func _ready():
	interaction_area.interact = Callable (self, "_on_pickup")


func _on_pickup():
	global.gun_cooldown -= 3
	queue_free()

