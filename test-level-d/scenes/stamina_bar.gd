extends ProgressBar

@export var stamina_drain_rate := 60
@export var stamina_regen_rate := 100
@export var exhausted := false
@export var can_regen := true


func _process(delta):
	
	if Input.is_action_pressed("floating") and value >0 and not exhausted:
		value -= stamina_drain_rate * delta
	
		can_regen = false
		$Timer2.start()
	
	elif can_regen:
			value += stamina_regen_rate * delta
	
	
	value = clamp(value, 1 , max_value)


func _on_timer_2_timeout() -> void:
	if not Input.is_action_pressed("floating"):
		can_regen = true
	
