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

enum ResourceType { 
	Sulfur, # Orange
	Azurite, # Blue
	Chromium  # Green
}

export(ResourceType) var resource_type setget set_resource_type


onready var Sprites = $Sprites
onready var CPUParticles2D = $CPUParticles2D

var nearby_body = null

# This setter function gets called every time resource_type changes
func set_resource_type(value):
	resource_type = value
	update_sprites()

func _ready():
	update_sprites()

func _process(delta):
	# This is needed to make sure the sprites update in the editor
	update_sprites()
	if nearby_body:
		CPUParticles2D.direction = (nearby_body.global_position - global_position).normalized()


func update_sprites():
	# Show the child of Sprites with the same index as the resource type, and hide the others
	if not Sprites:
		return
	for i in range(Sprites.get_child_count()):
		Sprites.get_child(i).visible = i == resource_type


func on_body_entered(body):
	# Start emitting CPUParticles2D when the player enters the area, towards the player
	if body is Spaceship:
		nearby_body = body
		CPUParticles2D.direction = (nearby_body.global_position - global_position).normalized()
		CPUParticles2D.emitting = true

func on_body_exited(body):
	CPUParticles2D.emitting = false
	nearby_body = null
