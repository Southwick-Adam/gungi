extends Node2D

var tile = preload("res://scenes/tile.tscn")
var tiles_dict = {}

var lv = 0
var current_nam
var first = true

onready var lv_sprites = [$lv1/Sprite, $lv2/Sprite, $lv3/Sprite]

func _ready():
	$tile.modulate = Color(0.122, 0.4, 0.506)
	var n = 1
	while n < 8:
		var m = 1
		while m < 8:
			var pos = $grid.map_to_world(Vector2(n,m))
			var t = $tile.duplicate()
			$tiles.add_child(t)
			t.position = pos + Vector2(32,32)
			tiles_dict[Vector2(n,m)] = t
			m += 1
		n += 1
	$tile.queue_free()
	_lv_mod()

func _demo(nam):
	if first:
		first = false
		lv_sprites[0].modulate = Color(1,1,1)
	$demo.visible = true
	_reset()
	current_nam = nam
	if nam == "captain":
		$demo.set_script(load("res://scripts/pieces/fortress.gd"))
		$demo/ring/icon.texture = load("res://assets/pieces/captain.png")
	else:
		$demo.set_script(load("res://scripts/pieces/" + str(nam) + ".gd"))
		$demo/ring/icon.texture = load($demo.tex)
	if lv == 2:
		if nam == "musket":
			$arrow_h.get_child(0).visible = true
		if nam == "cannon" or nam == "spy":
			for a in $arrow_h.get_children():
				a.visible = true
		if nam == "samurai" or nam == "spy":
			$arrow_v.visible = true
	$demo._set_up()
	var stacks = $demo.stacks
	for t in stacks[lv]:
		if tiles_dict.keys().has(Vector2(4,4) + t):
			tiles_dict[Vector2(4,4) + t].modulate = Color(0.306, 0.624, 0.263)

func _reset():
	for t in $tiles.get_children():
		t.modulate = Color(0.122, 0.4, 0.506)
	for a in $arrow_h.get_children():
		a.visible = false
	$arrow_v.visible = false
	$block.visible = false

func _on_pawn_pressed():
	_demo("pawn")
func _on_M_general_pressed():
	_demo("M_general")
func _on_L_general_pressed():
	_demo("L_general")
func _on_general_pressed():
	_demo("general")
func _on_archer_pressed():
	_demo("archer")
func _on_knight_pressed():
	_demo("knight")
func _on_musket_pressed():
	_demo("musket")
func _on_captain_pressed():
	current_nam = "captain"
	_lv_btn(0)
	$block.visible = true
func _on_samurai_pressed():
	_demo("samurai")
func _on_fortress_pressed():
	current_nam = "fortress"
	_lv_btn(0)
	$block.visible = true
func _on_cannon_pressed():
	_demo("cannon")
func _on_spy_pressed():
	_demo("spy")
func _on_king_pressed():
	_demo("king")

func _lv_mod():
	for l in lv_sprites:
		l.modulate = Color(0.561, 0.482, 0.482)

func _lv_btn(num):
	if !$block.visible:
		lv = num
		_lv_mod()
		lv_sprites[num].modulate = Color(1,1,1)
		_demo(current_nam)

func _on_lv1_pressed():
	if !first:
		_lv_btn(0)
func _on_lv2_pressed():
	if !first:
		_lv_btn(1)
func _on_lv3_pressed():
	if !first:
		_lv_btn(2)

func _on_x_pressed():
	queue_free()
