extends RigidBody2D
class_name Asteroid

signal asteroid_hit(asteroid, body)

@export var asteroid_id = 0
@onready var Sprites = $Sprites
@onready var CollisionShape2D = $CollisionShape2D


func _ready():
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

func on_body_entered(body):

	emit_signal("asteroid_hit", self, body)
