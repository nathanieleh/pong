extends CharacterBody3D

signal location(ball_position: Vector3)
@export var speed = 15.0
@export var impact_acceleration = 1.01
var direction = Vector3(1, 0, 1)

func _on_ready() -> void:
	randomize()
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_class("CharacterBody3D"):
			velocity *= impact_acceleration
		velocity = velocity.bounce(collision.get_normal())
	location.emit(position)

func reset():
	position = Vector3(0, 0, 0)
	randomize()
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	velocity = direction * speed
