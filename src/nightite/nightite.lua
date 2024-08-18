


-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:nightite_raw", {
    stack_max = 64,
    description = "Raw Nightite",
    inventory_image = "raw_nightite.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:nightite_ingot", {
    stack_max = 64,
    description = "Nightite Ingot",
    inventory_image = "nightite_ingot.png",
})


minetest.register_craft({
    output = 'mcl_better_end:nightite_ingot',
    recipe = {
        {'', 'mcl_better_end:nightite_raw', ''},
        {'mcl_better_end:nightite_raw', 'mcl_better_end:nephrite_ingot', 'mcl_better_end:nightite_raw'},
        {'', 'mcl_better_end:nightite_raw', ''},
    }
})

minetest.register_node("mcl_better_end:nightite_block", {
    description = "Nightite Blocke",
    tiles = {
        "nightite_block.png",
    },
    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 90,

    groups = {pickaxey=4, building_block=1, material_stone=1},
})


-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    output = 'mcl_better_end:nightite_block',
    recipe = {
        {'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot'},
        {'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot'},
        {'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot'},
    }
})

-- Outils
minetest.register_tool("mcl_better_end:nightite_pickaxe", {
    description = "Nightite Pickaxe",
    inventory_image = "nightite_pick.png",
    _mcl_toollike_wield = true,
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
    description = "Nightite Axe",
    inventory_image = "nightite_axe.png",
    _mcl_toollike_wield = true,
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
    description = "Nightite Sword",
    inventory_image = "nightite_sword.png",
    _mcl_toollike_wield = true,
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
    description = "Nightite Shovel",
    inventory_image = "nightite_shovel.png",
    _mcl_toollike_wield = true,
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=300, maxlevel=30},
        },
        damage_groups = {fleshy=7},
    },
})



mcl_armor.register_set({
    name = "nightite",
    description = "Nightite",
    durability = 1000,
    enchantability = 10,
    points = {
            head = 5,
            torso = 11,
            legs = 8,
            feet = 5,
    },
    groups = { fire_immune=1 },
    toughness = 2,
    craft_material = "mcl_better_end:nightite_ingot",
    sound_equip = "mcl_armor_equip_diamond",
    sound_unequip = "mcl_armor_unequip_diamond",
})
