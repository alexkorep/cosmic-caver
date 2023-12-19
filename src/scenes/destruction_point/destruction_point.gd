tool
extends Area2D

signal destructed(dp_object)

export (Array) var resources = [] setget set_resources
export (Array) var quantities = [] setget set_quantities
var fulfilled_quantities = []

var Slot = load("res://scenes/destruction_point/dp_resource_slot.tscn")
var nearby_body = null

onready var CPUParticles2D = $CPUParticles2D
onready var ResourceExtractionTimer = $ResourceExtractionTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	update_slots()

func set_resources(value):
	resources = value
	update_slots()

func set_quantities(value):
	quantities = value
	# Create an array of the same size as quantities, filled with 0s
	fulfilled_quantities.clear()
	for i in range(len(quantities)):
		fulfilled_quantities.append(0)
	update_slots()

func update_slots():
	var VBoxContainer = $Components/VBoxContainer
	if not VBoxContainer:
		return
	for child in VBoxContainer.get_children():
		child.queue_free()

	for i in range(len(resources)):
		var resource = resources[i]
		var quantity = quantities[i] if len(quantities) > i else 0
		var fulfilled = fulfilled_quantities[i] if len(fulfilled_quantities) > i else 0
		var slot = Slot.instance()
		slot.texture = resource.icon
		slot.quantity_required = quantity
		slot.quantity = fulfilled
		VBoxContainer.add_child(slot)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nearby_body:
		CPUParticles2D.position =  nearby_body.global_position - global_position
		CPUParticles2D.direction = (global_position - nearby_body.global_position).normalized()

func on_body_entered(body):
	print(body)
	# Start emitting CPUParticles2D when the player enters the area, towards the player
	if body is Spaceship:
		nearby_body = body
		ResourceExtractionTimer.start()
		update_particle_animation()

func on_body_exited(body):
	CPUParticles2D.emitting = false
	nearby_body = null
	ResourceExtractionTimer.stop()

func update_particle_animation():
	if ship_has_enough_resources():
		CPUParticles2D.emitting = true

func ship_has_enough_resources() -> bool:
	for i in range(len(resources)):
		var resource = resources[i]
		var quantity = quantities[i] if len(quantities) > i else 0
		var fulfilled_quantity = fulfilled_quantities[i]
		if fulfilled_quantity >= quantity:
			# This slot has been already fullfilled, no need
			# to check if the ship has enough.
			continue
		var existing_qty = PlayerInventory.get_item_quantity(resource)
		if existing_qty > 0:
			# Inventory has some resources
			return true
	return false

func extract_resources_step():
	for i in range(len(resources)):
		var resource = resources[i]
		var quantity = quantities[i] if len(quantities) > i else 0
		var fulfilled_quantity = fulfilled_quantities[i]
		if fulfilled_quantity >= quantity:
			# This slot has been already fullfilled, no need
			# extract
			continue
		if PlayerInventory.remove_item(resource, 1):
			# Extracted one resource
			fulfilled_quantities[i] += 1
	update_slots()
	update_particle_animation()
	check_destruction()
		
func check_destruction():
	for i in range(len(resources)):
		var quantity = quantities[i] if len(quantities) > i else 0
		var fulfilled_quantity = fulfilled_quantities[i]
		if fulfilled_quantity < quantity:
			return
			
	emit_signal("destructed", self)
	queue_free()
