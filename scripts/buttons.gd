extends Node2D

onready var game = get_parent()
var team

func _on_ready_pressed():
	game._end_setup()
	$ready.queue_free()
