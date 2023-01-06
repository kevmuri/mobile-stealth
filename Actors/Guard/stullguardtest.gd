extends KinematicBody2D

export(int) var SPEED: int = 40
var velocity: Vector2 = Vector2.ZERO

var path: Array = []	# Contains destination positions
var levelNavigation: Navigation2D = null
var player = null
var player_spotted: bool = false

onready var line2d = $Line2D


func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player2D"):
		player = tree.get_nodes_in_group("Player2D")[0]

func _physics_process(delta):
	var current_animation = "walk"
	#line2d.global_position = Vector2.ZERO
	generate_path()
	navigate()
	move()
	
	if velocity.length() != 0:
		$Light2D.rotation = velocity.angle()
		$WeakPoint.rotation = velocity.angle()
		var a = velocity.angle() / (PI/4)
		a = wrapi(int(a), 0, 8)
		$AnimatedSprite.play(current_animation + str(a))
	else:
		$AnimatedSprite.stop()

func navigate():	# Define the next position to go to
	if path.size() > 0:
		velocity = global_position.direction_to(path[1]) * SPEED
		
		# If reached the destination, remove this point from path array
		if global_position == path[0]:
			path.pop_front()

func generate_path():	# It's obvious
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, false)
		#line2d.points = path

func move():
	velocity = move_and_slide(velocity)
