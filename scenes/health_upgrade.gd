extends Sprite2D


@onready var interaction_area :interaction_area = $Interaction_area


func _ready():
	interaction_area.interact = Callable (self, "_on_pick_up")


func _on_pick_up():
	global.player_inventory.append("health_upgrade1")
	print(global.player_inventory)
	queue_free()
