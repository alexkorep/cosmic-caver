extends Node2D

signal on_dust_collected()

const dust_particle_scene = preload("res://scenes/dust/dust_particle.tscn")

var tilemap: TileMap

var REQUIRED_NEIGHBOURS = 3

var occupied_list = []

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_parent()
	add_particles()
	
func add_particles():
	occupied_list = []
	for cell in tilemap.get_used_cells():
		add_particle_if_empty_neightbour(cell)

func get_neighbours(pos) -> Array:
	var shift = 1 if int(pos.y) % 2 else -1
	var pos_list = [
		Vector2(pos.x + 1, pos.y),
		Vector2(pos.x - 1, pos.y),
		Vector2(pos.x, pos.y - 1),
		Vector2(pos.x + shift, pos.y - 1),
		Vector2(pos.x, pos.y + 1),
		Vector2(pos.x + shift, pos.y + 1),
	]
	return pos_list

func count_neighbours_of_tile_id(pos, tile_id):
	var count = 0
	var pos_list = get_neighbours(pos)
	for pos_neighbour in pos_list:
		var id = tilemap.get_cellv(pos_neighbour)
		if tile_id == id:
			count += 1
	return count

func add_particle_if_empty_neightbour(pos):
	var pos_list = get_neighbours(pos)
	for pos_neighbour in pos_list:
		var tile_id = tilemap.get_cellv(pos_neighbour)
		if tile_id < 0:
			if count_neighbours_of_tile_id(pos_neighbour, tile_id) == REQUIRED_NEIGHBOURS:
				if not occupied_list.has(pos_neighbour):
					occupied_list.append(pos_neighbour)
					var screen_pos = tilemap.map_to_world(pos_neighbour) + tilemap.cell_size / 2
					add_particle(screen_pos)

func _on_dust_particle_dead(body):
	if body is Spaceship:
		emit_signal("on_dust_collected")

func add_particle(pos):
	var dust_particle = dust_particle_scene.instance()
	add_child(dust_particle)
	dust_particle.position = pos
	# Connect to dust particle's signal dust_particle_dead
	dust_particle.connect("dust_particle_dead", self, "_on_dust_particle_dead")


func _on_DustEmitTimer_timeout():
	add_particles()
