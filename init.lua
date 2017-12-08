local christmas_decor = {}

-- Candycane Blocks
minetest.register_node("christmas_decor:candycane_block", {
	description = "Candycane Block",
	tiles = {"candycane_block.png", "candycane_block.png", "candycane_block.png", "candycane_block.png", "candycane_block.png^[transformFX", "candycane_block.png^[transformFX"},
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default.node_sound_stone_defaults(),
})

stairs.register_all("candycane", "christmas_decor:candycane_block",
	{snappy = 3},
	{"candycane_block.png", "candycane_block.png", "candycane_block.png", "candycane_block.png", "candycane_block.png^[transformFX", "candycane_block.png^[transformFX"},
	"Candycane",
stairs.stone)

minetest.register_node("christmas_decor:candycane", {
	description = "Candycane (placeable)",
	drawtype = "mesh",
	mesh = "candycane.obj",
	tiles = {"candycane.png"},
	inventory_image = "inv_candycane.png",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3},
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default.node_sound_stone_defaults(),	
})

-- Frosting Blocks
minetest.register_node("christmas_decor:frosting_block", {
	description = "Frosting Block",
	tiles = {"frosting.png"},
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

stairs.register_all("frosting_block", "christmas_decor:frosting_block",
	{snappy = 3},
	{"frosting.png"},
	"Frosting",
stairs.leaves)

-- Garland
minetest.register_node("christmas_decor:garland", {
	description = "Garland",
	tiles = {"garland.png"},
	inventory_image = "garland.png",
	wield_image = "garland.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = true,
	drawtype = "signlike",
	paramtype = "light",
	paramtype2 = "wallmounted",
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("christmas_decor:garland_lights", {
	description = "Garland with Lights",
	tiles = {
		{
			image = "garland_lights.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 16
			},
		}
	},
	inventory_image = "inv_garland_lights.png",
	wield_image = "inv_garland_lights.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = true,
	drawtype = "signlike",
	paramtype = "light",
	light_source = 8,
	paramtype2 = "wallmounted",
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	output = "christmas_decor:garland 3",
	recipe = {
		{"default:pine_needles", "default:pine_needles", "default:pine_needles"},
	},
})

minetest.register_craft({
	output = "christmas_decor:garland_lights",
	type = "shapeless",
	recipe = {"christmas_decor:garland", "christmas_decor:led_white", "christmas_decor:led_white", "christmas_decor:led_white"},
})

-- Lights
minetest.register_craftitem("christmas_decor:led_rgb", {
	description = "RGB Led Light",
	inventory_image = "led_rgb.png",
})

minetest.register_craftitem("christmas_decor:led_white", {
	description = "White Led Light",
	inventory_image = "led_white.png",
})

minetest.register_craft({
	output = "christmas_decor:led_rgb",
	type = "shapeless",
	recipe = {"christmas_decor:led_white", "dye:green", "dye:blue", "dye:red"},
})

minetest.register_craft({
	output = "christmas_decor:led_white 8",
	recipe = {
		{"default:glass"},
		{"homedecor:power_crystal"},
		{"homedecor:plastic_sheeting"},
	},
})

minetest.register_craftitem("christmas_decor:wire", {
	description = "Wire",
	inventory_image = "wire.png",
})

minetest.register_craft({
	output = "christmas_decor:wire 16",
	recipe = {
		{"homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting"},
		{"homedecor:copper_strip", "homedecor:copper_strip", "homedecor:copper_strip"},
		{"homedecor:plastic_sheeting", "homedecor:plastic_sheeting", "homedecor:plastic_sheeting"},
	},
})

local function register_lights(desc, nodename, aspect, length, def, craftitem, original_def)
	minetest.register_node("christmas_decor:lights_"..nodename, {
		description = desc.." Christmas Lights",
		tiles = {
			{
				image = "lights_"..nodename..".png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = aspect,
					aspect_h = aspect,
					length = length
				},
			}
		},
		inventory_image = "inv_lights_"..nodename..".png",
		wield_image = "inv_lights_"..nodename..".png",
		sunlight_propagates = true,
		walkable = false,
		climbable = false,
		is_ground_content = false,
		selection_box = {
			type = "wallmounted",
		},
		legacy_wallmounted = true,
		use_texture_alpha = true,
		drawtype = "signlike",
		paramtype = "light",
		light_source = 10,
		paramtype2 = "wallmounted",
		groups = {snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
	})
	
	xpanes.register_pane("lights_"..nodename.."_pane", {
		description = desc.." Christmas Lights (pane)",
		textures = {
			{
				image = "lights_"..nodename..".png^[transformFX",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = aspect,
					aspect_h = aspect,
					length = length
				},
			},
			{
				image = "lights_"..nodename..".png^[transformFX",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = aspect,
					aspect_h = aspect,
					length = length
				},
			}, "xpanes_space.png"

		},
		use_texture_alpha = true,
		groups = {snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		recipe = {
			{"christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename},
			{"christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename}
		}
	})
	
	local tileFX = {
		name = "lights_"..nodename..".png^[transformFX",
		backface_culling = false,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 3.3
		}
	}
	
	local tile = {
		name = "lights_"..nodename..".png",
		backface_culling = false,
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 3.3
		}
	}
	
	for i = 1, 15 do
		minetest.override_item("xpanes:lights_" .. nodename .. "_pane_" .. i, {
			tiles = {"xpanes_space.png", "xpanes_space.png", tile, tile, tileFX, tile},
			sunlight_propagates = true,
			walkable = false,
			light_source = 10,
		})
	end
	
	minetest.override_item("xpanes:lights_"..nodename.."_pane", {
		tiles = {"xpanes_space.png", "xpanes_space.png", tile, tile, tileFX, tile},
		sunlight_propagates = true,
		walkable = false,
		light_source = 10,
	})
	
	minetest.override_item("xpanes:lights_"..nodename.."_pane_flat", {
		tiles = {"xpanes_space.png", "xpanes_space.png", tile, tile, tileFX, tile},
		sunlight_propagates = true,
		walkable = false,
		light_source = 10,
	})
	
	minetest.register_craft({
		output = "xpanes:lights_" .. nodename .. "_pane_flat 6",
		recipe = {
			{"christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename},
			{"christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename, "christmas_decor:lights_"..nodename}
		}
	})
end

register_lights("White", "white", 16, 6)
register_lights("White Icicle", "white_icicle", 16, 6)
register_lights("Multicolor", "multicolor", 16, 6)
register_lights("Multicolor Bulb", "multicolor_bulb", 8, 3)

minetest.register_craft({
	output = "christmas_decor:lights_white 6",
	recipe = {
		{"christmas_decor:led_white", "christmas_decor:led_white", "christmas_decor:led_white"},
		{"christmas_decor:wire", "christmas_decor:wire", "christmas_decor:wire"},
		{"christmas_decor:led_white", "christmas_decor:led_white", "christmas_decor:led_white"},
	},
})

minetest.register_craft({
	output = "christmas_decor:lights_white_icicle 6",
	recipe = {
		{"christmas_decor:wire", "christmas_decor:wire", "christmas_decor:wire"},
		{"christmas_decor:led_white", "christmas_decor:led_white", "christmas_decor:led_white"},
		{"christmas_decor:led_white", "christmas_decor:led_white", "christmas_decor:led_white"},
	},
})

minetest.register_craft({
	output = "christmas_decor:lights_multicolor 6",
	recipe = {
		{"christmas_decor:led_rgb", "christmas_decor:led_rgb", "christmas_decor:led_rgb"},
		{"christmas_decor:wire", "christmas_decor:wire", "christmas_decor:wire"},
		{"christmas_decor:led_rgb", "christmas_decor:led_rgb", "christmas_decor:led_rgb"},
	},
})

minetest.register_craft({
	output = "christmas_decor:lights_multicolor_bulb 6",
	recipe = {
		{"christmas_decor:led_rgb", "default:glass", "christmas_decor:led_rgb"},
		{"christmas_decor:wire", "christmas_decor:wire", "christmas_decor:wire"},
		{"christmas_decor:led_rgb", "default:glass", "christmas_decor:led_rgb"},
	},
})

-- Stocking
dofile(minetest.get_modpath("christmas_decor").."/stocking.lua")

-- Apparel
minetest.register_tool("christmas_decor:helmet_santa_hat", {
		description = "Santa Hat",
		inventory_image = "inv_helmet_santa_hat.png",
		groups = {
			armor_head = 0,
			armor_heal = 0,
			armor_use = 0,
		},
		wear = 0,
})

minetest.register_craft({
	output = "christmas_decor:helmet_santa_hat",
	recipe = {
		{"", "wool:white", ""},
		{"", "wool:red", ""},
		{"wool:red", "wool:red", "wool:red"},
	},
})

-- Mobs (with help from GoldenHart)
local function register_claus(desc, mobname, original_def)
	mobs:register_mob("christmas_decor:" .. mobname, {
		type = "npc",
		passive = true,
		damage = 3,
		pathfinding = false,
		nametag = desc, 
		hp_min = 20,
		hp_max = 20,
		armor = 1000000000000, -- No Can Die
		collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
		visual = "mesh",
		mesh = "character.b3d",
		drawtype = "front",
		textures = {
			{mobname .. ".png"},
		},
		makes_footstep_sound = false,
		sounds = {},
		walk_velocity = 0,
		run_velocity = 0,
		jump = false,
		water_damage = 0,
		lava_damage = 0,
		light_damage = 0,
		view_range = 15,
		owner = "",
		fear_height = 3,
		animation = {
			speed_normal = 30,
			speed_run = 30,
			stand_start = 0,
			stand_end = 79,
		},
		on_rightclick = function(self, clicker)
			if mobs:capture_mob(self, clicker, 100, 100, 100, false, nil) then return end
		end
	})

	mobs:register_egg("christmas_decor:" .. mobname, desc, "wool_red.png", 1)
	
	mobs:alias_mob("mobs:" .. mobname, "christmas_decor:" .. mobname)
end

register_claus("Santa Claus", "santa")

local function register_reindeer(desc, mobname, original_def)
	mobs:register_mob("christmas_decor:" .. mobname, {
		type = "animal",
		passive = true,
		damage = 3,
		hp_min = 20,
		hp_max = 20,
		armor = 1000000000000,
		collisionbox = {-0.2, -0.01, -0.2, 0.2, 1.2, 0.2},
		visual = "mesh",
		mesh = "reindeer.b3d",
		textures = {mobname .. ".png"},
		makes_footstep_sound = false,
		walk_velocity = 0,
		run_velocity = 0,
		jump = false,
		water_damage = 0,
		lava_damage = 0,
		light_damage = 0,
		animation = {
			speed_normal = 25,
			speed_normal = 25,
			speed_run = 25,
			stand_start = 0,
			stand_end = 200,
			walk_start = 149,
			walk_end = 150,
			run_start = 150,
			run_end = 170,
		},
		follow = "christmas_decor:candycane_edible",
		view_range = 15,
		fear_height = 3,
		on_rightclick = function(self, clicker)
			if mobs:feed_tame(self, clicker, 0, false, true) then return end
			if mobs:capture_mob(self, clicker, 100, 100, 100, false, nil) then return end
			local tool = clicker:get_wielded_item()
			local name = clicker:get_player_name()
		end
	})

	mobs:register_egg("christmas_decor:" .. mobname, desc, "wool_brown.png", 1)
	
	mobs:alias_mob("mobs:" .. mobname, "christmas_decor:" .. mobname)
end

register_reindeer("Reindeer", "reindeer")

-- Eddibles
minetest.register_craftitem("christmas_decor:candycane_edible", {
	description = "Candycane",
	inventory_image = "candycane_eddible.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("christmas_decor:candycane_base", {
	description = "Candycane Base",
	inventory_image = "candycane_base.png",
})

minetest.register_craftitem("christmas_decor:gingerbread_man", {
	description = "Gingerbread Man",
	inventory_image = "gingerbread_man.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem("christmas_decor:gingerbread_man_raw", {
	description = "Gingerbread Man (raw)",
	inventory_image = "gingerbread_man_raw.png",
})

minetest.register_craftitem("christmas_decor:gingerbread_dough", {
	description = "Gingerbread Dough",
	inventory_image = "gingerbread_dough.png",
})

minetest.register_craftitem("christmas_decor:ginger", {
	description = "Ginger",
	inventory_image = "ginger.png",
})

minetest.register_craftitem("christmas_decor:cookiecutter", {
	description = "Cookiecutter",
	inventory_image = "cookie_cutter.png",
})

minetest.register_node("christmas_decor:plate_with_cookies", {
	description = "Plate of Cookies (decorative)",
	tiles = {"plate_top.png"},
	inventory_image = "plate_top.png",
	wield_imagte = "plate_top.png",
	sunlight_propagates = true,
	walkable = false,
	climbable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	legacy_wallmounted = true,
	use_texture_alpha = true,
	drawtype = "signlike",
	paramtype2 = "wallmounted",
	groups = {snappy = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("christmas_decor:milk_glass", {
	description = "Glass of Milk (decorative)",
	drawtype = "plantlike",
	tiles = {"milk_glass.png"},
	inventory_image = "milk_glass_inv.png",
	wield_image = "milk_glass.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "christmas_decor:plate_with_cookies",
	type = "shapeless",
	recipe = {"christmas_decor:gingerbread_man", "christmas_decor:gingerbread_man", "christmas_decor:gingerbread_man", "homedecor:cutlery_set"}, 
})

minetest.register_craft({
	output = "christmas_decor:milk_glass",
	type = "shapeless",
	recipe = {"vessels:drinking_glass", "mobs:bucket_milk"},
	replacements = {{"mobs:bucket_milk", "bucket:bucket_empty"}},
})

minetest.register_craft({
	output = "christmas_decor:ginger",
	recipe = {
		{"homedecor:plastic_sheeting", "dye:orange", "homedecor:plastic_sheeting"},
		{"homedecor:plastic_sheeting", "dye:brown", "homedecor:plastic_sheeting"},
	},
})

minetest.register_craft({
	output = "christmas_decor:ginger",
	recipe = {
		{"homedecor:plastic_sheeting", "dye:brown", "homedecor:plastic_sheeting"},
		{"homedecor:plastic_sheeting", "dye:orange", "homedecor:plastic_sheeting"},
	},
})

minetest.register_craft({
	output = "christmas_decor:gingerbread_dough",
	type = "shapeless",
	recipe = {"christmas_decor:ginger", "farming:flour", "bucket:bucket_water", "farming:sugar"},
	replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})

minetest.register_craft({
	output = "christmas_decor:cookiecutter 1",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
	},
})

minetest.register_craft({
	output = "christmas_decor:gingerbread_man_raw 5",
	type = "shapeless",
	recipe = {"christmas_decor:cookiecutter", "christmas_decor:gingerbread_dough"},
	replacements = {{"christmas_decor:cookiecutter", "christmas_decor:cookiecutter"}},
})

minetest.register_craft({
	type = "cooking",
	output = "christmas_decor:gingerbread_man",
	recipe = "christmas_decor:gingerbread_man_raw",
	cooktime = 10,
})

minetest.register_craft({
	output = "christmas_decor:candycane_base 2",
	recipe = {
		{"", "farming:sugar", ""},
		{"farming:sugar", "", "farming:sugar"},
		{"", "", "farming:sugar"},
	},
})

minetest.register_craft({
	output = "christmas_decor:candycane_base 2",
	recipe = {
		{"", "farming:sugar", ""},
		{"farming:sugar", "", "farming:sugar"},
		{"farming:sugar", "", ""},
	},
})

minetest.register_craft({
	output = "christmas_decor:candycane_edible",
	type = "shapeless",
	recipe = {"christmas_decor:candycane_base", "dye:red", "dye:white"},
})

-- Mistletoe
minetest.register_node("christmas_decor:mistletoe", {
	description = "Mistletoe",
	tiles = {"mistletoe.png"},
	drawtype = "plantlike",
	walkable = false,
	sunlight_propagats = true,
	use_texture_alpha = true,
	groups = {snappy = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craft({
	output = "christmas_decor:mistletoe",
	type = "shapeless",
	recipe = {"default:leaves", "default:leaves", "dye:red"},
})
