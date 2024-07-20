class_name Pipe

extends Node2D

signal player_entered_pipes

@onready var pipe_sprite_1 : Sprite2D = $TopPipe
@onready var pipe_sprite_2 : Sprite2D = $BottomPipe

func _ready():
	# Pipe color (default green)
	load_pipe_sprites("red", "red")

func load_pipe_sprites(color_1 : String, color_2 : String):
	pipe_sprite_1.texture = load("res://flappy-bird-assets-master/sprites/pipe-" + color_1 + ".png")
	pipe_sprite_2.texture = load("res://flappy-bird-assets-master/sprites/pipe-" + color_2 + ".png")


func _on_area_2d_body_entered(body):
	emit_signal("player_entered_pipes")
