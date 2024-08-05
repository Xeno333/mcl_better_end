
minetest.register_decoration({
    name = "mcl_better_end:end_stone_plains_turf",
    deco_type = "simple",
    place_on = {"mcl_end:end_stone"},
    flags = "all_floors",
    sidelen = 16,
    y_min = mcl_vars.mg_end_min,
    y_max = mcl_vars.mg_end_max,
    noise_params = {
        offset = -0.012,
        scale = 0.024,
        spread = {x = 100, y = 100, z = 100},
        seed = 257,
        octaves = 3,
        persist = 100
    },
    decoration = "mcl_better_end:end_stone_plains_turf",
    height = 1,
    --height_max = 1,
    biomes = {"EndSmallIslands"},
})


minetest.register_decoration({
    name = "mcl_better_end:end_stone_plains_grass",
    deco_type = "simple",
    place_on = {"mcl_better_end:end_stone_plains_turf"},
    flags = "all_floors",
    sidelen = 16,
    y_min = mcl_vars.mg_end_min,
    y_max = mcl_vars.mg_end_max,
    noise_params = {
        offset = -0.012,
        scale = 0.024,
        spread = {x = 100, y = 100, z = 100},
        seed = 257,
        octaves = 3,
        persist = 1
    },
    decoration = "mcl_better_end:end_stone_plains_grass",
    height = 1,
    --height_max = 1,
    biomes = {"EndSmallIslands"},
})