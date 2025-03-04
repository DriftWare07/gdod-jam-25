extends AudioStreamPlayer

@export var room_size_max = 0.5
var room_size = room_size_max

var reverb
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reverb = AudioServer.get_bus_effect(1,0)
	
	

func _process(delta: float) -> void:
	reverb.room_size = room_size
	reverb.damping = room_size
	
	


func reduce_reverb():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self,"room_size", 0, 1.5)

func increase_reverb():
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self,"room_size", room_size_max, 1.5)
