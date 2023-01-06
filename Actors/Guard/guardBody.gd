extends KinematicBody2D

var speed = 90  # speed in pixels/sec
var velocity = Vector2.ZERO

var path: Array = []
var levelNavigation: Navigation2D = null
var player = null

var origin = Vector2(global_position)

onready var line2d = $Line2D

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	if tree.has_group("LevelNavigation"):
		levelNavigation = tree.get_nodes_in_group("LevelNavigation")[0]
	if tree.has_group("Player2D"):
		player = tree.get_nodes_in_group("Player2D")[0]

func _physics_process(delta):
	line2d.global_position = Vector2.ZERO
	var current_animation = "walk"
	#generate_path()
	navigate()
	velocity = move_and_slide(velocity)
	
	#for debug only
	#get_input()
	
	if velocity.length() != 0:
		$Light2D.rotation = velocity.angle()
		$WeakPoint.rotation = velocity.angle()
		var a = velocity.angle() / (PI/4)
		a = wrapi(int(a), 0, 8)
		$AnimatedSprite.play(current_animation + str(a))
	else:
		$AnimatedSprite.stop()

func _process(delta):
	#var move_distance = speed * delta
	#move_along_path(move_distance)
	pass

func navigate():
	if path.size() > 0:
		velocity = global_position.direction_to((path[1] * speed))
		if global_position == path[0]:
			path.pop_front()

func generate_path():
	if levelNavigation != null and player != null:
		path = levelNavigation.get_simple_path(global_position, player.global_position, true)
		line2d.points = path

#For debug only
#func get_input():
#	velocity = Vector2.ZERO
#	if Input.is_action_pressed('debug_right'):
#		velocity.x += 1
#	if Input.is_action_pressed('debug_left'):
#		velocity.x -= 1
#	if Input.is_action_pressed('debug_down'):
#		velocity.y += 1
#	if Input.is_action_pressed('debug_up'):
#		velocity.y -= 1
#	# Make sure diagonal movement isn't faster
#	velocity = velocity.normalized() * speed

