extends Area2D



#have list of all current floors, in order
var floor_scene = load("res://scenes/level.tscn")
var floors = []

var current_floor = 0
var elevator_charge = 0.0
var charge_max = 100.0
var timer = 0.0

@onready var loadbar = $elevator/loadBar
@onready var sfx = $elevator/chargefx

@export var audio : AudioStreamPlayer
#create floor on start
func _ready() -> void:
	Global.TileMapParent = self
	var f = floor_scene.instantiate()
	add_child(f)
	f.enabled = true
	floors.append(f)
	audio.reduce_reverb()
	Global.can_control = false


#keep track of charge level
func _physics_process(delta: float) -> void:
	if elevator_charge >= charge_max:
		loadbar.material.set_shader_parameter("value", 1.0-(timer/3.0))
	else:
		loadbar.material.set_shader_parameter("value", elevator_charge/charge_max)
	timer = clamp(timer, 0.0, 3.0)
	
	if elevator_charge < 100: return
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body is player:
			timer += delta
		
	timer -= delta/2
	
	
	if timer > 3.0:
		timer = 0.0
		end_level()


#move to next floor when elevator is charged
func end_level():
	elevator_charge = 0.0
	sfx.play()
	floors[current_floor].fade()
	Global.can_control = false
	$elevatorEffect.emitting = true
	audio.increase_reverb()
	$upgrade_menu.show()
	next_level()

#move to previous floor when player steps on fallen tile
func next_level():
	$upgrade_menu.hide()
	current_floor += 1
	
	if current_floor > len(floors)-1:
		var f = floor_scene.instantiate()
		add_child(f)
		floors.append(f)
	charge_max = 100+(current_floor*10)
	#floors[current_floor].enabled = true
	$elevatorEffect.emitting = false
	
	#Global.can_control = true
	audio.reduce_reverb()
	

#func _on_body_entered(body: Node2D) -> void:
	#if body is player and elevator_charge >= 100:
		#end_level()
