extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	animate()
	

func _on_next_transitions() -> void:
	GameInputEvents.input_movement()
	GameInputEvents.input_tool()
	
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
		
	if GameInputEvents.do_use_tool():
		var config = DataTypes.TOOL_CONFIG.get(player.current_tool)
		if config:
			transition.emit(config["state_name"])


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()

func animate(): 
	var direction = player.player_direction
	if direction == Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	elif direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	elif direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")
	
