extends PathFollow2D

@export var enemies : Array[PackedScene]

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawn() -> void:
	
	var amount = randi_range(1,1)
	for i in range(amount):
		var e = enemies.pick_random().instantiate()
		progress_ratio = randf_range(0,1)
		
		$blood.restart()
		$teleport.play()
		get_parent().add_child(e)
		e.global_position = global_position
		
		$spawntimer.wait_time = 2.5 - (Global.TileMapParent.current_floor/5)
		$spawntimer.wait_time = clamp($spawntimer.wait_time, 1.0, 5.0)
