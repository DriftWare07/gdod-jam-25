extends Node
class_name Health_Component

signal damaged
signal health_changed
signal dead

@export var host : Node
@export var delete_host_on_death = true


@export var max_health = 100.0
@export var health = 100.0
@export var iframes = 0.4
@export var regenerate = false


@export var reload_scene_on_death = false
@export var go_to_scene_on_death : PackedScene

var invframes = 0
var is_dead = false

func _process(delta: float) -> void:
	invframes -= delta
	health = clamp(health,0, max_health)
	if regenerate:
		health += (max_health/50)*delta


func damage(dmg,object=null):
	if invframes > 0: return
	if Global.can_control == false: return
	
	
	invframes = iframes
	health -= dmg
	damaged.emit()
	health_changed.emit()
	
	if  health < 1 and not is_dead:
		if reload_scene_on_death: get_tree().reload_current_scene()
		if go_to_scene_on_death != null: get_tree().change_scene_to_packed(go_to_scene_on_death)
		if delete_host_on_death: host.queue_free()
		is_dead = true
		dead.emit()
