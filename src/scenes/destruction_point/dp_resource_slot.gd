@tool
extends Control

@export var texture: Texture2D : set = set_texture
@export var quantity: int : set = set_quantity
@export var quantity_required: int : set = set_quantity_required

@onready var textureRect = $HBoxContainer/TextureRect
@onready var label = $HBoxContainer/Label

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
	if textureRect:
		textureRect.texture = texture
	if label:
		label.text = str(quantity) + '/' + str(quantity_required)

func _process(delta):
	update_ui()
