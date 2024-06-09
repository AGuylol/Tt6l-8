extends Node2D


@onready var interaction_area :interaction_area = $Interaction_area

func _ready():
	$AnimatedSprite2D.play("default")
	interaction_area.interact = Callable (self, "_on_pickup")


func _on_pickup():
	global.player_inventory.append("silver_key")
	queue_free()
	print(global.player_inventory)
