-- Enregistrement du minerai enderite
minetest.register_node("mcl_better_end:enderite_ore", {
    description = "Enderite Ore",
    tiles = {
        "mcl_end_end_stone.png^enderite_ore.png",
    },
    drop = 'mcl_better_end:enderite_raw', -- Le minerai laisse tomber un morceau brut

    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 70,
    _mcl_silk_touch_drop = true,
    light_source = 2,  -- This makes the block emit light

    groups = {pickaxey=7, building_block=1, material_stone=1, mbe_plains=1},
})



-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:enderite_raw", {
    stack_max = 64,
    description = "Raw enderite",
    inventory_image = "raw_enderite.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:enderite_ingot", {
    stack_max = 64,
    description = "Enderite Ingot",
    inventory_image = "enderite_ingot.png",
})

-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    output = 'mcl_better_end:enderite_ingot',
    recipe = {
        {'mcl_better_end:enderite_raw', 'mcl_better_end:enderite_raw', 'mcl_better_end:enderite_raw'},
        {'mcl_better_end:enderite_raw', 'mcl_better_end:ender_shard', 'mcl_better_end:enderite_raw'},
        {'mcl_better_end:enderite_raw', 'mcl_better_end:enderite_raw', 'mcl_better_end:enderite_raw'},
    }
})


minetest.register_node("mcl_better_end:enderite_block", {
    description = "Enderite Blocke",
    tiles = {
        "enderite_block.png",
    },
    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 70,

    groups = {pickaxey=4, building_block=1, material_stone=1},
})


-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    output = 'mcl_better_end:enderite_block',
    recipe = {
        {'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot'},
        {'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot'},
        {'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot'},
    }
})

-- Outils
minetest.register_tool("mcl_better_end:enderite_pickaxe", {
    description = "Enderite Pickaxe",
    inventory_image = "enderite_pick.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            cracky = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=300, maxlevel=30},
        },
        damage_groups = {fleshy=7},
    },
})

minetest.register_tool("mcl_better_end:enderite_axe", {
    description = "Enderite Axe",
    inventory_image = "enderite_axe.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=3000, maxlevel=30},
        },
        damage_groups = {fleshy=11},
    },
})

minetest.register_tool("mcl_better_end:enderite_sword", {
    description = "Enderite Sword",
    inventory_image = "enderite_sword.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=3000, maxlevel=30},
        },
        damage_groups = {fleshy=10},
    },
})

minetest.register_tool("mcl_better_end:enderite_shovel", {
    description = "Enderite Shovel",
    inventory_image = "enderite_shovel.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=300, maxlevel=30},
        },
        damage_groups = {fleshy=7},
    },
})








--armor

mcl_armor.register_set({
    name = "enderite",
    description = "Enderite",
    durability = 600,
    enchantability = 10,
    points = {
            head = 4,
            torso = 10,
            legs = 7,
            feet = 4,
    },
    groups = { fire_immune=1 },
    toughness = 2,
    craft_material = "mcl_better_end:enderite_ingot",
    sound_equip = "mcl_armor_equip_diamond",
    sound_unequip = "mcl_armor_unequip_diamond",
})
