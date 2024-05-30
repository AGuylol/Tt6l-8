extends Area2D

@export var spike_up_time: float = 5.0
@export var spike_transition_time: float = 1.0
@export var spike_down_time: float = 3.0
func _ready():
	start_spike_loop()

func start_spike_loop() -> void:
	async_loop_spikes()

func async_loop_spikes() -> void:
	while true:
		$AnimatedSprite2D.play("spike_going_up")
		await get_tree().create_timer(spike_transition_time).timeout
		$AnimatedSprite2D.play("spike_up")
		await get_tree().create_timer(spike_up_time).timeout
		$AnimatedSprite2D.play("spike_going_down")
		await get_tree().create_timer(spike_transition_time).timeout
		$AnimatedSprite2D.play("spike_down")
		await get_tree().create_timer(3).timeout
		
		
