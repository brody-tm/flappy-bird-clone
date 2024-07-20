extends Area2D

signal player_entered
signal player_exited

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("player_entered", body)

func _on_body_exited(body):
	if body.name == "Player":
		emit_signal("player_exited", body)
