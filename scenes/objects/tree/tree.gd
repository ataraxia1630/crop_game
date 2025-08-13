extends Sprite2D
@onready var damage_component: DamageComponent = $DamageComponent
@onready var hurt_component: HurtComponent = $HurtComponent

var log_scene = preload("res://scenes/objects/collect_items/log.tscn")

func _ready() -> void:
	damage_component.max_damage_reached.connect(_on_max_dmg_reached)
	hurt_component.on_hurt.connect(_take_dmg)
	
func _on_max_dmg_reached():
	call_deferred("init_log_scene")
	print("max reached")
	queue_free()

func _take_dmg(hit_dmg):
	damage_component._apply_damage(hit_dmg)

func init_log_scene():
	var log_instance = log_scene.instantiate() as Node2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)
