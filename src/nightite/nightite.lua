-- Enregistrement du minerai nightite
minetest.register_node("mcl_better_end:nightite_ore", {
    description = "nightite Ore",
    tiles = {
        "nightite_ore.png",
    },
    drop = 'mcl_better_end:nightite_raw', -- Le minerai laisse tomber un morceau brut

    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 70,
    light_source = 10,  -- This makes the block emit light

    groups = {pickaxey=7, building_block=1, material_stone=1, mbe_plains=1},
})


-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:nightite_raw", {
    description = "Raw nightite",
    inventory_image = "nightite_raw.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:nightite_ingot", {
    description = "nightite Ingot",
    inventory_image = "nightite_ingot.png",
})

-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    type = "cooking",
    output = "mcl_better_end:nightite_ingot",
    recipe = "mcl_better_end:nightite_raw",
    cooktime = 1,
})

-- Outils
minetest.register_tool("mcl_better_end:nightite_pickaxe", {
    description = "nightite Pickaxe",
    inventory_image = "nightite_pick.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            cracky = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=300, maxlevel=30},
        },
        damage_groups = {fleshy=7},
    },
})

minetest.register_tool("mcl_better_end:nightite_axe", {
    description = "nightite Axe",
    inventory_image = "nightite_axe.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=3000, maxlevel=30},
        },
        damage_groups = {fleshy=11},
    },
})

minetest.register_tool("mcl_better_end:nightite_sword", {
    description = "nightite Sword",
    inventory_image = "nightite_sword.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=3000, maxlevel=30},
        },
        damage_groups = {fleshy=10},
    },
})

minetest.register_tool("mcl_better_end:nightite_shovel", {
    description = "nightite Shovel",
    inventory_image = "nightite_shovel.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=300, maxlevel=30},
        },
        damage_groups = {fleshy=7},
    },
})
