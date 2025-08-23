extends CharacterBody3D


@export var SPEED = 5.0

func _on_ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	velocity.x = 0
	position.x = -6.5


func _on_ball_location(ball_position: Vector3) -> void:
	var z_distance = ball_position.z - position.z
	velocity.z = z_distance * SPEED
	move_and_slide()
