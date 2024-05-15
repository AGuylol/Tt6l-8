extends ProgressBar

@onready var timer = $Timer
@onready var consume_bar = $Consumebar


var stamina = 0 : set = _set_stamina

func _set_stamina(new_stamina):
	var prev_stamina = stamina
	stamina = min(max_value, new_stamina)
	value = stamina
	
	if stamina <=0:
		queue_free()
	
	if new_stamina < prev_stamina:
		timer.start()
	
	else:
		consume_bar.value = stamina


func init_stamina(_stamina):
	stamina = _stamina
	max_value = stamina
	value = stamina
	consume_bar.max_value = stamina
	consume_bar.value = stamina 


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func _on_timer_timeout():
	consume_bar.value = stamina
	
