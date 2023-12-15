extends Node2D

export var radius = 500
export var radial_line_length = 500
var color = Color(0, 1, 0)
var point_count = radius/20

onready var CollisionPolygon2D = $CollisionPolygon2D


func _ready():
	point_count = radius/20
	update()  # Request that Godot redraws this node

	# Make CollisionPolygon2D.poligon in shape of a donut with a hole in the middle, 
	# with internal radius of `radius` and external radius of `radius + radial_line_length`
	var points = []
	for i in range(point_count + 1):
		var angle = i * 2*PI / point_count
		points.append(Vector2(cos(angle), sin(angle)) * radius)

	for i in range(point_count + 1):
		var angle = 2*PI - i * 2*PI / point_count
		points.append(Vector2(cos(angle), sin(angle)) * (radius + radial_line_length))
	CollisionPolygon2D.polygon = points

func _draw():
	var step = 1
	for _i in range(20):
		draw_green_circle(radius + step)
		step += step
	draw_radial_lines()

func draw_green_circle(rad):
	var center = position
	draw_arc(center, rad, 0, 2*PI, point_count, color)

func draw_radial_lines():
	var center = position
	for i in range(point_count):
		var angle = i * 2*PI / point_count
		var end = Vector2(cos(angle), sin(angle)) * radius
		var start = Vector2(cos(angle), sin(angle)) * (radius + radial_line_length)
		draw_line(center + start, center + end, color, 2)
	
