extends RigidBody2D

signal asteroid_hit()

export var asteroid_id = 0
onready var Sprites = $Sprites
onready var CollisionShape2D = $CollisionShape2D

var gravity_point = Vector2(0, 0)  # The position of your gravity center
var gravity_strength = 100.0   # Adjust the strength as needed


func _ready():
	# Set random speed and direction
	linear_velocity = Vector2(rand_range(-100, 100), rand_range(-100, 100))
	# Set random angular velocity
	angular_velocity = rand_range(-10, 10)

	# Make the appropriate sprite visible
	for i in range(Sprites.get_child_count()):
		var sprite = Sprites.get_child(i)
		sprite.visible = i == asteroid_id
		if i == asteroid_id:
			# Set the collision shape circle diameter to the sprite size
			var region_size = sprite.region_rect.size
			var visible_size = region_size * sprite.scale
			CollisionShape2D.shape = CircleShape2D.new()
			CollisionShape2D.shape.radius = visible_size.x / 2
			

func _process(delta):
	# Rotate the asteroid
	Sprites.rotate(delta)

	var direction = (gravity_point - global_position).normalized()
	#var distance = global_position.distance_to(gravity_point)
	var force = direction * gravity_strength #/ max(distance, 1)
	apply_central_impulse(force * delta)

	# check_fall_on_black_hole()


func on_body_entered(body):
	emit_signal("asteroid_hit")
