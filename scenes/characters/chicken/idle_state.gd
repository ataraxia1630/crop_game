extends NodeState

@export var chicken: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var idling_timer: float = 5.0

var timer: Timer

var is_idle_state_timeout: bool = false

# when the state become active
func _on_enter() -> void:
	# set timer 
	timer = Timer.new()
	timer.wait_time = idling_timer
	timer.one_shot = true
	timer.timeout.connect(on_idle_state_timeout)
	add_child(timer)
	is_idle_state_timeout = false
	timer.start()
	
	# play animation
	animated_sprite_2d.play("idle")
	

# when the state is about to change
func _on_exit() -> void:
	animated_sprite_2d.stop()
	
	timer.stop()
	if timer:
		timer.queue_free()

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	#	emit the signal to turn into idle state
	if is_idle_state_timeout:
		transition.emit("walk")

func on_idle_state_timeout():
	is_idle_state_timeout = true
