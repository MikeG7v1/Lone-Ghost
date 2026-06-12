extends Area2D

@onready var collision_shape = $CollisionShape2D

func _on_body_entered(body: CharacterBody2D) -> void: 
	var shape = collision_shape.shape as RectangleShape2D
	var rect = Rect2(collision_shape.global_position - shape.size /2, shape.size)
	EventBus.camera_limit_changed.emit(rect)
