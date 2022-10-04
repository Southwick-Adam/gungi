extends Sprite

var stack_0 = [Vector2(0,-1)]
var stack_1 = [Vector2(1,1),Vector2(1,-1),Vector2(-1,1),Vector2(-1,-1)]

var stacks
var tex = "res://assets/pieces/spy.png"

func _set_up():
	var s0 = stack_0
	var s1 = stack_1
	var s2 = []
	var dia = diag()
	var lin = lines()
	for d in dia:
		s2.append(d)
	for l in lin:
		s2.append(l)
	stacks = [s0,s1,s2]

func diag():
	var d = []
	var n = -8
	while n < 9:
		if not n == 0:
			d.append(Vector2(n, n))
			d.append(Vector2(n, -n))
		n += 1
	return d

func lines():
	var l = []
	var n = -8
	while n < 9:
		if n != 0:
			l.append(Vector2(n,0))
			l.append(Vector2(0,n))
		n += 1
	return l
