extends Node

onready var viewport1 = $VBoxContainer/ViewportContainer1/Viewport
onready var camera1 = $VBoxContainer/ViewportContainer1/Viewport/Camera2D

func _ready():
	if get_tree().has_group("Player2D"):
		camera1.target = get_tree().get_nodes_in_group("Player2D")[0]
