extends Node2D

@export var weapon_drops : Array[Weapon]

var selected_weapon : Weapon
var is_visible = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	rando()

func appear():
	rando()
	is_visible = true
	show()

func rando():
	
	selected_weapon = weapon_drops.pick_random()
	$AnimatedSprite2D.play(selected_weapon.animation_name)

func _on_body_entered(body: Node2D) -> void:
	if body is player and is_visible:
		body.pickup_weapon(selected_weapon)
		is_visible = false
		hide()
		$Timer.start()
