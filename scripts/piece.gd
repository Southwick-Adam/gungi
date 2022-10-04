extends Node2D

var title
var tile_obj
var file

func _setup(nam, team, ob):
	title = nam
	tile_obj = ob
	$Sprite.set_script(load("res://scripts/pieces/" + str(nam) + ".gd"))
	add_to_group(team)
	if (nam == "pawn") and (team == "friend"):
		add_to_group("pawn")
		file = ob.coord.x
	$Sprite/ring/icon.texture = load($Sprite.tex)
	$Sprite._set_up()
	if get_node("/root/main/game").team == "black":
		$Sprite.self_modulate = Color(0.212, 0.212, 0.212)
		$Sprite/ring.modulate = Color(0.922, 0.922, 0.922)

func _move(t):
	position = t.position
	tile_obj.contents.erase(self)
	tile_obj._position_stack()
	t.contents.append(self)
	t._position_stack()
	z_index = t.contents.size() + 2
	tile_obj = t
	if title == "captain":
		_captain()
	elif title == "pawn":
		file = t.coord.x

func _captain():
	$Sprite.stacks.clear()
	$Sprite._reset_stacks()
