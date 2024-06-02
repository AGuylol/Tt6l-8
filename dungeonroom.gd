extends Node2D


@export var enemy_scene: PackedScene
@export var spawn_points: Array[NodePath]
@export var spawn_points_2: Array[NodePath]
@export var spawn_points_3: Array[NodePath]
@export var spawn_points_4: Array[NodePath]
var enemies = []
var doors_open = true



func open_all_doors():
	if not doors_open:
		$doors/door/AnimationPlayer.play("wall_going_down")
		$doors/door2/AnimationPlayer.play("wall_going_down")
		$doors/door3/AnimationPlayer.play("wall_going_down")
		$doors/door4/AnimationPlayer.play("wall_going_down")
		$doors/door5/AnimationPlayer.play("wall_going_down")
		$doors/door6/AnimationPlayer.play("wall_going_down")
		$doors/door7/AnimationPlayer.play("wall_going_down")

		doors_open = true
		
func close_all_doors():
	if doors_open:
		$doors/door/AnimationPlayer.play("wall_going_up")
		$doors/door2/AnimationPlayer.play("wall_going_up")
		$doors/door3/AnimationPlayer.play("wall_going_up")
		$doors/door4/AnimationPlayer.play("wall_going_up")
		$doors/door5/AnimationPlayer.play("wall_going_up")
		$doors/door6/AnimationPlayer.play("wall_going_up")
		$doors/door7/AnimationPlayer.play("wall_going_up")
		doors_open = false
		
func _ready():
	pass
	
func _process(delta):
	pass
	
func _on_detectplayer_body_entered(body):
	$detectplayerarea/detectplayer.monitoring = false
	if body.is_in_group("player"):
		
		close_all_doors()
		spawn_enemies()
		
func spawn_enemies():
	spawn_from_points(spawn_points)
	
func spawn_enemies_2():
	spawn_from_points(spawn_points_2)
	
func spawn_enemies_3():
	spawn_from_points(spawn_points_3)
	
func spawn_enemies_4():
	spawn_from_points(spawn_points_4)


func spawn_from_points(points):
	for spawn_point_path in points:
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
	print("enemy")
	enemies.erase(enemies[-1])  
	print(enemies)
	if enemies.size() == 0:
		print("room cleared")
		open_all_doors()
	

func _on_detecplayer_2_ndroom_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer2.monitoring = false
		spawn_enemies_2()
		close_all_doors()


func _on_detectplayer_3_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer3.monitoring = false
		spawn_enemies_3()
		close_all_doors()

func _on_detectplayer_4_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer4.monitoring = false
		spawn_enemies_4()
		close_all_doors()

