extends Sprite

var stack_0 = [Vector2(0,-1)]
var stack_1 = [Vector2(0,-2)]
var stacks
var tex = "res://assets/pieces/musket.png"

func _set_up():
	var s0 = stack_0
	var s1 = []
	for a in stack_0:
		s1.append(a)
	for a in stack_1:
		s1.append(a)
	var s2 = []
	var n = 1
	while n < 9:
		s2.append(Vector2(0,-n))
		n += 1
	stacks = [s0,s1,s2]
