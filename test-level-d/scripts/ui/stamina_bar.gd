extends ProgressBar

@export var stats : Node

func _process(delta):
	value = stats.stamina
