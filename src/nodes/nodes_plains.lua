minetest.register_node("mcl_better_end:end_stone_plains_turf", {
    description = "End Stone with Ender Slime",
    tiles = {
        "end_stone_plains_turf_top.png",   -- Top texture
        "mcl_end_end_stone.png",   -- Bottom texture
        "mcl_end_end_stone.png^end_stone_plains_turf_side.png",   -- Side texture 1
        "mcl_end_end_stone.png^end_stone_plains_turf_side.png",   -- Side texture 2
        "mcl_end_end_stone.png^end_stone_plains_turf_side.png",   -- Side texture 3
        "mcl_end_end_stone.png^end_stone_plains_turf_side.png",   -- Side texture 4
    },
    stack_max = 64,

    drop = "mcl_end:end_stone",
    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 9,
    _mcl_hardness = 3,
    _mcl_silk_touch_drop = true,

    groups = {pickaxey=1, building_block=1, material_stone=1},
})



minetest.register_node("mcl_better_end:end_plains_magibulb_plant", {
	description = ("Magibulb"),
	drawtype = "plantlike",
	waving = 1,
	is_ground_content = true,
	tiles = {"end_plains_magibulb_plant.png"},
	inventory_image = "end_plains_magibulb_plant.png",
	wield_image = "end_plains_magibulb_plant.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 4,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})


minetest.register_node("mcl_better_end:end_plains_grass", {
	description = ("Ender Slime Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"end_plains_grass.png"},
	inventory_image = "end_plains_grass.png",
	wield_image = "end_plains_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = true,
	buildable_to = true,
    light_source = 4,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})

