extends Node2D

# Collision layers:
# 1 - player

var dust_collected = 0
export var dust_to_collect = 10

onready var HUD = $CanvasLayer/HUD
onready var GameOverDialog = $CanvasLayer/GameOverDialog
onready var Spaceship = $Spaceship

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
	get_tree().change_scene("res://scenes/briefing_screen/briefing_screen.tscn")
