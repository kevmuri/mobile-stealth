extends KinematicBody2D

var coneEntered = 0
var playerCaught = 0

#for debug only
func _process(delta):
	look_at(get_global_mouse_position())
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().name == "Player2D" && coneEntered == 1:
			playerCaught = 1
		else:
			playerCaught = 0
	else:
		playerCaught = 0
	if playerCaught == 1:
		modulate = Color(2, 0, 0)
	else:
		modulate = Color(1.1, 0, 0)

func _on_sight_body_entered(body):
	if body.name == "Player2D":
		coneEntered = 1

func _on_sight_body_exited(body):
	if body.name == "Player2D":
		coneEntered = 0
