extends Sprite

var stack_0 = [Vector2(1,0),Vector2(-1,0),Vector2(0,1),Vector2(0,-1)]
var stack_1 = [Vector2(2,0),Vector2(-2,0),Vector2(0,2),Vector2(0,-2)]
var stacks
var tex = "res://assets/pieces/cannon.png"

func _set_up():
	var s0 = stack_0
	var s1 = []
	for a in stack_0:
		s1.append(a)
	for a in stack_1:
		s1.append(a)
	var s2 = lines()
	stacks = [s0,s1,s2]

func lines():
	var l = []
	var n = -8
	while n < 9:
		if n != 0:
			l.append(Vector2(n,0))
			l.append(Vector2(0,n))
		n += 1
	return l
