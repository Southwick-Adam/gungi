extends Node2D

var contents = []
var active_target = false
var active_select = false
var coord = Vector2()

onready var game = get_node("/root/main/game")
onready var board = get_node("../..")
onready var ATST = preload("res://scenes/at-st.tscn")

var king_spawn = false
var disabled = false
var need_atst = false

var red = Color(0.624, 0.263, 0.263)
var green = Color(0.306, 0.624, 0.263)
var blue = Color(0.122, 0.4, 0.506)
var purple = Color(0.459, 0.263, 0.624)
var black = Color(0.133, 0.133, 0.098)

func _ready():
	$base.modulate = blue
	
func _color():
	if contents.empty():
		$base.modulate = green
		active_target = true
	elif contents.back().title == "king":
		$base.modulate = black
		return
	else: #IF FILLED
		if board.active_piece.title == "fortress":
			$base.modulate = black
			return
		if contents.back().is_in_group("friend"):
			if contents.size() < 3:#STACK
				$base.modulate = purple
				active_target = true
			else:#NOT ALLOWED
				$base.modulate = black
				return
		elif contents.back().is_in_group("enemy"):#NEED TO ADD STATES
			$base.modulate = red
			active_target = true
			if contents.size() < 3:
				need_atst = true

func _reset():
	active_select = false
	active_target = false
	$base.modulate = blue

func _on_TouchScreenButton_pressed():
	if !disabled:
		$Timer.start()
		_btn_activate()

func _on_TouchScreenButton_released():
	$Timer.stop()

func _on_Timer_timeout():
	if !contents.empty() and !king_spawn:
		board._show_stack_box(self)
		for t in get_tree().get_nodes_in_group("tile"):
			t.disabled = true

func _btn_activate():
	if king_spawn:
		board._spawn_king()
		board._reset()
		return
	if get_child_count() > 3:
		return
	if active_target:
		if !need_atst:
			board.active_piece._move(self)
			board.get_node("move").global_position = global_position
			board._reset()
		else:
			_call_atst()
	else:
		if not contents.empty():
			if active_select:
				board._reset()
			else: #NEITHER
				board._reset()
				var contig = ["musket", "cannon", "samurai", "spy"]
				if contig.has(contents.back().title) and contents.size() > 2:
					_contig_targets()
				else:
					_find_targets()
				active_select = true

func _find_targets():
	var targetTiles = []
	var top_piece = contents.back()
	var stacks = top_piece.get_child(0).stacks
	for vector in stacks[contents.size() - 1]:
		targetTiles.append(coord + vector)
	board._select_tiles(targetTiles, top_piece)

func _contig_targets():
	var hor = ["cannon", "musket"]
	var dia = ["samurai", "spy"]
	var result = []
	var targetTiles = []
	var full_tiles = []
	var top_piece = contents.back()
	var stacks = top_piece.get_child(0).stacks
	for vector in stacks[contents.size() - 1]:
		if board.tiles_dict.keys().has(coord + vector):
			if not board.tiles_dict[coord + vector].contents.empty():
				full_tiles.append(coord + vector)
		targetTiles.append(coord + vector)
	if !full_tiles.empty():
		if hor.has(contents.back().title):
			var h = _horiz(full_tiles, targetTiles)
			for a in h:
				result.append(a)
		if dia.has(contents.back().title):
			var d = _diag(full_tiles, targetTiles, contents.back().title)
			for a in d:
				result.append(a)
	else:
		result = targetTiles
	board._select_tiles(result, top_piece)

func _diag(full, targ, title):
	var NW = []
	var NE = []
	var SW = []
	var SE = []
	var result = targ.duplicate()
	for f in full:
		if f.x < coord.x:
			if f.y < coord.y:
				NW.append(f.x)
			elif f.y > coord.y:
				SW.append(f.x)
		elif f.x > coord.x:
			if f.y < coord.y:
				NE.append(f.x)
			elif f.y > coord.y:
				SE.append(f.x)
	for t in targ:
		if !NW.empty() and t.x < coord.x and t.y < coord.y:
			if t.x < NW.max():
				result.erase(t)
		elif !SW.empty() and t.x < coord.x and t.y > coord.y:
			if t.x < SW.max():
				result.erase(t)
		elif !NE.empty() and t.x > coord.x and t.y < coord.y:
			if t.x > NE.min():
				result.erase(t)
		elif !SE.empty() and t.x > coord.x and t.y > coord.y:
			if t.x > SE.min():
				result.erase(t)
	if title == "spy":
		return _horiz(full, result)
	return result

func _horiz(full, targ):
	var right = []
	var left = []
	var above = []
	var below = []
	var result = targ.duplicate()
	for f in full:
		if f.x == coord.x: #VERTICAL LINE // DISTINCT Y VALUES
			if f.y > coord.y:
				below.append(f.y)
			else:
				above.append(f.y)
		elif f.y == coord.y: #HORIZONTAL LINE // DISTINCT X VALUES
			if f.x > coord.x:
				right.append(f.x)
			else:
				left.append(f.x)
	for t in targ:
		if t.x == coord.x:
			if !below.empty() and t.y > coord.y:
				if t.y > below.min():
					result.erase(t)
			if !above.empty() and t.y < coord.y:
				if t.y < above.max():
					result.erase(t)
		elif t.y == coord.y:
			if !right.empty() and t.x > coord.x:
				if t.x > right.min():
					result.erase(t)
			if !left.empty() and t.x < coord.x:
				if t.x < left.max():
					result.erase(t)
	return result

func _king_spawn():
	king_spawn = true
	$base.modulate = green

func _position_stack():
	for c in contents:
		c.position = position
	if contents.size() == 2:
		contents[0].position.y += 5
		contents[1].position.y -= 5
	elif contents.size() == 3:
		contents[0].position.y += 8
		contents[2].position.y -= 8

func _call_atst():
	var a = ATST.instance()
	add_child(a)
	need_atst = false

func _atst(v):
	if v == "at":
		var b = contents.back()
		contents.erase(b)
		b.queue_free()
	board.active_piece._move(self)
	board._reset()
