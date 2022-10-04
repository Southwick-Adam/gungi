extends Node2D

var setup = true
var turn  = 0 #black
var team = "white"

func _add_btns():
	var buttons = load("res://scenes/buttons.tscn")
	var btn = buttons.instance()
	add_child(btn)

func _end_setup():
	setup = false
	get_node("board").no_zone = 3
	for t in get_tree().get_nodes_in_group("tile"):
		t.disabled = false
