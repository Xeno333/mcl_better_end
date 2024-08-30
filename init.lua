mcl_better_end = {}
mcl_better_end.api = {}
mcl_better_end.api.consts = {}

mcl_better_end.mapgen = {}
mcl_better_end.mapgen.ores = {}
mcl_better_end.biomes = {}

mcl_better_end.code_loc = minetest.get_modpath("mcl_better_end") .. "/src"
mcl_better_end.schematic_loc = minetest.get_modpath("mcl_better_end") .. "/schems"



dofile(mcl_better_end.code_loc .. "/nodes/nodes.lua")
dofile(mcl_better_end.code_loc .. "/nodes/nodes_plains.lua")
dofile(mcl_better_end.code_loc .. "/nodes/nodes_oasis.lua")
dofile(mcl_better_end.code_loc .. "/nodes/nodes_night.lua")
dofile(mcl_better_end.code_loc .. "/nodes/nodes_ender_sea.lua")

dofile(mcl_better_end.code_loc .. "/items/items.lua")

dofile(mcl_better_end.code_loc .. "/mapgen/mapgen.lua")

dofile(mcl_better_end.code_loc .. "/mapgen/biome_plains.lua")
dofile(mcl_better_end.code_loc .. "/mapgen/biome_oasis.lua")
dofile(mcl_better_end.code_loc .. "/mapgen/biome_ender_sea.lua")
dofile(mcl_better_end.code_loc .. "/mapgen/biome_night.lua")

dofile(mcl_better_end.code_loc .. "/enderite/enderite.lua")
dofile(mcl_better_end.code_loc .. "/enderite/enderite_craft.lua")
dofile(mcl_better_end.code_loc .. "/enderite/ore.lua")

dofile(mcl_better_end.code_loc .. "/nephrite/nephrite.lua")
dofile(mcl_better_end.code_loc .. "/nephrite/nephrite_craft.lua")
dofile(mcl_better_end.code_loc .. "/nephrite/ore.lua")

dofile(mcl_better_end.code_loc .. "/nightite/nightite.lua")
dofile(mcl_better_end.code_loc .. "/nightite/nightite_craft.lua")

dofile(mcl_better_end.code_loc .. "/entities/ender_salmon.lua")

dofile(mcl_better_end.code_loc .. "/physics.lua")
