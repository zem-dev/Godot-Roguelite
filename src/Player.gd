extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

export (int) var speed
export (float) var bullet_speed
export (PackedScene) var bullet_scene

var can_shoot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	movement()
	shooting()
	
	# rotate gun to look at mouse
	$Gun.look_at(get_global_mouse_position())

func movement():
	# reset velocity after each frame
	var velocity = Vector2.ZERO
	
	# inputs to modify velocity
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	# normalize the velocity
	velocity = velocity.normalized()
	
	# move the player
	move_and_slide(velocity * speed)
	
	# play run animation if player is moving
	if(velocity.x != 0 or velocity.y != 0):
		$"Player Sprite".play("run")
	else:
		$"Player Sprite".play("idle")

func shooting():
		if Input.is_action_just_pressed("shoot"):
			# if player can shoot, set the bullet position and velocity
			if can_shoot:
				var bullet = bullet_scene.instance()
				bullet.linear_velocity = Vector2(bullet_speed, 0).rotated($Gun.rotation)
				bullet.position = $"Gun/Shoot Point".global_position
				get_parent().add_child(bullet)
				
				$Gun.play("shoot")
				
				can_shoot = false


func _on_Gun_animation_finished():
	if $Gun.animation == "shoot":
		$Gun.animation = "default"


func _on_Gun_Cooldown_timeout():
	can_shoot = true
