class_name CollectableComponent extends Area2D

func _on_body_entered(body: Node2D) -> void:
	get_parent().queue_free()
