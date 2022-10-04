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

var np = null
var np_active = false
var mouse_dif
var on_board = false
onready var board = get_parent().get_child(0)
var king_set = false

func _ready():
	var n = 0
	while n < 12:
		var c = get_child(n)
		c.get_node("Label").text = str(pieces_left[c])
		if get_parent().team == "black":
			c.get_node("Sprite").self_modulate = Color(0.212, 0.212, 0.212)
			c.get_node("Sprite/ring").modulate = Color(0.922, 0.922, 0.922)
		n += 1
	if get_parent().team == "black":
		$new_piece.self_modulate = Color(0.212, 0.212, 0.212)
		$new_piece/ring.modulate = Color(0.922, 0.922, 0.922)

func _process(delta):
	if np_active:
		$new_piece.global_position = get_global_mouse_position() + mouse_dif
	if $red.modulate.a > 0:
		$red.modulate.a -= .24 * delta

func _input(event):
	if event.is_action_released("mouse") and np_active and np != null:
		_unclick()
		np_active = false
		$new_piece.visible = false

func _unclick():
	if on_board:
		board._spawn_piece(np.name)
	else:
		_return_piece()

func _return_piece():
	pieces_left[np] += 1
	np.visible = true
	np.get_node("Label").text = str(pieces_left[np])
	$red.modulate.a = .12

func _new_piece(p):
	if !king_set:
		return
	board._reset()
	board._hide_stack()
	$new_piece.position = p.position
	$new_piece.get_node("ring/icon").texture = p.get_node("Sprite/ring/icon").texture
	$new_piece.visible = true
	np_active = true
	np = p
	mouse_dif = $new_piece.global_position - get_global_mouse_position()
	pieces_left[p] -= 1
	if pieces_left[p] == 0:
		p.visible = false
	else:
		p.get_node("Label").text = str(pieces_left[p])

func _on_pawn_pressed():
	_new_piece($pawn)
func _on_M_general_pressed():
	_new_piece($M_general)
func _on_L_general_pressed():
	_new_piece($L_general)
func _on_general_pressed():
	_new_piece($general)
func _on_archer_pressed():
	_new_piece($archer)
func _on_knight_pressed():
	_new_piece($knight)
func _on_musket_pressed():
	_new_piece($musket)
func _on_captain_pressed():
	_new_piece($captain)
func _on_samurai_pressed():
	_new_piece($samurai)
func _on_fortress_pressed():
	_new_piece($fortress)
func _on_cannon_pressed():
	_new_piece($cannon)
func _on_spy_pressed():
	_new_piece($spy)

func _on_Area2D_mouse_entered():
	on_board = true

func _on_Area2D_mouse_exited():
	on_board = false
