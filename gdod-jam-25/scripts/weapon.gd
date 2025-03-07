extends Resource
class_name Weapon


@export var weapon_name = "Gun"
@export var animation_name = "pistol"

@export var fire_delay = 0.5
@export var damage = 1
@export var max_ammo = 17

@export var spread = 4.0
@export var bullets = 1

@export var muzzle_locations : Array[Vector2]
@export var bullet_instance : PackedScene

@export var sound : AudioStream
