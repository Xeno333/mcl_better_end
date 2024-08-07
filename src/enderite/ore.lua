

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


mcl_better_end.mapgen.registered_nodes.enderite_ore = minetest.get_content_id("mcl_better_end:enderite_ore")

mcl_better_end.mapgen.ores.enderite = function(data, vi, area, pr, x, y, z)
    --enderite
    if pr:next(1, 1000) == 5 then
        if pr:next(1, 10) == 5 then
            data[vi] = mcl_better_end.mapgen.registered_nodes.enderite_ore
        end
    end
end