
extends Node2D

const Player = preload("res://Actors/Player2D.tscn")
const Exit = preload("res://Actors/Guard/stullguardtest.tscn")

var borders = Rect2(1, 1, 38, 38)

onready var tileMap = $LevelNavigation/TileMap

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(19, 19), borders)
	var map = walker.walk(200)
	
	var player = Player.instance()
	add_child(player)
	player.position = map.front()*16
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position*16
	exit.connect("leaving_level", self, "reload_level")
	
	walker.queue_free()
	for location in map:
		tileMap.set_cellv(location, 1)
	tileMap.update_bitmask_region(borders.position, borders.end)

func reload_level():
	get_tree().reload_current_scene()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()
