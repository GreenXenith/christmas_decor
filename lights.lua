local depends, default_sounds =  ...

minetest.register_craftitem("christmas_decor:led_rgb", {
	description = "RGB Led Light",
	inventory_image = "christmas_decor_led_rgb.png",
})

minetest.register_craftitem("christmas_decor:led_white", {
	description = "White Led Light",
	inventory_image = "christmas_decor_led_white.png",
})

minetest.register_craftitem("christmas_decor:wire", {
	description = "Wire",
	inventory_image = "christmas_decor_wire.png",
})

if depends.dye then
	minetest.register_craft({
		output = "christmas_decor:led_rgb",
		type = "shapeless",
		recipe = {"christmas_decor:led_white", "dye:green", "dye:blue", "dye:red"},
	})
end

if depends.basic_materials then
	if depends.default then
		minetest.register_craft({
			output = "christmas_decor:led_white 8",
			recipe = {
				{"default:glass"},
				{"basic_materials:energy_crystal_simple"},
				{"basic_materials:plastic_sheet"},
			},
		})
	end

	minetest.register_craft({
		output = "christmas_decor:wire 16",
		recipe = {
			{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
			{"basic_materials:copper_strip", "basic_materials:copper_strip", "basic_materials:copper_strip"},
			{"basic_materials:plastic_sheet", "basic_materials:plastic_sheet", "basic_materials:plastic_sheet"},
		},
	})
end

local function register_lights(desc, nodename, aspect, length)
	minetest.register_node("christmas_decor:lights_" .. nodename, {
		description = desc .. " Christmas Lights",
		tiles = {
			{
				image = "christmas_decor_lights_" .. nodename .. ".png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = aspect,
					aspect_h = aspect,
					length = length
				},
			}
		},
		inventory_image = "christmas_decor_lights_" .. nodename .. "_inv.png",
		wield_image = "christmas_decor_lights_" .. nodename .. "_inv.png",
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
		connects_to = {"group:christmas_lights"},
		groups = {snappy = 3, christmas_lights = 1},
		sounds = default_sounds("node_sound_leaves_defaults"),
	})

	if not depends.xpanes then return end
	local tileFX = {
		name = "christmas_decor_lights_" .. nodename .. ".png^[transformFX",
		backface_culling = false,
		animation = {
			type = "vertical_frames",
			aspect_w = aspect,
			aspect_h = aspect,
			length = length
		}
	}

	local tile = {
		name = "christmas_decor_lights_" .. nodename .. ".png",
		backface_culling = false,
		animation = {
			type = "vertical_frames",
			aspect_w = aspect,
			aspect_h = aspect,
			length = length
		}
	}

	xpanes.register_pane("lights_" .. nodename .. "_pane", {
		description = desc .. " Christmas Lights (pane)",
		textures = {},
		use_texture_alpha = true,
		groups = {snappy = 3},
		sounds = default_sounds("node_sound_leaves_defaults"),
		recipe = {
			{"christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename},
			{"christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename}
		}
	})

	minetest.override_item("xpanes:lights_" .. nodename .. "_pane", {
		tiles = {"blank.png", "blank.png", tile, tileFX, tileFX, tile},
		walkable = false,
		light_source = 10,
	})

	minetest.override_item("xpanes:lights_" .. nodename .. "_pane_flat", {
		tiles = {"blank.png", "blank.png", tile, tile, tileFX, tile},
		walkable = false,
		light_source = 10,
	})

	minetest.register_craft({
		output = "xpanes:lights_" .. nodename .. "_pane_flat 6",
		recipe = {
			{"christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename},
			{"christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename, "christmas_decor:lights_" .. nodename}
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

minetest.register_node("christmas_decor:garland", {
	description = "Garland",
	tiles = {"christmas_decor_garland.png"},
	inventory_image = "christmas_decor_garland.png",
	wield_image = "christmas_decor_garland.png",
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
	sounds = default_sounds("node_sound_leaves_defaults"),
})

minetest.register_node("christmas_decor:garland_lights", {
	description = "Garland with Lights",
	tiles = {
		{
			image = "christmas_decor_garland_lights.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 64,
				aspect_h = 64,
				length = 16
			},
		}
	},
	inventory_image = "christmas_decor_garland_lights_inv.png",
	wield_image = "christmas_decor_garland_lights_inv.png",
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
	sounds = default_sounds("node_sound_leaves_defaults"),
})

if depends.default then
	minetest.register_craft({
		output = "christmas_decor:garland 3",
		recipe = {
			{"default:pine_needles", "default:pine_needles", "default:pine_needles"},
		},
	})
end

minetest.register_craft({
	output = "christmas_decor:garland_lights",
	type = "shapeless",
	recipe = {"christmas_decor:garland", "christmas_decor:led_white", "christmas_decor:led_white", "christmas_decor:led_white"},
})
