extends Control



@onready var main = $"../.."
@onready var hpbar = $healthPanel/healthbar
@onready var chargebar = $healthPanel/chargebar

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
	
	hpbar.value = lerp(hpbar.value, hp.health+1.0, delta*5)
	chargebar.value = lerp(chargebar.value, Global.TileMapParent.elevator_charge, delta*5)
