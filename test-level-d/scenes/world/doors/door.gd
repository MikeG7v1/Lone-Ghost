extends Node2D

@export var required_key_id: String = "dupa"
@export var consume_key: bool = true

@onready var body_collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
# @onready var prompt: Label = $Prompt

var is_open = false
var player_in_range = null


func _unhandled_input(event: InputEvent) -> void: 
	if is_open or player_in_range == null:
		return
	if event.is_action_pressed("interact"):
		try_open()
		get_viewport().set_input_as_handled()

func try_open():
	var inventory = player_in_range.get_node("Inventory")
	if inventory.has_key(required_key_id):
		if consume_key:
			inventory.remove_key(required_key_id)
		open()	
	#else:
		#prompt.text = "U need a key"
	
func open():
	is_open = true
	body_collision.set_deferred("disabled", true)
	sprite.hide() 

func _on_door_area_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			player_in_range = body
			#prompt.visible = not is_open

func _on_door_area_body_exited(body: Node2D) -> void:
		if body == player_in_range:
			player_in_range = null
			#prompt.visible = false
