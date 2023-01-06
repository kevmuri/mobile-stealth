extends KinematicBody2D

var speed = 100  # speed in pixels/sec
var velocity = Vector2.ZERO

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	var current_animation = "walk"
	get_input()

	if velocity.length() != 0:
		var a = velocity.angle() / (PI/4)
		a = wrapi(int(a), 0, 8)
		$AnimatedSprite.play(current_animation + str(a))
	else:
		$AnimatedSprite.stop()
	velocity = move_and_slide(velocity)
