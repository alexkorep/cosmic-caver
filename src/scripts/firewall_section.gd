extends Node2D


onready var CPUParticles2D = $CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make particles point to the point located at Vecror2(0, 0)
	# Calculate this direction based on the current position of the node.
	CPUParticles2D.direction = Vector2(0, 0) - position
	print(CPUParticles2D.direction)

  
