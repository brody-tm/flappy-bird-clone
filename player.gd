extends CharacterBody2D

@export var jump_velocity : float = -450.0
@export var gravity : float = 1800

@onready var player_sprite = $AnimatedSprite2D
@onready var wing_fx = $WingFX
@onready var whoosh_fx = $WhooshFX

var collision

signal player_hit_pipe

func _ready():
	# Bird color
	player_sprite.play("blue")

func _physics_process(delta):
	if collision:
		emit_signal("player_hit_pipe")
	
	# Add the gravity.
	velocity.y += gravity * delta

	if velocity.y < 500 :   
		player_sprite.rotation = deg_to_rad(-25)
	elif velocity.y < 600:
		player_sprite.rotation = deg_to_rad(0)
	else:
		player_sprite.rotation = deg_to_rad(45)

	# Handle jump.
	if Input.is_action_just_pressed("m1"):
		if velocity.y > 1000:
			whoosh_fx.play()
		else:
			wing_fx.play()
			
		velocity.y = jump_velocity
		

	move_and_slide()
	
	for index in  get_slide_collision_count():
		collision = get_slide_collision(index) 

func _on_Player_body_entered(body):
	if body is Pipe:
		emit_signal("player_hit_pipe")
