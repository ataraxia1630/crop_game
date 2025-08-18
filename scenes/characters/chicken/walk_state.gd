extends NodeState

@export var chicken: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var walking_timer: float = 10.0

var timer: Timer

var is_walk_state_timeout: bool = false

# when the state become active
func _on_enter() -> void:
#	set timer
	timer = Timer.new()
	timer.wait_time = walking_timer
	timer.one_shot = true;
	timer.timeout.connect(on_walk_state_timeout)
	add_child(timer)
	is_walk_state_timeout = false
	timer.start()
	
	animated_sprite_2d.play("walk")
	

# when the state is about to change
func _on_exit() -> void:
	animated_sprite_2d.stop()
	
	timer.stop()
	if timer:
		timer.queue_free()
		
func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	chicken.velocity.x = RandomNumberGenerator.new().randf_range(10, 15)
	chicken.move_and_slide()

func _on_next_transitions() -> void:
	#	emit the signal to turn into idle state
	if is_walk_state_timeout:
		transition.emit("idle")

func on_walk_state_timeout():
	is_walk_state_timeout = true
