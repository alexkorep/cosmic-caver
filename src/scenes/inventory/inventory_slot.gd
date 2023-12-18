tool
extends Control


export  (Resource) var inventory_item setget set_inventory_item

onready var TextureRect = $TextureRect
onready var Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	update_texture()

func _process(_delta):
	update_auantity_and_visibility()

func set_inventory_item(value):
	inventory_item = value
	update_texture()
	
func update_texture():
	TextureRect = $TextureRect
	if inventory_item and TextureRect:
		$TextureRect.texture = inventory_item.icon
	
func update_auantity_and_visibility():
	if Engine.editor_hint:
		return
	var qty = PlayerInventory.get_item_quantity(inventory_item)
	Label.text = str(qty)
	visible = qty > 0
