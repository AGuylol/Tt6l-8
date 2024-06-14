extends Node2D

@export var flying_fish :PackedScene
@export var toyol :PackedScene
var spawn_points: Array[NodePath]
var spawn_points2: Array[NodePath]

var enemies = []

func _ready():
	spawn_points = [
		$Node2D/Marker2D.get_path(),
		$Node2D/Marker2D2.get_path()
	]
	$Area2D.body_entered.connect(_on_area_2d_body_entered)
	
	spawn_points2 = [
		$Node2D/Marker2D3.get_path(),
		$Node2D/Marker2D4.get_path()
	]
	$spawn.body_entered.connect(_on_spawn_body_entered)
	
func spawn_enemies():
	spawn_from_points(spawn_points)
	
func spawn_enemies2():
	spawn_from_points(spawn_points2)

func enable_wall():
	$wall/wall/CollisionShape2D.disabled = false
	$wall/wall2/CollisionShape2D.disabled = false

func disable_wall():
	$wall/wall/CollisionShape2D.disabled = true
	$wall/wall2/CollisionShape2D.disabled = true

func spawn_from_points(points):
	for spawn_point_path in points:
		var spawn_point = get_node(spawn_point_path)
		if spawn_point == null:
			continue
		var enemy = flying_fish.instantiate()
		if enemy == null:
			continue
		add_child(enemy)
		enemy.position = spawn_point.position
		enemies.append(enemy)
		enemy.tree_exited.connect(_on_enemy_defeated)
	
func _on_enemy_defeated():
	print("enemy")
	enemies.erase(enemies[-1])  
	print(enemies)
	if enemies.size() == 0:
		print("room cleared")
		disable_wall()
	
func _process(delta):
	change_scene()

func _on_forest_transition_point_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true

func _on_forest_transition_point_body_exited(body):
	if body.has_method("player"):
		global.transition_scene =false

func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "beach":
			get_tree().change_scene_to_file("res://scenes/forest.tscn")
			global.finish_changescenes()
	
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		$Area2D.monitoring = false
		$Area2D.body_entered.disconnect(_on_area_2d_body_entered)
		spawn_enemies()
		enable_wall()

func _on_spawn_body_entered(body):
	if body.is_in_group("player"):
		$spawn.monitoring = false
		$spawn.body_entered.disconnect(_on_spawn_body_entered)
		spawn_enemies2()
		enable_wall()
