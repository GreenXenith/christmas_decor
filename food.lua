local depends, default_sounds =  ...

minetest.register_node("christmas_decor:candycane", {
	description = "Candycane",
	drawtype = "mesh",
	mesh = "christmas_decor_candycane.obj",
	tiles = {"christmas_decor_candycane.png"},
	inventory_image = "christmas_decor_candycane_inv.png",
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
	sounds = default_sounds("node_sound_stone_defaults"),
	on_use = minetest.item_eat(4),
})

minetest.register_alias("christmas_decor:candycane_edible", "christmas_decor:candycane")
minetest.register_alias("christmas_decor:candycane_base", "christmas_decor:candycane")

minetest.register_craftitem("christmas_decor:gingerbread_man", {
	description = "Gingerbread Man",
	inventory_image = "christmas_decor_gingerbread_man.png",
	on_use = minetest.item_eat(6),
})

minetest.register_craftitem("christmas_decor:gingerbread_man_raw", {
	description = "Gingerbread Man (raw)",
	inventory_image = "christmas_decor_gingerbread_man_raw.png",
})

minetest.register_craftitem("christmas_decor:gingerbread_dough", {
	description = "Gingerbread Dough",
	inventory_image = "christmas_decor_gingerbread_dough.png",
})

minetest.register_craftitem("christmas_decor:ginger", {
	description = "Ginger",
	inventory_image = "christmas_decor_ginger.png",
})

minetest.register_craftitem("christmas_decor:cookiecutter", {
	description = "Cookiecutter",
	inventory_image = "christmas_decor_cookie_cutter.png",
})

minetest.register_node("christmas_decor:plate_with_cookies", {
	description = "Plate of Cookies (decorative)",
	tiles = {"christmas_decor_plate_top.png"},
	inventory_image = "christmas_decor_plate_top.png",
	wield_imagte = "christmas_decor_plate_top.png",
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
	sounds = default_sounds("node_sound_glass_defaults"),
})

minetest.register_node("christmas_decor:milk_glass", {
	description = "Glass of Milk",
	drawtype = "plantlike",
	tiles = {"christmas_decor_milk_glass.png"},
	inventory_image = "christmas_decor_milk_glass_inv.png",
	wield_image = "christmas_decor_milk_glass.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	stack_max = 1,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default_sounds("node_sound_glass_defaults"),
	on_use = minetest.item_eat(4, depends.vessels and "vessels:drinking_glass"),
})

if depends.default then
	minetest.register_craft({
		output = "christmas_decor:plate_with_cookies",
		type = "shapeless",
		recipe = {
			"christmas_decor:gingerbread_man", "christmas_decor:gingerbread_man",
			"christmas_decor:gingerbread_man", "default:glass",
		},
	})
end

if depends.vessels and depends.mobs_animal and depends.bucket then
	minetest.register_craft({
		output = "christmas_decor:milk_glass",
		type = "shapeless",
		recipe = {"vessels:drinking_glass", "mobs:bucket_milk"},
		replacements = {{"mobs:bucket_milk", "bucket:bucket_empty"}},
	})
end

if depends.default then
	if depends.dye then
		minetest.register_craft({
			output = "christmas_decor:ginger",
			recipe = {
				{"default:paper", "dye:brown", "default:paper"},
				{"default:paper", "dye:orange", "default:paper"},
			},
		})
	end

	minetest.register_craft({
		output = "christmas_decor:cookiecutter 1",
		recipe = {
			{"", "default:steel_ingot", ""},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "", "default:steel_ingot"},
		},
	})
end

if depends.bucket and depends.farming_redo then
	minetest.register_craft({
		output = "christmas_decor:gingerbread_dough",
		type = "shapeless",
		recipe = {"christmas_decor:ginger", "farming:flour", "bucket:bucket_water", "farming:sugar"},
		replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
	})
end

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

if depends.farming_redo and depends.dye then
	minetest.register_craft({
		output = "christmas_decor:candycane_edible 2",
		recipe = {
			{"", "farming:sugar", ""},
			{"dye:red", "", "dye:red"},
			{"", "", "farming:sugar"},
		},
	})

	minetest.register_craft({
		output = "christmas_decor:candycane_edible 2",
		recipe = {
			{"", "farming:sugar", ""},
			{"dye:red", "", "dye:red"},
			{"farming:sugar", "", ""},
		},
	})
end

if depends.default and depends.dye then
	minetest.register_craft({
		output = "christmas_decor:candycane 2",
		recipe = {
			{"", "dye:white", ""},
			{"dye:red", "default:stick", "dye:red"},
			{"", "", "dye:white"},
		},
	})

	minetest.register_craft({
		output = "christmas_decor:candycane 2",
		recipe = {
			{"", "dye:white", ""},
			{"dye:red", "default:stick", "dye:red"},
			{"dye:white", "", ""},
		},
	})
end

minetest.register_node("christmas_decor:candycane_block", {
	description = "Candycane Block",
	tiles = {
		"christmas_decor_candycane_block.png", "christmas_decor_candycane_block.png",
		"christmas_decor_candycane_block.png", "christmas_decor_candycane_block.png",
		"christmas_decor_candycane_block.png^[transformFX", "christmas_decor_candycane_block.png^[transformFX",
	},
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_stone_defaults"),
})

minetest.register_node("christmas_decor:peppermint_block", {
	description = "Peppermint Block",
	tiles = {"christmas_decor_peppermint.png"},
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_stone_defaults"),
})

minetest.register_node("christmas_decor:frosting_block", {
	description = "Frosting Block",
	tiles = {"christmas_decor_frosting.png"},
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_leaves_defaults"),
})

if depends.farming_redo then
	if depends.dye then
		minetest.register_craft({
			output = "christmas_decor:candycane_block 8",
			recipe = {
				{"farming:sugar", "dye:red", "farming:sugar"},
				{"dye:red", "farming:sugar", "dye:red"},
				{"farming:sugar", "dye:red", "farming:sugar"},
			},
		})

		minetest.register_craft({
			output = "christmas_decor:peppermint_block 8",
			recipe = {
				{"dye:red", "farming:sugar", "dye:red"},
				{"farming:sugar", "dye:red", "farming:sugar"},
				{"dye:red", "farming:sugar", "dye:red"},
			},
		})
	end

	if depends.bucket then
		minetest.register_craft({
			output = "christmas_decor:frosting_block 8",
			recipe = {
				{"farming:sugar", "farming:sugar", "farming:sugar"},
				{"farming:sugar", "bucket:bucket_water", "farming:sugar"},
				{"farming:sugar", "farming:sugar", "farming:sugar"},
			},
			replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
		})
	end
end

if depends.stairs then
	local candycane_def = minetest.registered_nodes["christmas_decor:candycane_block"]
	stairs.register_stair_and_slab("candycane_block", "christmas_decor:candycane_block",
		candycane_def.groups, candycane_def.tiles,
		candycane_def.description .. " Stair", candycane_def.description .. " Slab",
		candycane_def.sounds, false
	)

	local peppermint_def = minetest.registered_nodes["christmas_decor:peppermint_block"]
	stairs.register_stair_and_slab("peppermint_block", "christmas_decor:peppermint_block",
		peppermint_def.groups, peppermint_def.tiles,
		peppermint_def.description .. " Stair", peppermint_def.description .. " Slab",
		peppermint_def.sounds, false
	)

	local frosting_def = minetest.registered_nodes["christmas_decor:frosting_block"]
	stairs.register_stair_and_slab("frosting_block", "christmas_decor:frosting_block",
		frosting_def.groups, frosting_def.tiles,
		frosting_def.description .. " Stair", frosting_def.description .. " Slab",
		frosting_def.sounds, false
	)
end

minetest.register_node("christmas_decor:frosting_trim", {
	description = "Frosting Trim",
	tiles = {"christmas_decor_frosting_trim.png"},
	inventory_image = "christmas_decor_frosting_trim.png",
	wield_image = "christmas_decor_frosting_trim.png",
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

minetest.register_node("christmas_decor:frosting_line", {
	description = "Frosting Line",
	tiles = {"christmas_decor_frosting_line.png"},
	inventory_image = "christmas_decor_frosting_line.png",
	wield_image = "christmas_decor_frosting_line.png",
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

minetest.register_craft({
	output = "christmas_decor:frosting_trim 6",
	recipe = {
		{"christmas_decor:frosting_block", "christmas_decor:frosting_block", "christmas_decor:frosting_block"},
		{"", "christmas_decor:frosting_block", ""},
	}
})

minetest.register_craft({
	output = "christmas_decor:frosting_line 6",
	recipe = {
		{"christmas_decor:frosting_block", "christmas_decor:frosting_block", "christmas_decor:frosting_block"},
	}
})

for color, hex in pairs({
	red = "#ff0000",
	orange = "#ff9000",
	yellow = "#fcff00",
	green = "#18cb35",
	blue = "#0096FF",
	purple = "#ae4eff",
}) do
	minetest.register_node("christmas_decor:gumdrop_" .. color, {
		description = color:gsub("^%l", string.upper) .. " Gumdrop",
		drawtype = "mesh",
		mesh = "christmas_decor_gumdrop.obj",
		tiles = {"christmas_decor_gumdrop.png^[colorize:" .. hex .. ":150"},
		walkable = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.4, -0.5, -0.4, 0.4, 0.1, 0.4},
		},
		collision_box = {
			type = "fixed",
			fixed = {-0.4, -0.5, -0.4, 0.4, 0.1, 0.4},
		},
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "facedir",
		groups = {snappy = 3},
		sounds = default_sounds("node_sound_leaves_defaults"),
		on_use = minetest.item_eat(2),
	})

	if depends.farming_redo and depends.dye then
		minetest.register_craft({
			output = "christmas_decor:gumdrop_" .. color .. " 2",
			recipe = {
				{"", "farming:sugar", ""},
				{"farming:sugar", "dye:" .. color:gsub("purple", "violet"), "farming:sugar"},
				{"farming:sugar", "farming:sugar", "farming:sugar"},
			}
		})
	end
end
