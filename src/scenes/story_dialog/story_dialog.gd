extends Control

@onready var MessageLabel = $MarginContainer/VBoxContainer/MessageLabel

func _ready():
	MessageLabel.text = ''

func display_message(message):
	MessageLabel.text = message
