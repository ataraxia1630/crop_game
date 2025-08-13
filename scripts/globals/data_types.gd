class_name DataTypes

enum Tools {None, Axe, Hoe, WateringCan}

# Cau hinh cong cu: {tool: {state_name, anim_prefix, duration}}
const TOOL_CONFIG = {
	Tools.Axe: {
		"state_name": "Chopping",
		"anim_prefix": "chopping",
		"duration": 0.8,
		"hit_damage": 2,
		"collision_position": 
		{
			"left": {"x": -9, "y": 0},
			"right": {"x": 9, "y": 0},
			"up": {"x": 0, "y": -20},
			"down": {"x": 0, "y": 2}
		}
	},
	Tools.Hoe: {
		"state_name": "Tilling",
		"anim_prefix": "tilling",
		"duration": 0.8,
		"hit_damage": 3,
		"collision_position": 
		{
			"left": {"x": -11, "y": 0},
			"right": {"x": 11, "y": 0},
			"up": {"x": 3, "y": -5},
			"down": {"x": -3, "y": -3}
		}
	},
	Tools.WateringCan: {
		"state_name": "Watering",
		"anim_prefix": "watering",
		"duration": 0.8,
		"collision_position": 
		{
			"left": {"x": -21, "y": 0},
			"right": {"x": 21, "y": 0},
			"up": {"x": 6, "y": -10},
			"down": {"x": -6, "y": 4}
		}
	},
}

enum Trees {Normal, Big}

const TREE_CONFIG = {
	Trees.Normal: {
		"hp": 1,
	},
	Trees.Big: {
		"hp": 3,
	}
}
