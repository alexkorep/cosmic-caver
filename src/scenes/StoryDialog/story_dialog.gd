extends Control

onready var MessageLabel = $MessageLabel

func _ready():
	MessageLabel.text = ''

func display_message(message):
	MessageLabel.text = message
