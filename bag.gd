extends CanvasLayer

@onready var bagContainer = $NinePatchRect
@onready var itemSlotContainer = $NinePatchRect/MarginContainer/SlotItems

var items = []

func get_item(itemData):
	items.append(itemData)
	_refresh_ui()
	
func _refresh_ui():
	var allItemSlots = itemSlotContainer.get_children()
	
	for i in len(items):
		var itemData =  items[i]
		allItemSlots[i].texture = itemData["icon"]


func _on_texture_button_pressed():
	bagContainer.visible = !bagContainer.visible
