extends Node3D

@onready var timer: Timer = $Timer

var player_score = 0
var opponent_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_ball_location(ball_position: Vector3) -> void:
	if abs(ball_position.x) > 6.5 and timer.is_stopped():
		if ball_position.x < 0:
			player_score += 1
		else:
			opponent_score += 1
		$Score.text = str(opponent_score) + " : " + str(player_score)
		Engine.time_scale = 0.05
		timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	$Ball.reset()
	$Camera3D.toggle_perspective()
