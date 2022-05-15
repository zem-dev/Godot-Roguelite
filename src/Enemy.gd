extends RigidBody2D

export (int) var speed 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# constantly chase the player
	linear_velocity = Vector2(speed, 0).rotated(get_angle_to($"/root/Main/Player".position))
