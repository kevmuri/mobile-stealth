extends Node2D

#16.2 is abr candidate as is 9.28
var angle_cone_of_vision = deg2rad(58.0)
var max_view_distance = 76.0
var angle_between_rays = deg2rad(6.44)

func _ready():
	generate_raycasts()

func generate_raycasts():
	var ray_count = angle_cone_of_vision / angle_between_rays
	
	for index in ray_count:
		var ray = RayCast2D.new()
		var angle = angle_between_rays * (index - ray_count / 2.0)
		ray.cast_to = Vector2.DOWN.rotated(angle) * max_view_distance
		add_child(ray)
		ray.add_exception($"../..")
		ray.enabled = true

#for debug only
func _process(delta):
	for ray in get_children():
		if ray.is_colliding() && ray.get_collider().name == "Player2D":
			$"../../AnimatedSprite".modulate = Color(2, 0, 0)
			print("Player Seen!")
			break
		else:
			$"../../AnimatedSprite".modulate = Color(0.5, 0, 0)
		pass
