
minetest.register_node("mcl_better_end:enderite_ore", {
    description = "Ore of Enderite",
    tiles = {
        "mcl_end_end_stone.png^end_stone_with_enderite.png",
    },
    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 70,
    light_source = 10,  -- This makes the block emit light

    groups = {pickaxey=7, building_block=1, material_stone=1, mbe_plains=1},
})


--need new mapgen code
minetest.register_ore({
	ore_type = "scatter",
	ore = "mcl_better_end:enderite_ore",
	wherein = "air",
	clust_scarcity = 327680,
	clust_num_ores = 1,
	clust_size = 1,
	y_max = -27020,
	y_min = -27060,
})