extends Sprite2D
@onready var damage_component: DamageComponent = $DamageComponent
@onready var hurt_component: HurtComponent = $HurtComponent

var log_scene = preload("res://scenes/objects/collect_items/log.tscn")

@export var shake_duration: float = 0.8
@export var kill_duration: float = 1.0
@export var last_visible_duration: float = 0.6

func _ready() -> void:
	damage_component.max_damage_reached.connect(_on_max_dmg_reached)
	hurt_component.on_hurt.connect(_take_dmg)
	
	if shake_duration >= kill_duration:
		print("shake_duration should be shorter than kill_duration")
		shake_duration = kill_duration - 0.2
	if last_visible_duration >= kill_duration:
		print("last_visible_duration should be shorter or than kill_duration")
		last_visible_duration = kill_duration - 0.2
	
func _on_max_dmg_reached():
	call_deferred("init_log_scene")
	print("max reached")
	await get_tree().create_timer(kill_duration).timeout
	print("timeout: max reached ", kill_duration)
	queue_free()

func _take_dmg(hit_dmg):
	damage_component._apply_damage(hit_dmg)
	material.set_shader_parameter("shake_intensity", 1.0)
	await get_tree().create_timer(shake_duration).timeout
	print("timeout: take dmg ", shake_duration)
	material.set_shader_parameter("shake_intensity", 0.0)
	
	
func init_log_scene():
	print("init log called")
	await get_tree().create_timer(last_visible_duration).timeout
	print("timeout: init log ", last_visible_duration)
	visible = false
	var log_instance = log_scene.instantiate() as Node2D
	print("log init")
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)
