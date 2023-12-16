extends Control

onready var Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_dust_collected(value):
	Label.text = "Dust collected: " + str(value)
