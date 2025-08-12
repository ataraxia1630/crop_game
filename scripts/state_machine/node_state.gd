class_name NodeState extends Node
# virtual base class giving all states a common interface

@warning_ignore("unused_signal")
signal transition 

# when the state become active
func _on_enter() -> void:
	pass

# when the state is about to change
func _on_exit() -> void:
	pass

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	pass

func _on_next_transitions() -> void:
	pass
