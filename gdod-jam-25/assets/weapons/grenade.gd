extends RigidBody2D

var damage = 0
@export var speed = 100

func _ready() -> void:
	
	apply_impulse((get_global_mouse_position() - global_position).normalized()*speed)
