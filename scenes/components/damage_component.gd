class_name DamageComponent extends Node2D

@export var hurt_component: HurtComponent
@export var hp: int = 1

signal max_damage_reached

func _ready() -> void:
	pass
	
func _apply_damage(dmg: int): 
	hp -= dmg
	if hp <= 0:
		max_damage_reached.emit()
	
