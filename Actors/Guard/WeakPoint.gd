extends Area2D


func _on_WeakPoint_body_entered(body):
	if body.name == "Player2D":
		print("Entered")
