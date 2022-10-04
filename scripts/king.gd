extends Node2D

var title
var tile_obj

func _setup(nam, team, ob):
	title = nam
	tile_obj = ob
	$Sprite.set_script(load("res://scripts/pieces/" + str(nam) + ".gd"))
	add_to_group(team)
	$Sprite/ring/icon.texture = load($Sprite.tex)
	$Sprite._set_up()
	if get_node("/root/main/game").team == "black":
		$Sprite.self_modulate = Color(0.212, 0.212, 0.212)
		$Sprite/ring.modulate = Color(0.922, 0.922, 0.922)

func _action(state, t):
	if state == "move" or state == "stack":
		_move(t)

func _move(t):
	position = t.position
	tile_obj.contents.erase(self)
	t.contents.append(self)
	z_index = t.contents.size() + 2
	tile_obj = t
