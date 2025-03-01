extends CharacterBody2D


@export var speed = 3000
@export var accel = 0.7
@export var decel = 1.3

@onready var body_sprite = $body
@onready var leg_sprite = $legs

func _process(delta: float) -> void:
	body_sprite.look_at(get_global_mouse_position())
	leg_sprite.rotation = lerp_angle(leg_sprite.rotation, body_sprite.rotation, delta*5)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var input = Input.get_vector("left","right","up","down").normalized()
	
	if input.length() > 0: velocity += input*accel
	else: velocity = velocity.lerp(Vector2.ZERO, decel*delta)
	
	
	
	move_and_slide()
