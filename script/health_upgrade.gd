extends Sprite2D


@onready var interaction_area :interaction_area = $Interaction_area
func _ready():
	interaction_area.interact = Callable (self, "_on_pickup")


func _on_pickup():
	global.player_inventory.append("health_upgrade2")
	global.player_max_health += 10
	queue_free()
