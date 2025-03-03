extends CharacterBody2D
class_name player

@export var speed = 3000
@export var accel = 0.7
@export var decel = 1.3

@export var weapon : Weapon

@onready var body_sprite = $body
@onready var leg_sprite = $legs
@onready var gunsprite = $body/gunsprite
@onready var firetimer = $firetimer
@onready var bullet_sound = $bullet_sound

var can_shoot = true
var ammo = 1

func _ready() -> void:
	Global.Player = self

func _process(delta: float) -> void:
	body_sprite.look_at(get_global_mouse_position())
	leg_sprite.rotation = lerp_angle(leg_sprite.rotation, body_sprite.rotation, delta*5)
	update_weapons()
	
	var conv = Vector2i(get_viewport().get_mouse_position().x, get_viewport().get_mouse_position().y)
	var mouse_offset = (conv - get_viewport().size / 2)
	$Camera2D.position = $Camera2D.position.lerp( mouse_offset/5, delta)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var input = Input.get_vector("left","right","up","down").normalized()
	leg_sprite.speed_scale = velocity.length()/50
	
	if input.length() > 0: velocity += input*accel
	else: velocity = velocity.lerp(Vector2.ZERO, decel*delta)
	
	velocity = velocity.clamp(Vector2(-speed,-speed), Vector2(speed,speed))
	
	move_and_slide()

func pickup_weapon(new_weapon: Weapon):
	weapon = new_weapon
	ammo = weapon.max_ammo

func update_weapons():
	if weapon == null: return
	gunsprite.play(weapon.animation_name)
	
	if Input.is_action_pressed("shoot") and can_shoot:
		var i = weapon.bullet_instance.instantiate()
		$body/muzzle.position = weapon.muzzle_locations.pick_random()
		get_tree().root.add_child(i)
		i.global_position = $body/muzzle.global_position
		i.look_at(get_global_mouse_position())
		
		var sstream = AudioStreamPlayer.new()
		add_child(sstream)
		sstream.stream = weapon.sound
		sstream.bus = AudioServer.get_bus_name(2)
		sstream.play()
		sstream.finished.connect(sstream.queue_free)
		
		bullet_sound.play()
		
		ammo -= 1
		
		can_shoot = false
		firetimer.start(weapon.fire_delay)
		
	
	if ammo < 1:
		weapon = null
		gunsprite.play("default")


func _on_firetimer_timeout() -> void:
	can_shoot = true
