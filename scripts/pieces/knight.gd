extends Sprite

var stack_0 = [Vector2(-1,-2), Vector2(1,-2),Vector2(-1,0), Vector2(1,0)]
var stack_1 = {
	"add" : [Vector2(-2,-1), Vector2(2,-1)],
	"remove" : [Vector2(-1,0), Vector2(1,0)]
}
var stack_2 = [Vector2(-1,2),Vector2(1,2),Vector2(-2,1),Vector2(2,1)]

var stacks
var tex = "res://assets/pieces/knight.png"

func _set_up():
	var s0 = stack_0
	var s1 = []
	for a in stack_0:
		s1.append(a)
	for a in stack_1["add"]:
		s1.append(a)
	for r in stack_1["remove"]:
		s1.erase(r)
	var s2 = []
	for a in s1:
		s2.append(a)
	for a in stack_2:
		s2.append(a)
	stacks = [s0,s1,s2]
