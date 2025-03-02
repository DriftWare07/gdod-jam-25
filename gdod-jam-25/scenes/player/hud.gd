extends Control



@onready var main = $"../.."
@onready var hpbar = $healthPanel/healthbar

@onready var gunLabel = $weaponPanel/gun
@onready var ammoLabel = $weaponPanel/ammo

@export var hp : Health_Component



func _process(delta: float) -> void:
	if main.weapon == null:
		gunLabel.text = "Nothing"
		ammoLabel.text = "N/A"
	else:
		gunLabel.text = main.weapon.weapon_name
		ammoLabel.text = str(main.ammo)+"/"+str(main.weapon.max_ammo)
	
	hpbar.value = lerp(hpbar.value, hp.health+1, delta*5)
