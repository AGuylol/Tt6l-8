extends Area2D

@export var itemName: String
@export var itemIcon: Texture

var itemData: Dictionary

func _ready():
	$Sprite2D.texture = itemIcon
	
	itemData = {
		"name": itemName,
		"icon": itemIcon
	}

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.get_item(itemData)
		queue_free()
		

