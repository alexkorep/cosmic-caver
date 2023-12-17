class_name InventoryItem

var item_resource: ItemResource
var quantity: int = 0

func _init(_item_resource: ItemResource, _quantity: int = 0):
	item_resource = _item_resource
	quantity = _quantity
