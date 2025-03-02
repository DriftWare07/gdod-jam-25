extends Area2D
class_name hitbox

@export var health_component : Health_Component

func damage(dmg):
	if health_component == null: return
	
	health_component.damage(dmg)
