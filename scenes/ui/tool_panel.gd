extends PanelContainer
@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_hoe: Button = $MarginContainer/HBoxContainer/ToolHoe
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_wheat: Button = $MarginContainer/HBoxContainer/ToolWheat
@onready var tool_tomato: Button = $MarginContainer/HBoxContainer/ToolTomato



func _on_tool_axe_pressed() -> void:
	simulate_action_event("tool_axe")
	tool_axe.release_focus()

func _on_tool_hoe_pressed() -> void:
	simulate_action_event("tool_hoe")
	tool_hoe.release_focus()

func _on_tool_watering_can_pressed() -> void:
	simulate_action_event("tool_watering_can")
	tool_watering_can.release_focus()


func _on_tool_wheat_pressed() -> void:
	pass # Replace with function body.
	
func _on_tool_tomato_pressed() -> void:
	pass # Replace with function body.


func simulate_action_event(action_name: String):
	var action_event = InputEventAction.new()
	action_event.action = action_name  # Tên hành động trong Input Map
	action_event.pressed = true
	Input.parse_input_event(action_event)
	
	action_event = InputEventAction.new()
	action_event.action = action_name
	action_event.pressed = false
	Input.parse_input_event(action_event)
