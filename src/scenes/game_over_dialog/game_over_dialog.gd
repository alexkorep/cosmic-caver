extends Control

signal new_game()

@onready var AcceptDialog = $AcceptDialog
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func show_gameover():
	AcceptDialog.visible = true

func on_confirmed():
	emit_signal("new_game")
