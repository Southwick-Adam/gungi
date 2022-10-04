extends Sprite

var stacks
var tex = "res://assets/pieces/fortress.png"

func _set_up():
	var s0 = lvl1()
	stacks = [s0,s0,s0]

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
