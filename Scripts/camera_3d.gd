extends Camera3D

@export var transition_time := 1.5
@export var ortho_to_persp_height := Vector3(0, 6.0, 0)    # how high camera should move transitioning to perspective mode
@export var persp_to_ortho_height := Vector3(0, 500.0, 0)   # how high camera should move transitioning to ortho mode

var tween: Tween

func _ready():
	tween = create_tween()
	pass
	
# Convert FOV <-> zoom factor
func fov_to_zoom(f: float) -> float:
	return 1.0 / tan(deg_to_rad(f) / 2.0)
func zoom_to_fov(z: float) -> float:
	return rad_to_deg(2.0 * atan(1.0 / z))

# Generic setter used by tween
func set_zoom_factor(z: float):
	fov = zoom_to_fov(z)

# Switch from perspective → orthogonal
func switch_to_orthogonal():
	if fov == 1.0:
		return
		
	var start_zoom = fov_to_zoom(fov)
	var end_zoom = fov_to_zoom(1.0)  # "flat" look

	tween.kill()
	tween = create_tween()

	# Animate FOV down and move camera up
	tween.tween_method(set_zoom_factor, start_zoom, end_zoom, transition_time)
	tween.set_parallel(true)
	tween.tween_property(self, "position", persp_to_ortho_height, transition_time)

# Switch from orthogonal → perspective
func switch_to_perspective():
	if fov == 75:
		return
		
	var start_zoom = fov_to_zoom(1.0)
	var end_zoom = fov_to_zoom(75.0)

	tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT_IN)
	
	tween.tween_method(set_zoom_factor, start_zoom, end_zoom, transition_time*0.25)
	tween.set_parallel(true)
	tween.tween_property(self, "position", ortho_to_persp_height, transition_time*0.25)


func toggle_perspective():
	if fov == 75:
		switch_to_orthogonal()
	else:
		switch_to_perspective()
