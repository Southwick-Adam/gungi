extends Sprite

var stack_0 = [Vector2(0,-1)]
var stack_1 = [Vector2(1,-1), Vector2(-1,-1)]

var stacks
var tex = "res://assets/pieces/pawn.png"

func _set_up():
	var s0 = stack_0
	var s1 = []
	for a in stack_0:
		s1.append(a)
	for a in stack_1:
		s1.append(a)
	stacks = [s0,s1,s1]#S1 = S2
