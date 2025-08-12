class_name Player extends CharacterBody2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None

var player_direction: Vector2 = Vector2.DOWN

func _physics_process(delta: float) -> void:
	var new_direction = GameInputEvents.get_player_direction()
	if new_direction != Vector2.ZERO: # Chỉ cập nhật nếu có input di chuyển
		player_direction = new_direction
	current_tool = GameInputEvents.input_tool()
