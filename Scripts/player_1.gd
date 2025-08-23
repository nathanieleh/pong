extends Agent

class_name Player

var momentum = 0

func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("up", "down")
	if direction:
		momentum = move_toward(momentum, direction * SPEED, SPEED*.05)
		velocity.z = momentum
	else:
		velocity.z = move_toward(velocity.z, 0, SPEED*.05)
		momentum = 0

	velocity.x = 0
	move_and_slide()
	position.x = 6.5
