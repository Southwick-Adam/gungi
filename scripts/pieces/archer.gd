extends Sprite

var stacks
var tex = "res://assets/pieces/archer.png"

func _set_up():
	var s0 = lvl1()
	var s1 = []
	s1 = lvl2()
	for s in s0:
		s1.erase(s)
	var s2 = []
	s2 = lvl3()
	for s in s1:
		s2.erase(s)
	for s in s0:
		s2.erase(s)
	stacks = [s0,s1,s2]

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

func lvl2():
	var lv = []
	var n = -2
	while n < 3:
		var m = -2
		while m < 3:
			if not (n == 0 and m == 0):
				lv.append(Vector2(n,m))
			m += 1
		n += 1
	return lv

func lvl3():
	var lv = []
	var n = -3
	while n < 4:
		var m = -3
		while m < 4:
			if not (n == 0 and m == 0):
				lv.append(Vector2(n,m))
			m += 1
		n += 1
	return lv
