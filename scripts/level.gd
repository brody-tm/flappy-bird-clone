extends Node2D

@onready var hit_fx = $HitFX
@onready var point_fx = $PointFX

var player_scene = preload("res://scenes/player.tscn")
var pipes_scene = preload("res://scenes/pipe_container.tscn")

func _ready():
	# Time of day
	add_background("NIGHT")
	setup_game()

func _process(delta):
	check_player_height()

func _on_Player_hit_pipe():
	player_death()

func setup_game():
	await display_message()
	initialize_player()
	initialize_pipes()
	
func add_background(time_of_day : String):
	var background = TextureRect.new()
	
	background.texture = load("res://flappy-bird-assets-master/sprites/background-"+time_of_day.to_lower()+".png")
	
	var base_marker = get_node("BaseMarker")
	
	add_child(background)

func display_message():
	remove_node("GameStart")
	
	var game_start = TextureRect.new()
	var game_start_marker = get_node("GameStartMarker")
	
	game_start.name = ("GameStart")
	game_start.texture = load("res://flappy-bird-assets-master/sprites/message.png")
	game_start.position = game_start_marker.position
	
	add_child(game_start)
	await get_tree().create_timer(1.5).timeout
	remove_node(game_start.name)

func initialize_player():
	remove_node("Player")

	var player = player_scene.instantiate()
	var spawn_point = get_node("SpawnPoint")
	player.position = spawn_point.position
	player.name = "Player"
	player.connect("player_hit_pipe", Callable(self, "_on_Player_hit_pipe"))
	add_child(player)

func initialize_pipes():
	remove_node("Pipes")

	var pipes = pipes_scene.instantiate()
	pipes.name = "Pipes"
	pipes.player_entered_pipes.connect(_on_player_entered_pipes)
	add_child(pipes)

func remove_node(node_name: String):
	if has_node(node_name):
		get_node(node_name).queue_free()

func check_player_height():
	if has_node("Player"):
		var player = get_node("Player")
		if player.position.y > 520:
			player_death()

func player_death():
	hit_fx.play()
	remove_node("Player")
	remove_node("Pipes")
	remove_node("GameOver")
	
	var game_over = TextureRect.new()
	var game_over_marker = get_node("GameOverMarker")
	
	####### ddd
	# $$$$$$$ ss 
	# %%%%%%% a
	
	game_over.name = ("GameOver")
	game_over.texture = load("res://flappy-bird-assets-master/sprites/gameover.png")
	game_over.position = game_over_marker.position
	
	add_child(game_over)
	await get_tree().create_timer(1.5).timeout
	remove_node(game_over.name)
	
	setup_game()

func _on_player_entered_pipes():
	point_fx.play()
