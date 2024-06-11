extends StaticBody2D


@onready var interaction_area :interaction_area = $Interaction_area
@onready var anim_chest = $AnimationPlayer
@onready var item = preload("res://scenes/arquebus.tscn")


func _ready():
	$AnimatedSprite2D.play("idle")
	interaction_area.interact = Callable (self, "_on_open_chest")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_open_chest():
	if "silver_key" in global.player_inventory:
		anim_chest.play("open")
		await anim_chest.animation_finished
		spawn_item()
		global.player_inventory.erase("silver_key")
		queue_free()
		
	
func spawn_item():
	if item:
		var item_instance = item.instantiate()
		item_instance.position = global_position    
		get_tree().current_scene.add_child(item_instance)
