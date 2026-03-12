extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var movement = body.get_node("Movement")
		movement.can_climb = true
		movement.current_ladder = self

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		var movement = body.get_node("Movement")
		movement.can_climb = false
		movement.current_ladder = null
