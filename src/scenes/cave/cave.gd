extends TileMap

# TODO certains tiles can be dissolved
# with certain gases

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)  # Enable input processing

# func _input(event):
# 	if event is InputEventScreenTouch:
# 		print(event)
# 		_handle_mouse_click(event.position)

# func _handle_mouse_click(position):
# 	#var local_mouse_position = global_mouse_position - get_global_position()
# 	# var pos = local_to_map()
# 	# var local_position = to_local(global_mouse_position)
# 	var a = get_global_mouse_position()
# 	var local_position = to_local(position)
# 	print(a, local_position)
# 	var map_position = world_to_map(position)
# 	#print(a)
# 	var tile = get_cellv(map_position)
# 	#print("global_mouse_position:", position, ", map_position: ", map_position, ", tile: ", tile)
# 	if tile >= 0:
# 		set_cellv(map_position, -1)

# func _input(event):
# 	if event is InputEventMouseButton and event.pressed:
# 			_handle_mouse_click(event.position)

# func _handle_mouse_click(position):
# 	var map_position = world_to_map(to_local(position))
# 	var tile = get_cellv(map_position)
# 	if tile >= 0:
# 			set_cellv(map_position, -1)

# func _unhandled_input(event):
# 	# print("unhandled_input")
# 	if event is InputEventMouseButton:
# 			if event.button_index == BUTTON_LEFT and event.pressed:
# 					var clicked_cell = world_to_map(event.position)
# 					var tile = get_cellv(clicked_cell)
# 					if tile >= 0:
# 							set_cellv(clicked_cell, -1)


func _on_StaticBody2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch:
		print(event.position, shape_idx)
