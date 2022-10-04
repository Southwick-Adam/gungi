extends Node2D

onready var pieces_left = {
	$pawn : 9,
	$M_general : 4,
	$L_general : 4,
	$general : 6,
	$archer : 2,
	$knight : 2,
	$musket : 1,
	$captain : 1,
	$samurai : 2,
	$fortress : 2,
	$cannon : 2,
	$spy : 2
}

func _ready():
	var n = 0
	while n < 12:
		var c = get_child(n)
		c.get_node("Label").text = str(pieces_left[c])
		if get_parent().team == "white":
			c.get_node("Sprite").self_modulate = Color(0.212, 0.212, 0.212)
			c.get_node("Sprite/ring").modulate = Color(0.922, 0.922, 0.922)
		n += 1
