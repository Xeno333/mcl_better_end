minetest.register_node("mcl_better_end:end_sand", {
    description = "End Sand",
    tiles = {"end_sand.png"}
    stack_max = 64,

    drop = "mcl_better_end:end_sand",
    groups = {handy=1, shovely=1, falling_node=1, sand=1, enderman_takable=1, building_block=1, material_sand=1}
    sounds = mcl_sounds.node_sound_sand_defaults(),

    _mcl_blast_resistance = 0.7,
    _mcl_hardness = 0.6,
    _mcl_cooking_output = "mcl_better_end:end_glass"
})

minetest.register_node("mcl_better_end:end_glass", {
    description = "End Glass",
    tiles = {"end_glass.png"}
    drawtype = "glasslike_framed_optional",
    sunlight_propagates = true,
    stack_max = 64,
    paramtype = "light",
    paramtype2 = "glasslikeliquidlevel"
    _mcl_silk_touch_drop = true,
    drop = "",

    drop = "mcl_better_end:end_sand",
    groups = {handy=1, glass=1, enderman_takable=1, building_block=1, material_glass=1}
    sounds = mcl_sounds.node_sound_glass_defaults(),

    _mcl_blast_resistance = 0.1,
    _mcl_hardness = 0.1,
})
