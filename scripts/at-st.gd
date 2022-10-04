extends Node2D

func _on_at_pressed():
	get_parent()._atst("at")
	queue_free()

func _on_st_pressed():
	get_parent()._atst("st")
	queue_free()
