extends Sprite

var stacks = []
var tex = "res://assets/pieces/captain.png"
var tile

func _set_up():
	tile = get_parent().tile_obj
	stacks.append(lvl1())
	if tile.contents.size() > 0:
		for s in _below():
			stacks.append(s)

func _reset_stacks():
	tile = get_parent().tile_obj
	stacks.append(lvl1())
	if tile.contents.size() > 1:
		for s in _below():
			stacks.append(s)

func lvl1():
	var lv = []
	var n = -1
	while n < 2:
		var m = -1
		while m < 2:
			if not (n == 0 and m == 0):
				lv.append(Vector2(n,m))
			m += 1
		n += 1
	return lv

func _below():
	var below = tile.contents[tile.contents.size() - 2].get_child(0)
	var s1 = below.stacks[1]
	var s2 = below.stacks[2]
	return [s1,s2]
