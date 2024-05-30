extends Node2D


@export var slime_scene = PackedScene
@export var door: NodePath
@export var enemy_scene: PackedScene
@export var spawn_points: Array[NodePath]
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



func _on_enemy_defeated():
	enemies.remove_at(2)
	print("enemy defeated")
	print(enemies)  
	if enemies.is_empty():
		print("room cleared")
		open_door()
	

	
func open_door():
	$door/AnimationPlayer.play("walldown")
	$door2/AnimationPlayer.play("walldown")
	

		

