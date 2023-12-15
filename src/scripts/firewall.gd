extends Node2D

export var radius = 1000

var firewall_section = preload("res://scenes/firewall_section.tscn")

func _ready():
	var circumferential = 2 * PI * radius
	var num_sections = circumferential / 50

	# Insert num_sections firewall_section nodes in a circle
	for i in range(num_sections):
		var firewall = firewall_section.instance()
		firewall.position = Vector2(radius, 0).rotated(i * 2 * PI / num_sections)
		add_child(firewall)
