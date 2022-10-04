extends Node2D

var tile = preload("res://scenes/tile.tscn")

var tiles_dict = {}
var active_piece = null

onready var bench = get_parent().get_child(1)
onready var piece = preload("res://scenes/piece.tscn")

var no_zone = 6

func _ready():
	var n = 0
	while n < 9:
		var m = 0
		while m < 9:
			var pos = $grid.map_to_world(Vector2(n,m))
			var t = tile.instance()
			$tiles.add_child(t)
			t.position = pos + Vector2(32,32)
			tiles_dict[Vector2(n,m)] = t
			t.coord = Vector2(n,m)
			m += 1
		n += 1
	_choose_king_pos()

func _reset():
	active_piece = null
	for child in $tiles.get_children():
		child._reset()

func _select_tiles(array, ap):
	active_piece = ap
	for a in array:
		if (a.x >= 0 and a.x < 9) and (a.y >= 0 and a.y < 9):
			tiles_dict[a]._color()

func _spawn_piece(nam):
	var tile_coord = $grid.world_to_map(get_global_mouse_position())
	if tile_coord.y < no_zone:
		bench._return_piece()
		return
	var tile_object = tiles_dict[tile_coord]
	if !tile_object.contents.empty():
		if tile_object.contents.size() == 3:
			bench._return_piece()
			return
		if tile_object.contents.back().is_in_group("king"):
			bench._return_piece()
			return
		if nam == "fortress":
			bench._return_piece()
			return
	if nam == "pawn":
		for p in get_tree().get_nodes_in_group("pawn"):
			if tile_coord.x == p.file:
				bench._return_piece()
				return
	var file
	if nam == "king":
		file = load("res://scenes/king.tscn")
	else:
		file = piece
	var np = file.instance()
	$pieces.add_child(np)
	np._setup(nam, "friend", tile_object)
	tile_object.contents.append(np)
	np.z_index = tile_object.contents.size() + 2
	np.position = $grid.map_to_world(tile_coord) + Vector2(32,32)
	$move.position = $grid.map_to_world(tile_coord) + Vector2(32,32)
	tile_object._position_stack()

func _choose_king_pos():
	for child in $tiles.get_children():
		if child.coord.y > 5:
			child._king_spawn()

func _spawn_king():
	for t in get_tree().get_nodes_in_group("tile"):
			t.disabled = true
	for child in $tiles.get_children():
		child.king_spawn = false
	_spawn_piece("king")
	bench.king_set = true
	get_parent()._add_btns()

func _show_stack_box(t):
	var n = 0
	while n < t.contents.size():
		var num = t.contents[n]
		$stack_box.get_child(n).visible = true
		$stack_box.get_child(n).get_node("ring/icon").texture = num.get_node("Sprite/ring/icon").texture
		$stack_box.get_child(n).self_modulate = num.get_node("Sprite").self_modulate
		$stack_box.get_child(n).get_node("ring").modulate = num.get_node("Sprite/ring").modulate
		n += 1
	$stack_box.global_position = t.global_position
	$stack_box.visible = true

func _on_x_pressed():
	_hide_stack()

func _hide_stack():
	$stack_box.visible = false
	$stack_box/Sprite2.visible = false
	$stack_box/Sprite3.visible = false
	yield(get_tree(), "idle_frame")
	if !get_parent().setup:
		for t in get_tree().get_nodes_in_group("tile"):
			t.disabled = false
