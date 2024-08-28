minetest.register_node("mcl_better_end:end_sand", {
    description = "End Sand",
    tiles = {"end_sand.png"},
    stack_max = 64,

    drop = "mcl_better_end:end_sand",
    groups = {handy=1, shovely=1, falling_node=1, sand=1, enderman_takable=1, building_block=1, material_sand=1},
    sounds = mcl_sounds.node_sound_sand_defaults(),

    _mcl_blast_resistance = 0.7,
    _mcl_hardness = 0.6,
    _mcl_cooking_output = "mcl_better_end:end_glass"
})


local YMAX = -27020
local YMIN = -27100

mcl_better_end.mapgen.registered_nodes.sand = minetest.get_content_id("mcl_better_end:end_sand")

mcl_better_end.mapgen.ores.enderite = {
    gen = function(data, vi, area, pr, x, y, z, perlin_l, noise_center)
        --enderite
        if data[vi] == mcl_better_end.mapgen.registered_nodes.end_stone then
            if pr:next(1, 100) == 5 then
                data[vi] = mcl_better_end.mapgen.registered_nodes.sand
            end
        end
    end,
    ymax = YMAX,
    ymin = YMIN,
}

minetest.register_node("mcl_better_end:end_glass", {
    description = "End Glass",
    tiles = {"end_glass.png"},
    drawtype = "glasslike_framed_optional",
    sunlight_propagates = true,
    stack_max = 64,
    paramtype = "light",
    paramtype2 = "glasslikeliquidlevel",
    _mcl_silk_touch_drop = true,
    drop = "",

    drop = "mcl_better_end:end_sand",
    groups = {handy=1, glass=1, enderman_takable=1, building_block=1, material_glass=1},
    sounds = mcl_sounds.node_sound_glass_defaults(),

    _mcl_blast_resistance = 0.1,
    _mcl_hardness = 0.1,
})




--end berry rock

minetest.register_node("mcl_better_end:end_berry_rock", {
    description = "End Berry Rock",
    tiles = {"end_berry_rock.png"},
    stack_max = 64,

    groups = {pickaxey=1, building_block=1, material_stone=1},
    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 9,
    _mcl_hardness = 3,
})


minetest.register_craft({
    output = 'mcl_better_end:end_berry_rock',
    recipe = {
        {'', 'mcl_end:end_stone', ''},
        {'mcl_end:end_stone', 'mcl_better_end:end_glow_berry', 'mcl_end:end_stone'},
        {'', 'mcl_end:end_stone', ''},
    }
})

minetest.register_node("mcl_better_end:end_berry_rock_bricks", {
    description = "End Berry Rock Bricks",
    tiles = {"end_berry_rock_bricks.png"},
    stack_max = 64,

    groups = {pickaxey=1, building_block=1, material_stone=1},
    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 9,
    _mcl_hardness = 3,
})

minetest.register_craft({
    output = 'mcl_better_end:end_berry_rock_bricks',
    recipe = {
        {'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock'},
        {'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock'},
        {'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock'},
    }
})

minetest.register_node("mcl_better_end:end_berry_rock_tailled", {
    description = "End Berry Rock Tailled",
    tiles = {"end_berry_rock_tailled.png"},
    stack_max = 64,

    groups = {pickaxey=1, building_block=1, material_stone=1},
    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 9,
    _mcl_hardness = 3,
})

minetest.register_craft({
    output = 'mcl_better_end:end_berry_rock_tailled',
    recipe = {
        {'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock'},
        {'mcl_better_end:end_berry_rock', 'mcl_better_end:end_glow_berry', 'mcl_better_end:end_berry_rock'},
        {'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock', 'mcl_better_end:end_berry_rock'},
    }
})