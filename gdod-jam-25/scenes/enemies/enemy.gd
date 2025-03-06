extends CharacterBody2D
class_name Zombie


@export var speed = 3000
@export var accel = 0.7
@export var decel = 1.3

@export var score = 100

@onready var body_sprite = $body
@onready var leg_sprite = $legs

@export var hit_box : Area2D

var can_shoot = true
var ammo = 1

@export var charge_amount = 10


func _process(delta: float) -> void:
	if global_position.distance_to(Global.Player.global_position) > 128:
		look_at(global_position+velocity)
	else:
		look_at(Global.Player.global_position)
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
	
	if not can_shoot: return
	var bodies = hit_box.get_overlapping_areas()
	for body in bodies:
		if body.is_in_group("player"):
			body.damage(5)
			$groan.play()
			$slash.restart()
			$attackTimer.start()
			can_shoot = false
	
	
	

func attack():
	can_shoot = true

func dead():
	Global.current_score += score
	var explosion = load("res://scenes/explosion.tscn")
	var e = explosion.instantiate()
	
	Global.TileMapParent.elevator_charge += charge_amount
	get_tree().root.call_deferred("add_child",e)
	e.global_position = global_position
	
	var energy = load("res://scenes/energy.tscn")
	var nrg = energy.instantiate()
	get_tree().root.call_deferred("add_child",nrg)
	nrg.global_position = global_position
	
	e.done.connect(queue_free)
