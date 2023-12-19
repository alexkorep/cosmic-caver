tool
extends Area2D


export (Array) var resources = [] setget set_resources
export (Array) var quantities = [] setget set_quantities


var Slot = load("res://scenes/destruction_point/dp_resource_slot.tscn")
var nearby_body = null

onready var CPUParticles2D = $CPUParticles2D


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
		var quantity = quantities[i] if len(quantities) > i else 0
		var slot = Slot.instance()
		slot.texture = resource.icon
		slot.quantity_required = quantity
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
		CPUParticles2D.emitting = true
		# ResourceHarvestedTimer.start()
		# if current_amount > 0:
		# 	CPUParticles2D.direction = (nearby_body.global_position - global_position).normalized()
		# 	CPUParticles2D.emitting = true

func on_body_exited(body):
	CPUParticles2D.emitting = false
	nearby_body = null
	# ResourceHarvestedTimer.stop()
