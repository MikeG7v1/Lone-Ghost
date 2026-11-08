extends Area2D

@export var key_id: String = "dupa"
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.get_node("Inventory").add_key(key_id)
		queue_free()
		
