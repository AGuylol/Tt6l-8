extends Node2D


@export var enemy_scene: PackedScene
@export var spawn_points: Array[NodePath]
@export var spawn_points_2: Array[NodePath]
@export var spawn_points_3: Array[NodePath]
@export var spawn_points_4: Array[NodePath]
@export var spawn_points_5: Array[NodePath]
@export var spawn_points_6: Array[NodePath]

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
		$doors/door8/AnimationPlayer.play("wall_going_down")
		$doors/door9/AnimationPlayer.play("wall_going_down")
		$doors/door10/AnimationPlayer.play("wall_going_down")
		$doors/door11/AnimationPlayer.play("wall_going_down")
		$doors/door12/AnimationPlayer.play("wall_going_down")
		$doors/door13/AnimationPlayer.play("wall_going_down")
		$doors/door14/AnimationPlayer.play("wall_going_down")

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
		$doors/door8/AnimationPlayer.play("wall_going_up")
		$doors/door9/AnimationPlayer.play("wall_going_up")
		$doors/door10/AnimationPlayer.play("wall_going_up")
		$doors/door11/AnimationPlayer.play("wall_going_up")
		$doors/door12/AnimationPlayer.play("wall_going_up")
		$doors/door13/AnimationPlayer.play("wall_going_up")
		$doors/door14/AnimationPlayer.play("wall_going_up")

		doors_open = false
		
func _ready():
	$detectplayerarea/detectplayer.body_entered.connect(_on_detectplayer_body_entered)
	$detectplayerarea/detectplayer2.body_entered.connect(_on_detecplayer_2_ndroom_body_entered)
	$detectplayerarea/detectplayer3.body_entered.connect(_on_detectplayer_3_body_entered)
	$detectplayerarea/detectplayer4.body_entered.connect(_on_detectplayer_4_body_entered)
	$detectplayerarea/detectplayer5.body_entered.connect(_on_detectplayer_5_body_entered)
	$detectplayerarea/detectplayer6.body_entered.connect(_on_detectplayer_6_body_entered)
	
	
func _process(delta):
	pass
	

		
func spawn_enemies():
	spawn_from_points(spawn_points)
	
func spawn_enemies_2():
	spawn_from_points(spawn_points_2)
	
func spawn_enemies_3():
	spawn_from_points(spawn_points_3)
	
func spawn_enemies_4():
	spawn_from_points(spawn_points_4)
	
func spawn_enemies_5():
	spawn_from_points(spawn_points_5)
	
func spawn_enemies_6():
	spawn_from_points(spawn_points_6)
	



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

func _on_detectplayer_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer.monitoring = false
		$detectplayerarea/detectplayer.body_entered.disconnect(_on_detectplayer_body_entered)
		spawn_enemies()
		close_all_doors()
		

func _on_detecplayer_2_ndroom_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer2.monitoring = false
		$detectplayerarea/detectplayer2.body_entered.disconnect(_on_detecplayer_2_ndroom_body_entered)
		spawn_enemies_2()
		close_all_doors()


func _on_detectplayer_3_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer3.monitoring = false
		$detectplayerarea/detectplayer3.body_entered.disconnect(_on_detectplayer_3_body_entered)
		spawn_enemies_3()
		close_all_doors()

func _on_detectplayer_4_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer4.monitoring = false
		$detectplayerarea/detectplayer4.body_entered.disconnect(_on_detectplayer_4_body_entered)
		spawn_enemies_4()
		close_all_doors()



func _on_detectplayer_5_body_entered(body):
	if body.is_in_group("player"):
		$detectplayerarea/detectplayer5.monitoring = false
		$detectplayerarea/detectplayer5.body_entered.disconnect(_on_detectplayer_5_body_entered)
		spawn_enemies_5()
		close_all_doors()
		
func _on_detectplayer_6_body_entered(body):
	if body.is_in_group("player"):
		print("Spawning enemies for Room 6")
		print("Spawn Points:", spawn_points_6)
		spawn_from_points(spawn_points_6)
		$detectplayerarea/detectplayer6.monitoring = false
		$detectplayerarea/detectplayer6.body_entered.disconnect(_on_detectplayer_6_body_entered)
		spawn_enemies_6()
		close_all_doors()



func _on_area_2d_body_entered(body):
	pass # Replace with function body.
