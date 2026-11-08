extends Node

signal key_added(key_id: String)
signal key_removed(key_id: String)

var keys: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func add_key(key_id: String):
	keys.append(key_id)
	key_added.emit(key_id)
	
func has_key(key_id: String):
	return key_id in keys
	
func remove_key(key_id: String):
	keys.erase(key_id)
	key_removed.emit(key_id)
	
