extends Area2D

@export var door: NodePath
@export var enemy_scene: PackedScene
@export var spawn_points: Array[NodePath]

var enemies = []

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		close_door()
		spawn_enemies()

func close_door():
	var door_node = get_node(door)
	if door_node.has_method("play"):
		door_node.play("close")  # Assuming "close" is the animation name for closing the door

func spawn_enemies():
	for spawn_point_path in spawn_points:
		var spawn_point = get_node(spawn_point_path)
		var enemy = enemy_scene.instantiate()
		spawn_point.add_child(enemy)
		enemies.append(enemy)
		enemy.tree_exited.connect(_on_enemy_defeated)

func _on_enemy_defeated():
	enemies.erase(get_tree().current_scene)  # Remove the enemy from the list when it is defeated
	if enemies.size() == 0:
		open_door()

func open_door():
	var door_node = get_node(door)
	if door_node.has_method("play"):
		door_node.play("open")  # Assuming "open" is the animation name for opening the door
