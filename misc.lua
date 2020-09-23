local depends, default_sounds = ...

if depends.armor then
	armor:register_armor("christmas_decor:hat_santa", {
		description = "Santa Hat",
		inventory_image = "christmas_decor_hat_santa_inv.png",
		groups = {armor_head = 1, armor_use = 0},
	})

	armor:register_armor("christmas_decor:hat_elf", {
		description = "Elf Hat",
		inventory_image = "christmas_decor_hat_elf_inv.png",
		groups = {armor_head = 1, armor_use = 0},
	})

	minetest.register_alias("christmas_decor:helmet_santa_hat", "christmas_decor:hat_santa")
	minetest.register_alias("christmas_decor:helmet_elf_hat", "christmas_decor:hat_elf")

	if depends.wool then
		minetest.register_craft({
			output = "christmas_decor:helmet_santa_hat",
			recipe = {
				{"", "wool:white", ""},
				{"", "wool:red", ""},
				{"wool:red", "wool:red", "wool:red"},
			},
		})

		if depends.default then
			minetest.register_craft({
				output = "christmas_decor:helmet_elf_hat",
				recipe = {
					{"", "default:bronze_ingot", ""},
					{"", "wool:green", ""},
					{"wool:red", "wool:green", "wool:red"},
				},
			})
		end
	end
end

minetest.register_node("christmas_decor:mistletoe", {
	description = "Mistletoe",
	tiles = {"christmas_decor_mistletoe.png"},
	drawtype = "plantlike",
	walkable = false,
	sunlight_propagates = true,
	paramtype = "light",
	use_texture_alpha = true,
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_leaves_defaults"),
})

if depends.default and depends.dye then
	minetest.register_craft({
		output = "christmas_decor:mistletoe",
		type = "shapeless",
		recipe = {"default:leaves", "default:leaves", "dye:red"},
	})
end

minetest.register_node("christmas_decor:icicles_wall", {
	description = "Icicles (wall)",
	tiles = {
		{
			image = "christmas_decor_icicles.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 2
			},
		}
	},
	inventory_image = "christmas_decor_icicles_inv.png",
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
	light_source = 3,
	paramtype2 = "wallmounted",
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_glass_defaults"),
})

minetest.register_node("christmas_decor:icicles_hanging", {
	description = "Icicles (hanging)",
	tiles = {
		{
			image = "christmas_decor_icicles.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 32,
				aspect_h = 32,
				length = 2
			},
		}
	},
	use_texture_alpha = true,
	inventory_image = "christmas_decor_icicles_hanging_inv.png",
	wield_image = "christmas_decor_icicles_hanging_inv.png",
	drawtype = "plantlike",
	paramtype = "light",
	light_source = 3,
	paramtype2 = "degrotate",
	walkable = false,
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_glass_defaults"),
})

if depends.default then
	minetest.register_craft({
		output = "christmas_decor:icicles_hanging 4",
		recipe = {
			{"default:ice", "", "default:ice"},
			{"default:ice", "", "default:ice"},
		},
	})
end

minetest.register_craft({
	output = "christmas_decor:icicles_wall",
	type = "shapeless",
	recipe = {"christmas_decor:icicles_hanging"},
})

minetest.register_craft({
	output = "christmas_decor:icicles_hanging",
	type = "shapeless",
	recipe = {"christmas_decor:icicles_wall"},
})

if depends.homedecor_exterior then
	minetest.register_node("christmas_decor:christmas_shrubbery_large", {
		description = "Christmas Shrubbery (large)",
		drawtype = "mesh",
		mesh = "homedecor_cube.obj",
		tiles = {
			{
				image = "christmas_decor_shrubbery.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 8,
					aspect_h = 8,
					length = 3
				},
			}
		},
		paramtype = "light",
		light_source = 8,
		is_ground_content = false,
		groups = {snappy = 3},
		sounds = default_sounds("node_sound_leaves_defaults"),
	})

	minetest.register_node("christmas_decor:christmas_shrubbery", {
		description = "Christmas Shrubbery",
		drawtype = "mesh",
		mesh = "homedecor_shrubbery.obj",
		tiles = {
			{
				image = "christmas_decor_shrubbery.png",
				backface_culling = false,
				animation = {
					type = "vertical_frames",
					aspect_w = 8,
					aspect_h = 8,
					length = 3
				},
			},
			"homedecor_shrubbery_green_bottom.png",
			"homedecor_shrubbery_roots.png"
		},
		paramtype = "light",
		light_source = 8,
		is_ground_content = false,
		groups = {snappy = 3},
		sounds = default_sounds("node_sound_leaves_defaults"),
		selection_box = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
		collision_box = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
	})

	minetest.register_craft({
		output = "christmas_decor:christmas_shrubbery",
		type = "shapeless",
		recipe = {"homedecor:shrubbery_green", "christmas_decor:lights_multicolor"},
	})

	minetest.register_craft({
		output = "christmas_decor:christmas_shrubbery_large",
		type = "shapeless",
		recipe = {"homedecor:shrubbery_large_green", "christmas_decor:lights_multicolor"},
	})

	minetest.register_craft({
		output = "christmas_decor:christmas_shrubbery",
		type = "shapeless",
		recipe = {"christmas_decor:christmas_shrubbery_large"},
	})

	minetest.register_craft({
		output = "christmas_decor:christmas_shrubbery_large",
		type = "shapeless",
		recipe = {"christmas_decor:christmas_shrubbery"},
	})

end

minetest.register_node("christmas_decor:nutcracker", {
	description = "Nutcracker",
	drawtype = "mesh",
	mesh = "christmas_decor_nutcracker.obj",
	tiles = {"christmas_decor_nutcracker.png"},
	use_texture_alpha = true,
	inventory_image = "christmas_decor_nutcracker_inv.png",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.4, 0.2},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0.4, 0.2},
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_wood_defaults"),
})

if depends.dye and depends.default then
	minetest.register_craft({
		output = "christmas_decor:nutcracker",
		recipe = {
			{"dye:yellow", "dye:black", "dye:yellow"},
			{"dye:red", "default:wood", "dye:red"},
			{"dye:blue", "dye:black", "dye:blue"},
		}
	})
end

minetest.register_node("christmas_decor:snowman", {
	description = "Snowman",
	drawtype = "mesh",
	mesh = "christmas_decor_snowman.obj",
	tiles = {"christmas_decor_snowman.png"},
	use_texture_alpha = true,
	inventory_image = "christmas_decor_snowman_inv.png",
	walkable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.2, 0.5},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.2, 0.5},
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_leaves_defaults"),
})

if depends.default then
	minetest.register_craft({
		output = "christmas_decor:snowman",
		recipe = {
			{"default:coal_lump", "default:snowblock", "default:coal_lump"},
			{"default:coal_lump", "default:snowblock", "default:coal_lump"},
			{"", "default:snowblock", ""},
		},
	})
end
