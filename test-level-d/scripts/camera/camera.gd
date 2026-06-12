extends Camera2D

func _ready() -> void:
	EventBus.camera_limit_changed.connect(_on_camera_limit_changed)
	
func _on_camera_limit_changed(new_limits: Rect2i) -> void:
	limit_left = new_limits.position.x
	limit_top = new_limits.position.y
	limit_right = new_limits.end.x
	limit_bottom = new_limits.end.y
