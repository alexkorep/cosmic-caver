extends Node2D

signal on_dust_collected()

export var particle_count = 100
export var size = 1000

const dust_particle_scene = preload("res://scenes/dust/dust_particle.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	# add dust particles, randomly, number of particles is particle_count
	for _i in range(particle_count):
		add_particle()


func _on_dust_particle_dead(body):
	# remove dust particle from scene tree
	body.queue_free()
	emit_signal("on_dust_collected")

func add_particle():
	var dust_particle = dust_particle_scene.instance()
	add_child(dust_particle)
	dust_particle.position = Vector2(rand_range(-size, size), rand_range(-size, size))
	# Connect to dust particle's signal dust_particle_dead
	dust_particle.connect("dust_particle_dead", self, "_on_dust_particle_dead")
