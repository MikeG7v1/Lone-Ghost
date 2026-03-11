#
#	Playable character main controller: only high level connections between 
#	character functionalities
#

extends CharacterBody2D

@onready var movement = $Movement
@onready var animation = $Animation
@onready var stats = $Stats

func _physics_process(delta):

	movement.handle_input()
	movement.apply_physics(delta)
	stats.update(delta, movement.is_floating)
	
	animation.update_animation(
		movement.direction,
		movement.is_floating,
		is_on_floor()
	)
