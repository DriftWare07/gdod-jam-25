extends Area2D



#have list of all current floors, in order
var floor_scene = load("res://scenes/level.tscn")
var floors = []

var current_floor = 0
var elevator_charge = 0.0

@export var audio : AudioStreamPlayer
#create floor on start
func _ready() -> void:
	Global.TileMapParent = self
	var f = floor_scene.instantiate()
	add_child(f)
	f.enabled = true
	floors.append(f)
	audio.reduce_reverb()


#keep track of charge level

#move to next floor when elevator is charged
func end_level():
	floors[current_floor].fade()
	Global.can_control = false
	$elevatorEffect.emitting = true
	audio.increase_reverb()
	$upgrade_menu.show()

#move to previous floor when player steps on fallen tile
func next_level():
	$upgrade_menu.hide()
	current_floor += 1
	elevator_charge = 0.0
	if current_floor > len(floors)-1:
		var f = floor_scene.instantiate()
		add_child(f)
		floors.append(f)
	print(floors)
	floors[current_floor].enabled = true
	$elevatorEffect.emitting = false
	
	Global.can_control = true
	audio.reduce_reverb()
	

func _on_body_entered(body: Node2D) -> void:
	if body is player and elevator_charge >= 100:
		end_level()
