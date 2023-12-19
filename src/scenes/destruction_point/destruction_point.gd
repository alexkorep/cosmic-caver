tool
extends Area2D


export (Array) var resources = [] setget set_resources
export (Array) var quantities = [] setget set_quantities


var Slot = load("res://scenes/destruction_point/dp_resource_slot.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	update_slots()

func set_resources(value):
	resources = value
	update_slots()

func set_quantities(value):
	quantities = value
	update_slots()

func update_slots():
	var VBoxContainer = $Components/VBoxContainer
	if not VBoxContainer:
		return
	for child in VBoxContainer.get_children():
		child.queue_free()

	for i in range(len(resources)):
		var resource = resources[i]
		var quantity = quantities[i]
		var slot = Slot.instance()
		slot.texture = resource.icon
		slot.quantity_required = quantity
		VBoxContainer.add_child(slot)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
