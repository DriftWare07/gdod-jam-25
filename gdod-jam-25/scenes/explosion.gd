extends Node2D

var damage = false

signal done
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.animation_finished.connect(del)
	$AnimationPlayer.play("explode")
	

func _physics_process(delta: float) -> void:
	if damage: return
	var areas = $"blast radius".get_overlapping_areas()
	
	for area in areas:
		if area is hitbox:
			area.damage(1.8)
			print("hit")
	
	damage = true
	done.emit()

func del(string):
	queue_free()
