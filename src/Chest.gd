extends Area2D

func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("open")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "open":
		# TODO: give player item
		
		queue_free()
