#
#	Script dedicated to player animation
#

extends Node

@onready var animated_sprite : AnimatedSprite2D = $"../AnimatedSprite2D"

enum State {
	IDLE,
	START_WALKING,
	WALK,
	STOP_WALKING,
	FLOATING
}

var current_state = State.IDLE

func change_state(new_state):
	if current_state == new_state:
		return
	
	current_state = new_state
	
	match current_state:
		State.IDLE:
			animated_sprite.play("idle")
		
		State.START_WALKING:
			animated_sprite.play("start_walking")
		
		State.WALK:
			animated_sprite.play("walk")
		
		State.STOP_WALKING:
			animated_sprite.play("stop_walking")
		
		State.FLOATING:
			animated_sprite.play("floating")
			

func update_animation(direction, floating, on_floor):

	var moving = direction != 0 and not floating

	match current_state:

		State.IDLE:
			if floating:
				change_state(State.FLOATING)
			elif moving:
				change_state(State.START_WALKING)

		State.WALK:
			if floating:
				change_state(State.FLOATING)
			elif not moving:
				change_state(State.STOP_WALKING)

		State.FLOATING:
			if not floating:
				change_state(State.IDLE)
