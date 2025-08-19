extends NodeState

@export var chicken: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var walking_timer: float = 10.0
@export var navigation_agent_2d: NavigationAgent2D

var timer: Timer
var is_walk_state_timeout: bool = false

var speed: float
var min_speed: float = 5.0
var max_speed: float = 10.0

func _ready() -> void:
	navigation_agent_2d.velocity_computed.connect(on_safe_velocity_computed)
	
# when the state become active
func _on_enter() -> void:
#	set timer
	timer = Timer.new()
	timer.wait_time = walking_timer + randf_range(-3, 5)
	timer.one_shot = true;
	timer.timeout.connect(on_walk_state_timeout)
	add_child(timer)
	is_walk_state_timeout = false
	timer.start()
	
	animated_sprite_2d.play("walk")
	
	set_new_target()
	set_new_speed()

# when the state is about to change
func _on_exit() -> void:
	animated_sprite_2d.stop()
	
	timer.stop()
	if timer:
		timer.queue_free()
		
func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	var target_pos = navigation_agent_2d.get_next_path_position()
	var direction = chicken.global_position.direction_to(target_pos)
	animated_sprite_2d.flip_h = direction.x < 0
	
	var velocity: Vector2 = direction * speed
	if navigation_agent_2d.avoidance_enabled:
		# the velocity be calculated => then call safe velocity
		navigation_agent_2d.velocity = velocity
	else:
		chicken.velocity = velocity
		chicken.move_and_slide()

func _on_next_transitions() -> void:
	#	emit the signal to turn into idle state
	if is_walk_state_timeout or navigation_agent_2d.is_navigation_finished():
		transition.emit("idle")

func on_walk_state_timeout():
	is_walk_state_timeout = true
	
func on_navigation_finished():
	set_new_target()
	set_new_speed()
	
func set_new_target():
	var target: Vector2 = NavigationServer2D.map_get_random_point(navigation_agent_2d.get_navigation_map(), navigation_agent_2d.navigation_layers, false)
	navigation_agent_2d.target_position = target

func set_new_speed():
	speed = randf_range(min_speed, max_speed)

func on_safe_velocity_computed(safe_velocity: Vector2):
	chicken.velocity = safe_velocity
	chicken.move_and_slide()
