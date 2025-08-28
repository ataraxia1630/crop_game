class_name CollectableComponent extends Area2D

@export var collectable_name: String

func _on_body_entered(body: Player) -> void:
	print("Collected: ", collectable_name)
	InventoryManagement.add_collectable(collectable_name)
	get_parent().queue_free()
