extends CharacterBody3D


@export var speed = 5.0
var direction = Vector3(1, 0, 1)

func _on_ready() -> void:
	randomize()
	direction = Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	velocity = direction * speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
