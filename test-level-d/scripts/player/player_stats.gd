extends Node

var stamina := 100
var max_stamina := 100

func has_stamina(amount):
	return stamina >= amount
	
@export var drain_rate := 60
@export var regen_rate := 100

var regen_enabled := true

func update(delta, is_floating):

	if is_floating and stamina > 0:
		stamina -= drain_rate * delta
	else:
		stamina += regen_rate * delta

	stamina = clamp(stamina, 0, max_stamina)
