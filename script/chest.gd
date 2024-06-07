extends StaticBody2D


@onready var interaction_area :interaction_area = $Interaction_area
@onready var anim_chest = $AnimationPlayer
@onready var weapon = preload("res://scenes/arquebus.tscn")


func _ready():
	$AnimatedSprite2D.play("idle")
	interaction_area.interact = Callable (self, "_on_open_chest")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_open_chest():
	if "key" in global.player_inventory:
		anim_chest.play("open")
		await anim_chest.animation_finished
		spawn_weapon()
		queue_free()
	
func spawn_weapon():
	if weapon:
		var weapon_instance = weapon.instantiate()
		weapon_instance.position = global_position    
		get_tree().current_scene.add_child(weapon_instance)
