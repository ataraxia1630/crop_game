class_name HitComponent extends Area2D

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None
@export var hit_damage: int = 0
@export var player: Player

func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func _ready() -> void:
	if current_tool == DataTypes.Tools.None || !DataTypes.TOOL_CONFIG[current_tool]:
		hit_damage = 0
	else: 
		hit_damage = DataTypes.TOOL_CONFIG[current_tool]["hit_damage"]

func _physics_process(delta: float) -> void:
	current_tool = player.current_tool
	if current_tool == DataTypes.Tools.None || !DataTypes.TOOL_CONFIG[current_tool]:
		hit_damage = 0
	else: 
		hit_damage = DataTypes.TOOL_CONFIG[current_tool]["hit_damage"]
