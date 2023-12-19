tool
extends Control

export (Texture) var texture setget set_texture
export (int) var quantity setget set_quantity
export (int) var quantity_required setget set_quantity_required

onready var TextureRect = $HBoxContainer/TextureRect
onready var Label = $HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_texture(value):
	texture = value
	update_ui()
	
func set_quantity_required(value):
	quantity_required = value
	update_ui()
	
func set_quantity(value):
	quantity = value
	update_ui()

func update_ui():
	if TextureRect:
		TextureRect.texture = texture
	if Label:
		Label.text = str(quantity) + '/' + str(quantity_required)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
