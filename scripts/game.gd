extends Node2D

@onready var player_spawn_position = $player_spawn_position
@onready var laser_container = $laser_container
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = player_spawn_position.global_position
	player.laser_shot.connect(_on_player_laser_shot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
