local MODPATH = minetest.get_modpath(minetest.get_current_modname())

local depends = {
	armor = minetest.global_exists("armor"),
	basic_materials = minetest.get_modpath("basic_materials"),
	bucket = minetest.get_modpath("bucket"),
	default = minetest.get_modpath("default"),
	dye = minetest.get_modpath("dye"),
	farming_redo = minetest.global_exists("farming") and farming.mod and farming.mod == "redo",
	homedecor_exterior = minetest.get_modpath("homedecor_exterior"),
	mobs_animal = minetest.get_modpath("mobs_animal"),
	mobs_redo = minetest.global_exists("mobs") and mobs.mod and mobs.mod == "redo",
	stairs = minetest.global_exists("stairs"),
	vessels = minetest.get_modpath("vessels"),
	wool = minetest.get_modpath("wool"),
	xpanes = minetest.global_exists("xpanes"),
}

local function default_sounds(name)
	if default and default[name] then return default[name]() end
end

local function include(filename)
	assert(loadfile(MODPATH .. "/" .. filename))(depends, default_sounds)
end

include("food.lua")
include("lights.lua")
include("mobs.lua")
include("stocking.lua")
include("misc.lua")
