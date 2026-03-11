extends ProgressBar

@export var stats : Node

func _process(_delta):
	if stats:
		value = stats.stamina
