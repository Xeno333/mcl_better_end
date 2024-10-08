minetest.register_node("mcl_better_end:end_stone_night_turf", {
    description = "End Stone with Night Mold",
    tiles = {
        "mcl_better_end_night_turf_top.png",   -- Top texture
        "mcl_end_end_stone.png",   -- Bottom texture
        "mcl_end_end_stone.png^mcl_better_end_night_turf_side.png",   -- Side texture 1
        "mcl_end_end_stone.png^mcl_better_end_night_turf_side.png",   -- Side texture 2
        "mcl_end_end_stone.png^mcl_better_end_night_turf_side.png",   -- Side texture 3
        "mcl_end_end_stone.png^mcl_better_end_night_turf_side.png",   -- Side texture 4
    },
    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 9,
    _mcl_hardness = 3,
    _mcl_silk_touch_drop = true,
    light_source = 0,

    drop = {
        max_items = 2,
        items = {
            {items = {"mcl_end:end_stone"}, rarity = 1},
            {items = {"mcl_better_end:nightite_raw"}, rarity = 4000},
        },
    },

    groups = {pickaxey=1, building_block=1, material_stone=1},
})




minetest.register_node("mcl_better_end:night_vines", {
	description = ("Night Vines"),
	drawtype = "plantlike",
	tiles = {"mcl_better_end_night_vines.png"},
	paramtype = "light",
	sunlight_propagates = true,
    walkable = false,
    is_ground_content = false,
	climbable = true,
	buildable_to = false,
    light_source = 4,
	groups = {shearsy=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}, -- Adjust the size for the vine
    },
})


minetest.register_node("mcl_better_end:night_vines_bottom", {
	description = ("Night Vines"),
	drawtype = "plantlike",
	tiles = {"mcl_better_end_night_vines_bottom.png"},
	paramtype = "light",
	sunlight_propagates = true,
    walkable = false,
    is_ground_content = false,
	climbable = false,
	buildable_to = false,
    light_source = 4,
	groups = {shearsy=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}, -- Adjust the size for the vine
    },
})




minetest.register_node("mcl_better_end:night_grass", {
	description = ("Night Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"mcl_better_end_night_grass.png"},
	inventory_image = "mcl_better_end_night_grass.png",
	is_ground_content = true,
	wield_image = "mcl_better_end_night_grass.png",
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



minetest.register_node("mcl_better_end:night_candle", {
	description = ("Night Candle"),
	drawtype = "plantlike",
	tiles = {"mcl_better_end_night_candle.png"},
	inventory_image = "mcl_better_end_night_candle.png",
	wield_image = "mcl_better_end_night_candle.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 10,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})


minetest.register_node("mcl_better_end:night_candle_plant", {
	description = ("Night Candle Plant"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"mcl_better_end_night_candle_plant.png"},
	inventory_image = "mcl_better_end_night_candle_plant.png",
	wield_image = "mcl_better_end_night_candle_plant.png",
	paramtype = "light",
	is_ground_content = true,
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 10,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})



