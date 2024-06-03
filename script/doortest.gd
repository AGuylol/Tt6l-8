extends StaticBody2D

@onready var anim_sprite = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D

# Method to open the door
func open_door():
	anim_sprite.play("open")
	collision_shape.disabled = true  # Disable collision when door is open

# Method to close the door
func close_door():
	anim_sprite.play("close")
	collision_shape.disabled = false  # Enable collision when door is closed

# Method to toggle door state
func toggle_door():
	if anim_sprite.animation == "open":
		close_door()
	else:
		open_door()
