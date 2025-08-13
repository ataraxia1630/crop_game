class_name HurtComponent extends Area2D

@export var tool: DataTypes.Tools = DataTypes.Tools.None

signal on_hurt

func _on_area_entered(area: Area2D) -> void:
	var hit_component = area as HitComponent
	
	if hit_component.current_tool == tool:
		var hit_damage = hit_component.hit_damage
		print("Get hit: ", hit_damage)
		on_hurt.emit(hit_damage)
