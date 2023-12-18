extends Node

var items: Dictionary = {} # Key: ItemResource's name, Value: InventoryItem

func add_item(resource: ItemResource, amount: int = 1):
	var item_name = resource.name
	if items.has(item_name):
		items[item_name].quantity += amount
	else:
		items[item_name] = InventoryItem.new(resource, amount)

func get_item_quantity(resource: ItemResource) -> int:
	var item_name = resource.name
	return items.get(item_name, InventoryItem.new(resource, 0)).quantity

func remove_item(resource: ItemResource, amount: int = 1) -> bool:
	var item_name = resource.name
	if items.has(item_name) and items[item_name].quantity >= amount:
		items[item_name].quantity -= amount
		if items[item_name].quantity <= 0:
			items.erase(item_name)
		return true
	return false

# func save_inventory_to_file(file_path: String):
# 	var save_data = {}
# 	for item_name in items.keys():
# 		save_data[item_name] = {
# 			"quantity": items[item_name].quantity
# 		}
# 	var file = File.new()
# 	if file.open(file_path, File.WRITE) == OK:
# 		file.store_line(to_json(save_data))
# 		file.close()

# func load_inventory_from_file(file_path: String):
# 	var file = File.new()
# 	if file.open(file_path, File.READ) == OK:
# 		var save_data = parse_json(file.get_as_text())
# 		file.close()
# 		for item_name in save_data.keys():
# 			# Assuming you have a function get_resource_by_name to fetch the resource instance by name
# 			var resource = get_resource_by_name(item_name)
# 			if resource:
# 				items[item_name] = InventoryItem.new(resource, save_data[item_name]["quantity"])
# 			else:
# 				print("Resource not found: " + item_name)
