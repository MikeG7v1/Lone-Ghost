#
#	Script dedicated to player movement of all sorts and kinds: 
#	default, jumps, other skills included
#

# imports
extends Node
@onready var stats = $"../Stats"

# global variables 
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var is_floating := false
var direction := 0

var player : CharacterBody2D


# functions
func _ready():
	player = get_parent() as CharacterBody2D

func handle_input():

	direction = Input.get_axis("move_left","move_right")

	# FLOATING INPUT LOGIC
	if Input.is_action_just_pressed("floating") and stats.stamina >= 10:
		is_floating = true
	# Stop floating when stamina empty
	if is_floating and stats.stamina <= 0:
		is_floating = false
	# Stop floating when button released
	if Input.is_action_just_released("floating"):
		is_floating = false

	#JUMPING INPUT LOGIC
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY


func apply_physics(delta):

	if not player.is_on_floor() and not is_floating:
		player.velocity += player.get_gravity() * delta
	
	if is_floating:
		player.velocity = Vector2.ZERO
		
	if direction:
		player.velocity.x = direction * SPEED
		
	else:
		player.velocity.x = move_toward(player.velocity.x,0,SPEED)

	player.move_and_slide()
