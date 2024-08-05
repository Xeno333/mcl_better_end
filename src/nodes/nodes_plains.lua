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

    groups = {pickaxey=1, building_block=1, material_stone=1, mbe_plains=1},
})
