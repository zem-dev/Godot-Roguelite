extends RigidBody2D

func _on_Bullet_body_entered(body):
	# destroy the bullet when it collides
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	# destroy the bullet when it leaves the screen
	queue_free()
