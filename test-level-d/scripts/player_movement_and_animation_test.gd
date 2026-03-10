extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var is_floating := false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stamina_bar = $"../UI/CanvasLayer/ProgressBar"

# ANIM
enum State {
	IDLE,
	START_WALKING,
	WALK,
	STOP_WALKING,
	FLOATING,
}
var current_state = State.IDLE
#ANIM


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_floating:
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Float mechanic
	if Input.is_action_pressed("floating"):
		is_floating = true
	if Input.is_action_just_released("floating"):
		is_floating = false
	
	if is_floating and not stamina_bar._has_min_stamina(): 
		is_floating = false

		
	# Get the input direction: -1, 0, 1.
	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#Apply movement
	if is_floating:
		velocity = Vector2.ZERO
		move_and_slide()
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	# ANIM:
	var moving:= Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") and not is_floating
	match current_state:
		
		State.IDLE:
			if Input.is_action_just_pressed("floating"):
				change_state(State.FLOATING)
			elif moving:
				change_state(State.START_WALKING)
		
		State.WALK:
			if Input.is_action_just_pressed("floating"):
				change_state(State.FLOATING)
			elif not moving:
				change_state(State.STOP_WALKING)
		
		State.FLOATING:
			if not is_floating:
				change_state(State.IDLE)
			
		State.START_WALKING:
			if is_floating:
				change_state(State.FLOATING)
			
		State.STOP_WALKING:
			if is_floating:
				change_state(State.FLOATING)
	

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
			
			
func _on_animated_sprite_2d_animation_finished() -> void:
	match current_state:
	
		State.START_WALKING:
			change_state(State.WALK)
		
		State.STOP_WALKING:
			change_state(State.IDLE)
