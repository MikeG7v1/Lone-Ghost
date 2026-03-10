extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var is_floating := false
var is_moving := false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stamina_bar = $"../ProgressBar"

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
		
	# Animations:
	
	#Floating 
	#if is_floating: 
	#	animated_sprite.play("floating")
	
	#Jumping
	#-------------
	
	
	#Start walking
	#if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right") and is_on_floor():
	#	animated_sprite.play("start_walking")
	
	#Stop walking
	#if Input.is_action_just_released("move_left") or Input.is_action_just_released("move_right") and is_on_floor():
	#	animated_sprite.play("stop_walking")
	
	
	
	#Walk
	#if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") and is_on_floor():
	#	animated_sprite.play("walk")
		
			#Idle
	#elif direction == 0: 
	#	animated_sprite.play("idle")

	move_and_slide()
