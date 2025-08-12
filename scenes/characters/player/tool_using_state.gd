class_name ToolUsingState extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var tool: DataTypes.Tools = DataTypes.Tools.None

var timer: Timer

func _on_enter() -> void:
	if tool == DataTypes.Tools.None:
		transition.emit("Idle")
		return
		
	GameInputEvents.is_using_tool = true;
	var config = DataTypes.TOOL_CONFIG[tool]
	
	# Tao Timer node
	timer = Timer.new()
	timer.wait_time = config["duration"]
	timer.one_shot = true;
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	
	animate()
	
func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	animate()

func _on_next_transitions() -> void:
	pass
	
func _on_exit() -> void:
	animated_sprite_2d.stop()
	if timer:
		timer.queue_free()
	GameInputEvents.reset_tool()

func animate() -> void:
	var config = DataTypes.TOOL_CONFIG[tool]
	var prefix = config["anim_prefix"]
	var direction = player.player_direction
	if direction == Vector2.UP:
		animated_sprite_2d.play(prefix + "_back")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play(prefix + "_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play(prefix + "_left")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play(prefix + "_right")

func _on_timer_timeout() -> void:
	var config = DataTypes.TOOL_CONFIG[tool]
	transition.emit("Idle")
