extends CharacterBody2D
class_name Enemy


@export var speed = 3000
@export var accel = 0.7
@export var decel = 1.3



@onready var body_sprite = $body
@onready var leg_sprite = $legs



var can_shoot = true
var ammo = 1



func _process(delta: float) -> void:
	body_sprite.look_at(position+velocity)
	leg_sprite.rotation = lerp_angle(leg_sprite.rotation, body_sprite.rotation, delta*5)
	
	
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !Global.Player: return
	
	var input = Vector2(sign(Global.Player.global_position.x-global_position.x),sign(Global.Player.global_position.y-global_position.y))
	leg_sprite.speed_scale = velocity.length()/50
	
	if input.length() > 0: velocity += input*accel
	else: velocity = velocity.lerp(Vector2.ZERO, decel*delta)
	
	velocity = velocity.clamp(Vector2(-speed,-speed), Vector2(speed,speed))
	
	move_and_slide()

func dead():
	var explosion = load("res://scenes/explosion.tscn")
	var e = explosion.instantiate()
	
	get_tree().root.call_deferred("add_child",e)
	e.global_position = global_position
	e.done.connect(queue_free)
