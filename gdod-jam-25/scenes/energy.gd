extends Node2D

var dead = false

func _process(delta: float) -> void:
	global_position = global_position.lerp(Vector2.ZERO, delta)
	if global_position.distance_to(Vector2.ZERO) < 4 and not dead:
		$AnimationPlayer.play("shrink")
		dead = true


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
