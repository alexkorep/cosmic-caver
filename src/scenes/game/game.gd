extends Node2D

# Collision layers:
# 1 - player

var dust_collected = 0
export var dust_to_collect = 10

onready var HUD = $CanvasLayer/HUD
onready var GameOverDialog = $CanvasLayer/GameOverDialog
onready var Spaceship = $Spaceship
onready var StoryDialog = $CanvasLayer/StoryDialog
onready var StoryManager = $StoryManager

# Called when the node enters the scene tree for the first time.
func _ready():
	StoryManager.on_level(GameState.get_current_level())

func on_dust_collected():
	dust_collected += 1
	HUD.set_dust_collected(dust_collected)
	if dust_collected >= dust_to_collect:
		Spaceship.mission_completed()

func on_game_over_dialog_new_game():
	reset_scene()

func reset_scene():
	var current_scene = get_tree().current_scene
	var scene_path = current_scene.filename
	get_tree().change_scene(scene_path)

func on_asteroid_hit():
	GameOverDialog.show_gameover()

func _on_Spaceship_ship_submerged():
	# TODO comnect the story manager directly
	GameState.next_level()
	# Reload the scene
	reset_scene()

func on_story_message(message):
	StoryDialog.display_message(message)
