extends Zombie
class_name Robot


var bullet = load("res://scenes/enemies/robot/robot_laser.tscn")

func _process(delta: float) -> void:
	
	look_at(Global.Player.global_position)
	leg_sprite.rotation = lerp_angle(leg_sprite.rotation, body_sprite.rotation, delta*5)
	
	
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !Global.Player: return
	var input = Vector2.ZERO
	
	if global_position.distance_to(Global.Player.global_position) > 128:
		input = Vector2(sign(Global.Player.global_position.x-global_position.x),sign(Global.Player.global_position.y-global_position.y))
	elif global_position.distance_to(Global.Player.global_position) < 96:
		input = -Vector2(sign(Global.Player.global_position.x-global_position.x),sign(Global.Player.global_position.y-global_position.y))
	
	
	
	leg_sprite.speed_scale = velocity.length()/50
	
	if input.length() > 0: velocity += input*accel
	else: velocity = velocity.lerp(Vector2.ZERO, decel*delta)
	
	velocity = velocity.clamp(Vector2(-speed,-speed), Vector2(speed,speed))
	move_and_slide()
	
	if not can_shoot: return
	
	
	
	

func attack():
	$blast.restart()
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.global_position = global_position
	b.look_at(Global.Player.global_position)
	print("laser!")

func dead():
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
