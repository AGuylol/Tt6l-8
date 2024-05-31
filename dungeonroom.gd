extends Node2D


@export var slime_scene = PackedScene
@export var door: NodePath
@export var enemy_scene: PackedScene
@export var spawn_points: Array[NodePath]
@export var spawn_points_2: Array[NodePath]
@export var spawn_points_3: Array[NodePath]
var enemies = []


func _ready():
	print(enemies)
	
func _process(delta):
	pass
	
func _on_detectplayer_body_entered(body):
	$detectplayer.monitoring = false
	if body.is_in_group("player"):
		close_door()
		spawn_enemies()


func close_door():
	$door3/AnimationPlayer.play("wallup") 
	$door4/AnimationPlayer.play("wallup")
	$door/AnimationPlayer.play("wallup")
	$door2/AnimationPlayer.play("wallup")

func spawn_enemies():
	for spawn_point_path in spawn_points:
		var spawn_point = get_node(spawn_point_path)
		if spawn_point == null:
			continue
		var enemy = enemy_scene.instantiate()
		if enemy == null:
			continue
		add_child(enemy)
		enemy.position = spawn_point.position
		enemies.append(enemy)
		enemy.tree_exited.connect(_on_enemy_defeated)


func spawn_enemies_2():
	for spawn_point_path in spawn_points_2:
		var spawn_point = get_node(spawn_point_path)
		if spawn_point == null:
			continue
		var enemy = enemy_scene.instantiate()
		if enemy == null:
			continue
		add_child(enemy)
		enemy.position = spawn_point.position
		enemies.append(enemy)
		enemy.tree_exited.connect(_on_enemy_defeated)
	
		
func spawn_enemies_3():
	for spawn_point_path in spawn_points_3:
		var spawn_point = get_node(spawn_point_path)
		if spawn_point == null:
			continue
		var enemy = enemy_scene.instantiate()
		if enemy == null:
			continue
		add_child(enemy)
		enemy.position = spawn_point.position
		enemies.append(enemy)
		enemy.tree_exited.connect(_on_enemy_defeated)
		
		
		
		
func _on_enemy_defeated():
	$detectplayer.monitoring = false
	print("enemy defeated")
	print(enemies)  
	if enemies.size() == 2:
		print("room cleared")
		open_door()
	

	
func open_door():
	$door/AnimationPlayer.play("walldown")
	$door2/AnimationPlayer.play("walldown")
	$door3/AnimationPlayer.play("walldown")
	$door4/AnimationPlayer.play("walldown")
	
	

func _on_detecplayer_2_ndroom_body_entered(body):
	if body.is_in_group("player"):
		spawn_enemies_2()
		close_door()


func _on_detectplayer_3_body_entered(body):
	if body.is_in_group("player"):
		spawn_enemies_3()
		close_door()
