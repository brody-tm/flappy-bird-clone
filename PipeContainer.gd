extends Node2D

# Variables for pipe movement
@export var speed = 200
@export var min_y = 292
@export var max_y = 499
@export var reset_x = 175
@export var left_edge = -250

@onready var pipe = $Pipe

func _ready():
	randomize()

	for pipe in get_children():
		position_pipe_randomly(pipe)

func _process(delta):
	var bottom_pipe = get_child(0)
	bottom_pipe.position.x -= speed * delta

	if bottom_pipe.position.x < left_edge:
		position_pipe_randomly(bottom_pipe)

func position_pipe_randomly(pipe : Pipe):
	pipe.position.x = reset_x

	pipe.position.y = randi_range(min_y, max_y)
