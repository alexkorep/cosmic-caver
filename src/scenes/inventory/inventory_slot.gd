@tool
extends Control

@export var inventory_item: Resource: 
	set (value):
		inventory_item = value
		update_texture()

@onready var textureRect = $TextureRect
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	update_texture()

func _process(_delta):
	update_auantity_and_visibility()
	
func update_texture():
	if inventory_item and textureRect:
		$TextureRect.texture = inventory_item.icon
	
func update_auantity_and_visibility():
	if Engine.is_editor_hint():
		return
	var qty = PlayerInventory.get_item_quantity(inventory_item)
	label.text = str(qty)
	visible = qty > 0
