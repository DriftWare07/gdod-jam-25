extends Area2D

@export var speed = 300
# Called when the node enters the scene tree for the first time.
@export var damage = 1
@export var exclusion_group = "player"



func _physics_process(delta: float) -> void:
	move_local_x(speed*delta)


func _on_area_entered(area: Area2D) -> void:
	if area is hitbox and not area.is_in_group(exclusion_group):
		area.damage(damage)
		print(damage)
		queue_free()
