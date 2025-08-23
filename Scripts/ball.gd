extends CharacterBody3D

signal location(ball_position: Vector3)
@export var speed = 15.0
@export var impact_acceleration = 1.01
var direction = Vector3(1, 0, 1)

func _on_ready() -> void:
	randomize()
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-0.6, 0.6)).normalized()
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var final_direction = velocity.bounce(collision.get_normal()) # initial bounce
		var final_length = velocity.length() # initial length
		var collider = collision.get_collider()
		if collider.is_class("CharacterBody3D"):
			var bias = Vector3(0, 0, collider.position.z - position.z) # impact from paddle
			final_direction += bias*10
			final_length *= impact_acceleration
		velocity = final_direction.normalized() * final_length
	location.emit(position)

func reset():
	position = Vector3(0, 0, 0)
	randomize()
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-0.6, 0.6)).normalized()
	velocity = direction * speed
