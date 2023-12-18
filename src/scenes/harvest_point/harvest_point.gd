tool
extends Area2D


"""
Orange Crystals:

Iron Oxides: Minerals like hematite or goethite can have an orange tint.
Realgar: An arsenic sulfide mineral, is known for its bright orange color.
Sulfur: Pure sulfur can sometimes appear orange.
Blue Crystals:

Copper Compounds: Such as azurite (copper carbonate) and chalcanthite (copper sulfate), often exhibit a rich blue color.
Cobalt Compounds: Cobalt(II) aluminate, known as cobalt blue, is a vivid blue.
Sodalite: A rich, royal blue mineral that is a member of the feldspathoid mineral group.
Green Crystals:

Copper Compounds: Malachite (copper carbonate hydroxide) is famous for its vibrant green color.
Chromium or Vanadium: Minerals containing these elements, like emerald (a variety of beryl), can be green.
Iron Silicates: Minerals like olivine or peridot can have a green color due to iron.

"""


export(Resource) var inventory_item setget set_inventory_item
export var max_amount = 10
export var current_amount = 10
export var texture: Texture = null setget set_texture

onready var ResourceIconSprite = $ResourceIconSprite
onready var CPUParticles2D = $CPUParticles2D
onready var ResourceHarvestedTimer = $ResourceHarvestedTimer
onready var ProgressBar = $ProgressBar

var nearby_body = null

# This setter function gets called every time resource_type changes
func set_inventory_item(value):
	inventory_item = value
	update_sprite()
	
func set_texture(value):
	texture = value
	update_sprite()

func _ready():
	update_sprite()
	update_progress_bar()
	current_amount = max_amount

func _process(delta):
	# This is needed to make sure the sprites update in the editor
	update_sprite()
	if nearby_body:
		CPUParticles2D.direction = (nearby_body.global_position - global_position).normalized()

func update_sprite():
	if not texture:
		return
	$ResourceIconSprite.texture = texture

func update_progress_bar():
	ProgressBar.value = current_amount
	ProgressBar.max_value = max_amount

func on_body_entered(body):
	# Start emitting CPUParticles2D when the player enters the area, towards the player
	if body is Spaceship:
		nearby_body = body
		ResourceHarvestedTimer.start()
		if current_amount > 0:
			CPUParticles2D.direction = (nearby_body.global_position - global_position).normalized()
			CPUParticles2D.emitting = true

func on_body_exited(body):
	CPUParticles2D.emitting = false
	nearby_body = null
	ResourceHarvestedTimer.stop()

func _on_Timer_timeout():
	if current_amount > 0:
		PlayerInventory.add_item(inventory_item)
		current_amount -= 1

	if current_amount <= 0:
		CPUParticles2D.emitting = false
	update_progress_bar()

func _on_ResouceRestoreTimer_timeout():
	if current_amount < max_amount:
		current_amount += 1
		update_progress_bar()
