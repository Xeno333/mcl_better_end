
minetest.register_node("mcl_better_end:enderite_ore", {
    description = "Ore of Enderite",
    tiles = {
        "mcl_end_end_stone.png^end_stone_with_enderite.png",
    },
    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 70,

    groups = {pickaxey=7, building_block=1, material_stone=1, mbe_plains=1},
})
