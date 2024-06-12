extends Node2D

@onready var interaction_area :interaction_area = $Interaction_area
@export var enemy_scene: PackedScene
@onready var chest_scene = preload("res://scenes/silver_chest.tscn")

var spawn_points: Array[NodePath]
var spawn_points_2: Array[NodePath]
var spawn_points_3: Array[NodePath]
var spawn_points_4: Array[NodePath]
var spawn_points_5: Array[NodePath]
var spawn_points_6: Array[NodePath]
var spawn_points_7: Array[NodePath]

var enemies = []
var doors_open = true
var current_rooms = 0


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
		$doors/door15/AnimationPlayer.play("wall_going_down")
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
		$doors/door15/AnimationPlayer.play("wall_going_up")
		doors_open = false
		
func _ready():
	interaction_area.interact = Callable (self, "_on_interact")
	
	
	if scene_manager2.transition_target == "world":
		$player.position.x = scene_manager2.exit_maze_posx
		$player.position.y = scene_manager2.exit_maze_posy
	
	elif scene_manager2.transition_target == "secret_room":
		$player.position.x = scene_manager2.exit_maze_to_room_posx
		$player.position.y = scene_manager2.exit_maze_to_room_posy
		
	elif scene_manager2.transition_target == "start_world":
		$player.position.x = scene_manager2.player_start_position_posx
		$player.position.y = scene_manager2.player_start_position_posy
	
	spawn_points = [
		$enemy_spawns/spawn_point.get_path(),
		$enemy_spawns/spawn_point2.get_path(),
	]
	spawn_points_2 = [
		$enemy_spawns/spawn_point3.get_path(),
		$enemy_spawns/spawn_point4.get_path(),
	]
	spawn_points_3 = [
		$enemy_spawns/spawn_point5.get_path(),
		$enemy_spawns/spawn_point6.get_path(),
		$enemy_spawns/spawn_point7.get_path()
	]
	spawn_points_4 = [
		$enemy_spawns/spawn_point8.get_path(),
		$enemy_spawns/spawn_point9.get_path(),
		$enemy_spawns/spawn_point10.get_path(),
		$enemy_spawns/spawn_point11.get_path()
	]
	spawn_points_5 = [
		
		$enemy_spawns/spawn_point12.get_path(),
		$enemy_spawns/spawn_point13.get_path(),
		$enemy_spawns/spawn_point14.get_path(),
		$enemy_spawns/spawn_point15.get_path()
		
	]
	spawn_points_6 = [
		$enemy_spawns/spawn_point16.get_path(),
		$enemy_spawns/spawn_point17.get_path(),
		$enemy_spawns/spawn_point18.get_path(),
		$enemy_spawns/spawn_point19.get_path(),
		$enemy_spawns/spawn_point20.get_path()
	]
	spawn_points_7 = [
		$enemy_spawns/spawn_point21.get_path(),
		$enemy_spawns/spawn_point22.get_path(),
		$enemy_spawns/spawn_point23.get_path(),
		$enemy_spawns/spawn_point24.get_path(),
		$enemy_spawns/spawn_point25.get_path()
		
	]

	$detectplayerarea/detectplayer.body_entered.connect(_on_detectplayer_body_entered)
	$detectplayerarea/detectplayer2.body_entered.connect(_on_detecplayer_2_ndroom_body_entered)
	$detectplayerarea/detectplayer3.body_entered.connect(_on_detectplayer_3_body_entered)
	$detectplayerarea/detectplayer4.body_entered.connect(_on_detectplayer_4_body_entered)
	$detectplayerarea/detectplayer5.body_entered.connect(_on_detectplayer_5_body_entered)
	$detectplayerarea/detectplayer6.body_entered.connect(_on_detectplayer_6_body_entered)
	$detectplayerarea/detectplayer7.body_entered.connect(_on_detectplayer_7_body_entered)



func _process(delta):
	change_scenes()
	

		
func spawn_enemies():
	spawn_from_points(spawn_points)
	current_rooms = 1
	
func spawn_enemies_2():
	spawn_from_points(spawn_points_2)
	current_rooms = 2
	
func spawn_enemies_3():
	spawn_from_points(spawn_points_3)
	current_rooms = 3
	
func spawn_enemies_4():
	spawn_from_points(spawn_points_4)
	current_rooms = 4
	
func spawn_enemies_5():
	spawn_from_points(spawn_points_5)
	current_rooms = 5
	
func spawn_enemies_6():
	spawn_from_points(spawn_points_6)
	current_rooms = 6
	
func spawn_enemies_7():
	spawn_from_points(spawn_points_7)
	current_rooms = 7


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
		if current_rooms == 7:
			spawn_chest()

func _on_detectplayer_body_entered(body):
	if body.is_in_group("player"):
		if global.get_spawn_state("spawn_area_1"):
			return
		global.set_spawn_state("spawn_area_1", true)
		$detectplayerarea/detectplayer.monitoring = false
		$detectplayerarea/detectplayer.body_entered.disconnect(_on_detectplayer_body_entered)
		spawn_enemies()
		close_all_doors()
		

func _on_detecplayer_2_ndroom_body_entered(body):
	if body.is_in_group("player"):
		if global.get_spawn_state("spawn_area_2"):
			return
		global.set_spawn_state("spawn_area_2", true)
		$detectplayerarea/detectplayer2.monitoring = false
		$detectplayerarea/detectplayer2.body_entered.disconnect(_on_detecplayer_2_ndroom_body_entered)
		spawn_enemies_2()
		close_all_doors()


func _on_detectplayer_3_body_entered(body):
	if body.is_in_group("player"):
		if global.get_spawn_state("spawn_area_3"):
			return
		global.set_spawn_state("spawn_area_3", true)
		$detectplayerarea/detectplayer3.monitoring = false
		$detectplayerarea/detectplayer3.body_entered.disconnect(_on_detectplayer_3_body_entered)
		spawn_enemies_3()
		close_all_doors()

func _on_detectplayer_4_body_entered(body):
	if body.is_in_group("player"):
		if global.get_spawn_state("spawn_area_4"):
			return
		global.set_spawn_state("spawn_area_4", true)
		$detectplayerarea/detectplayer4.monitoring = false
		$detectplayerarea/detectplayer4.body_entered.disconnect(_on_detectplayer_4_body_entered)
		spawn_enemies_4()
		close_all_doors()


func _on_detectplayer_5_body_entered(body):
	if body.is_in_group("player"):
		if global.get_spawn_state("spawn_area_5"):
			return
		global.set_spawn_state("spawn_area_5", true)
		$detectplayerarea/detectplayer5.monitoring = false
		$detectplayerarea/detectplayer5.body_entered.disconnect(_on_detectplayer_5_body_entered)
		spawn_enemies_5()
		close_all_doors()
		$doors/door16/AnimationPlayer.play("wall_going_up")
		if global.button_pressed:
			$doors/door16/AnimationPlayer.play("wall_going_down")
		
func _on_detectplayer_6_body_entered(body):
	if body.is_in_group("player"):
		if global.get_spawn_state("spawn_area_6"):
			return
		global.set_spawn_state("spawn_area_6", true)
		$detectplayerarea/detectplayer6.monitoring = false
		$detectplayerarea/detectplayer6.body_entered.disconnect(_on_detectplayer_6_body_entered)
		spawn_enemies_6()
		close_all_doors()

func _on_detectplayer_7_body_entered(body):
	if body.is_in_group("player"):
		if global.get_spawn_state("spawn_area_7"):
			return
		global.set_spawn_state("spawn_area_7", true)
		$detectplayerarea/detectplayer7.monitoring = false
		$detectplayerarea/detectplayer7.body_entered.disconnect(_on_detectplayer_7_body_entered)
		spawn_enemies_7()
		close_all_doors()
	
	
	
func _on_boss_room_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/boss_fight.tscn")


func spawn_chest():
	var chest = chest_scene.instantiate()
	if chest:
		add_child(chest)
		chest.position = Vector2(597, -1231)


func _on_maze_room_body_entered(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = true
		scene_manager2.transition_target = "maze"


func _on_maze_room_body_exited(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = false

func change_scenes():
	if scene_manager2.scene_transition:
		if scene_manager2.current_scene == "world" and scene_manager2.transition_target == "maze":
			scene_manager2.finish_scene_changes()
			get_tree().change_scene_to_file("res://scenes/maze_room.tscn")
		elif scene_manager2.current_scene == "secret_room" and scene_manager2.transition_target == "maze_exit":
			scene_manager2.finish_scene_changes()
			get_tree().change_scene_to_file("res://scenes/maze_room.tscn")
		elif scene_manager2.current_scene == "world" and scene_manager2.transition_target == "boss_room":
			scene_manager2.finish_scene_changes()
			get_tree().change_scene_to_file("res://scenes/boss_fight.tscn")
			


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		scene_manager2.scene_transition = true
		scene_manager2.transition_target = "maze_exit"


func _on_interact():
	scene_manager2.scene_transition = true
	scene_manager2.transition_target = "boss_room"
