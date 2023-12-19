class_name StoryManager
extends Node

signal on_story_message(message)

var current_level := 0
var current_message := 0
var emit_message_time_sec := 5.0

var messages = [
# Level 0
[
"""
All I know is that I need to collect 20 pieces of carbon.
I need to bring them back to Mother.
""",

"""
Mother is building something.
She needs all the carbon she can get.
""",

"""
But what do I know.
I'm just a probe.
"""
],

# Level 1
[
"""
I did a good job.
Mother is happy.
""",

"""
I'm going to go back out and collect more carbon.
""",

]
]

func on_level(level):
	if level >= messages.size():
		print("No more messages for level " + str(level))
		return

	# Make a timer that will emit the next message.
	var timer = Timer.new()
	timer.set_wait_time(emit_message_time_sec)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "emit_next_message")
	add_child(timer)
	timer.start()

func emit_next_message():
	var message_list = messages[current_level]
	emit_signal("on_story_message", message_list[current_message])
	current_message += 1
	if current_message >= message_list.size():
		current_message = 0
