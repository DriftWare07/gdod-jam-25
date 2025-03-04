extends Node2D

@export var weapon_drops : Array[Weapon]

var selected_weapon : Weapon
var is_visible = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	rando()
	position = Vector2(randi_range(-100,100),randi_range(-100,100))

func _process(delta: float) -> void:
	if visible: position += (Global.Player.global_position - global_position)*delta/10

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
		$reloadsfx.play()
		hide()
		position = Vector2(randi_range(-100,100),randi_range(-100,100))
		$Timer.start()
