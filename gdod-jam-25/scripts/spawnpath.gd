extends PathFollow2D

@export var enemies : Array[PackedScene]

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn() -> void:
	
	var e = enemies.pick_random().instantiate()
	progress_ratio = randf_range(0,1)
	
	get_parent().add_child(e)
	e.global_position = global_position
