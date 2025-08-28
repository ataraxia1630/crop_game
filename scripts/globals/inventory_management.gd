extends Node

signal inventory_changed(item_name: String)

var inventory: Dictionary = Dictionary()

func add_collectable(collectable_name: String):
	inventory.get_or_add(collectable_name)
	
	if inventory[collectable_name] == null:
		inventory[collectable_name] = 1
	else: 
		inventory[collectable_name] += 1
	
	inventory_changed.emit(collectable_name)
