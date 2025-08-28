extends Node

@export var item_name: String = ""
@export var label: Label

func _ready() -> void:
	InventoryManagement.inventory_changed.connect(on_inventory_changed)


func on_inventory_changed(changed_item_name: String):
	if changed_item_name == item_name:
		var inventory = InventoryManagement.inventory
		label.text = str(inventory[item_name])
