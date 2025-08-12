class_name DataTypes

enum Tools {None, Axe, Hoe, WateringCan}

# Cau hinh cong cu: {tool: {state_name, anim_prefix, duration}}
const TOOL_CONFIG = {
	Tools.Axe: {
		"state_name": "Chopping",
		"anim_prefix": "chopping",
		"duration": 2.1
	},
	Tools.Hoe: {
		"state_name": "Tilling",
		"anim_prefix": "tilling",
		"duration": 2.1
	},
	Tools.WateringCan: {
		"state_name": "Watering",
		"anim_prefix": "watering",
		"duration": 0.8
	}
}
