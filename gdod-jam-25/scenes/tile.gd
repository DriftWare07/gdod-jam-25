extends Node2D

@onready var hp = $Tile/Health_Component
@onready var shaker = $Tile/ShakerComponent2D
@onready var sprite = $Tile/Sprite2D

var dead = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hp_ratio = (hp.health/hp.max_health)
	shaker.intensity = 1-hp_ratio
	sprite.modulate = lerp(Color.GRAY, Color.WHITE, hp_ratio)
	
	if not dead: return
	
	var areas = $Tile.get_overlapping_areas()
	for area in areas:
		if area is hitbox:
			if !area.is_in_group("player"): area.kill()
			elif area.is_in_group("player") and Global.can_control:
				area.damage(15)
				area.get_parent().start_fall()


func _on_health_component_dead() -> void:
	if dead: return
	$AnimationPlayer.play("fall")
	dead = true
