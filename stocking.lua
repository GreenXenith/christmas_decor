local depends, default_sounds = ...

local stuffers = {}
local custom_stuffers = minetest.settings:get("christmas_decor.stocking_stuffers")

if custom_stuffers then
	-- Format: modname:itemname count
	-- Count is optional (default: 1)
	-- Example: christmas_decor.stocking_stuffers = default:gold_ingot 99, default:coal_lump 20, default:snow
	for stack in custom_stuffers:gmatch("[%w%d:_]+ *%d*") do
		stuffers[#stuffers + 1] = stack
	end
else
	for _, stack in pairs({
		"christmas_decor:candycane 20",
		"christmas_decor:gingerbread_man 10",
		"christmas_decor:hat_elf 1",
		"default:gold_ingot 99",
		"default:pick_mese 1",
		"default:sword_mese 1",
		"default:axe_mese 1",
		"default:shovel_mese 1",
	}) do
		stuffers[#stuffers + 1] = stack
	end
end

local stocking_form = [[
	size[9,9]
	background[-0.8,-0.4;10,10;christmas_decor_stocking_bg.png]
	image_button_exit[7.75,1;1,1;christmas_decor_button_exit.png;exit;]
	listcolors[#D4393C;#d45658]
	list[context;main;-0.2,2;8,2;]
	list[current_player;main;-0.2,5;8,4;]
	listring[context;main]
	listring[current_player;main]
]]

local function get_date()
	return tonumber(os.date("%Y")), tonumber(os.date("%m")), tonumber(os.date("%d"))
end

local function try_stocking_fill(pos)
	local year, month, day = get_date()
	local meta = minetest.get_meta(pos)
	local last_fill_year = meta:get_int("last_fill_year")
	local ellapsed = year - (last_fill_year ~= 0 and last_fill_year or meta:get_int("fill_year")) -- fill_year is legacy

	-- If it has been 2 or more years, Christmas has already passed at least once
	-- If it has only been one year, make sure it is after Christmas
	if ellapsed > 1 or (ellapsed == 1 and month == 12 and day >= 25) then
		local inv = meta:get_inventory()
		for _, stack in pairs(stuffers) do
			if minetest.registered_items[stack:gsub("%s.*", "")] then
				inv:add_item("main", stack)
			end
		end

		-- Always set to this year if after Christmas, otherwise set to last year
		meta:set_int("last_fill_year", (month == 12 and day >= 25) and year or year - 1)
	end
end

local function player_can_interact(pos, player)
	local is_owner = player and player:get_player_name() == minetest.get_meta(pos):get_string("owner")
	local can_bypass = player and minetest.check_player_privs(player, "protection_bypass")
	return is_owner or can_bypass
end

minetest.register_node("christmas_decor:stocking", {
	description = "Stocking",
	drawtype = "mesh",
	mesh = "christmas_decor_stocking.obj",
	tiles = {"christmas_decor_stocking.png"},
	use_texture_alpha = true,
	inventory_image = "christmas_decor_stocking_inv.png",
	wield_image = "christmas_decor_stocking_inv.png",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, 0.5, 0.4, 0.5, 0.2},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, 0.5, 0.4, 0.5, 0.2},
	},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	groups = {snappy = 3},
	sounds = default_sounds("node_sound_leaves_defaults"),
	on_place = function(itemstack, placer, pointed_thing)
		-- Convert legacy attribute values
		if placer.get_attribute and placer:get_attribute("has_placed_stocking") then
			placer:get_meta():set_int("has_placed_stocking", minetest.is_yes(placer:get_attribute("has_placed_stocking")) and 1 or 0)
		end

		if minetest.is_yes(placer:get_meta():get_int("has_placed_stocking")) then
			minetest.chat_send_player(placer:get_player_name(), "Santa won't fill more than one stocking!")
			return itemstack
		else
			return minetest.item_place(itemstack, placer, pointed_thing)
		end
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()
		local inv = meta:get_inventory()

		meta:set_string("owner", owner)
		meta:set_string("infotext", owner.."'s Stocking")
		meta:set_string("formspec", stocking_form)
		inv:set_size("main", 8 * 2)

		local year, month, day = get_date()
		meta:set_int("last_fill_year", (month == 12 and day >= 25) and year or year - 1)

		placer:get_meta():set_int("has_placed_stocking", 1)
	end,
	on_rightclick = function(pos)
		-- Legacy handling
		local meta = minetest.get_meta(pos)
		if meta:get_string("formspec") == "" then
			meta:set_string("formspec", stocking_form)
		end
		try_stocking_fill(pos)
	end,
	can_dig = function(pos, player)
		return player_can_interact(pos, player) and minetest.get_meta(pos):get_inventory():is_empty("main")
	end,
	allow_metadata_inventory_move = function(pos, _, _, _, _, count, player)
		return player_can_interact(pos, player) and count or 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() .. " moves stuff in stocking at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() .. " moves stuff to stocking at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() .. " takes stuff from stocking at " .. minetest.pos_to_string(pos))
	end,
	on_dig = function(pos, node, digger)
		digger:get_meta():set_int("has_placed_stocking", 0)
		return minetest.node_dig(pos, node, digger)
	end,
})

if depends.wool then
	minetest.register_craft({
		output = "christmas_decor:stocking",
		recipe = {
			{"", "wool:white", "wool:white"},
			{"", "wool:red", "wool:red"},
			{"wool:red", "wool:red", "wool:red"},
		}
	})

	minetest.register_craft({
		output = "christmas_decor:stocking",
		recipe = {
			{"wool:white", "wool:white", ""},
			{"wool:red", "wool:red", ""},
			{"wool:red", "wool:red", "wool:red"},
		}
	})
end
