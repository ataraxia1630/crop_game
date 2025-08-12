class_name GameInputEvents

static var direction: Vector2
static var player_direction: Vector2= Vector2.DOWN
static var current_tool: DataTypes.Tools = DataTypes.Tools.None
static var is_using_tool: bool = false

static func input_movement() -> Vector2:
	if is_using_tool: # Không cho phép di chuyển khi đang dùng công cụ
		direction = Vector2.ZERO
		return direction
	
	if Input.is_action_pressed("walk_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("walk_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("walk_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("walk_down"):
		direction = Vector2.DOWN
	else: 
		player_direction = direction if direction != Vector2.ZERO else player_direction
		direction = Vector2.ZERO
	
	return direction
	
static func is_movement_input() -> bool:
	return direction != Vector2.ZERO

static func get_player_direction() -> Vector2:
	return player_direction
	
static func input_tool() -> DataTypes.Tools:
	if is_using_tool: # Giữ công cụ hiện tại khi đang sử dụng
		return current_tool
	if Input.is_action_just_pressed("chopping"):
		current_tool = DataTypes.Tools.Axe	
	elif Input.is_action_just_pressed("tilling"):
		current_tool = DataTypes.Tools.Hoe
	elif Input.is_action_just_pressed("watering"):
		current_tool = DataTypes.Tools.WateringCan
	else:
		current_tool = DataTypes.Tools.None
	
	return current_tool

static func do_use_tool() -> bool:
	return current_tool != DataTypes.Tools.None
	
static func reset_tool() -> void:
	current_tool = DataTypes.Tools.None
	is_using_tool = false
	
