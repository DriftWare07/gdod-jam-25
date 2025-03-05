extends TileMapLayer



func _ready() -> void:
	$AnimationPlayer.play("spawn")

func fade():
	collision_enabled == false
	$AnimationPlayer.play("down")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "down":
		queue_free()
	
	if anim_name == "spawn":
		Global.can_control = true
