class_name ToolUsingState extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var tool: DataTypes.Tools = DataTypes.Tools.None
@onready var collision_shape_2d: CollisionShape2D = $"../../HitComponent/CollisionShape2D"

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
	
	collision_shape_2d.disabled = true
	
func _on_process(_delta: float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	animate()
	if collision_shape_2d and has_collision_position():
		collision_shape_2d.disabled = false

func _on_next_transitions() -> void:
	pass
	
func _on_exit() -> void:
	animated_sprite_2d.stop()
	if timer:
		timer.queue_free()
	GameInputEvents.reset_tool()
	if collision_shape_2d:
		collision_shape_2d.disabled = true

func animate() -> void:
	var config = DataTypes.TOOL_CONFIG[tool]
	var prefix = config["anim_prefix"]
	var direction = player.player_direction
	var collision_pos = Vector2.ZERO
	
	if direction == Vector2.UP:
		animated_sprite_2d.play(prefix + "_back")
		if has_collision_position():
			collision_pos = Vector2(config["collision_position"]["up"]["x"], config["collision_position"]["up"]["y"])
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play(prefix + "_front")
		if has_collision_position():
			collision_pos = Vector2(config["collision_position"]["down"]["x"], config["collision_position"]["down"]["y"])
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play(prefix + "_left")
		if has_collision_position():
			collision_pos = Vector2(config["collision_position"]["left"]["x"], config["collision_position"]["left"]["y"])
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play(prefix + "_right")
		if has_collision_position():
			collision_pos = Vector2(config["collision_position"]["right"]["x"], config["collision_position"]["right"]["y"])
			
	if collision_shape_2d and has_collision_position():
		collision_shape_2d.position = collision_pos

func _on_timer_timeout() -> void:
	var config = DataTypes.TOOL_CONFIG[tool]
	transition.emit("Idle")
	
func has_collision_position() -> bool:
	var config = DataTypes.TOOL_CONFIG.get(tool)
	return config.has("collision_position")
