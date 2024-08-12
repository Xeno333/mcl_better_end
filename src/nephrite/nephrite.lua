-- Enregistrement du minerai Nephrite
minetest.register_node("mcl_better_end:nephrite_ore", {
    description = "Nephrite Ore",
    tiles = {
        "mcl_end_end_stone.png^nephrite_ore.png",
    },
    drop = 'mcl_better_end:nephrite_raw', -- Le minerai laisse tomber un morceau brut

    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 70,
    _mcl_silk_touch_drop = true,
    light_source = 2,  -- This makes the block emit light

    groups = {pickaxey=7, building_block=1, material_stone=1, mbe_plains=1},
})



-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:nephrite_raw", {
    stack_max = 64,
    description = "Raw Nephrite",
    inventory_image = "nephrite_raw.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:nephrite_ingot", {
    stack_max = 64,
    description = "Nephrite Ingot",
    inventory_image = "nephrite_ingot.png",
})



minetest.register_craft({
    output = 'mcl_better_end:nephrite_ingot',
    recipe = {
        {'mcl_better_end:nephrite_raw', 'mcl_better_end:nephrite_raw', 'mcl_better_end:nephrite_raw'},
        {'mcl_better_end:nephrite_raw', 'mcl_better_end:enderite_ingot', 'mcl_better_end:nephrite_raw'},
        {'', 'mcl_better_end:nephrite_raw', ''},
    }
})


minetest.register_node("mcl_better_end:nephrite_block", {
    description = "Nephrite Blocke",
    tiles = {
        "nephrite_block.png",
    },
    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 80,

    groups = {pickaxey=4, building_block=1, material_stone=1},
})


-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    output = 'mcl_better_end:nephrite_block',
    recipe = {
        {'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot'},
        {'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot'},
        {'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot'},
    }
})

-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    type = "cooking",
    output = "mcl_better_end:nephrite_ingot",
    recipe = "mcl_better_end:nephrite_raw",
    cooktime = 1,
})

-- Outils
minetest.register_tool("mcl_better_end:nephrite_pickaxe", {
    description = "Nephrite Pickaxe",
    inventory_image = "nephrite_pick.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            cracky = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=300, maxlevel=30},
        },
        damage_groups = {fleshy=7},
    },
})

minetest.register_tool("mcl_better_end:nephrite_axe", {
    description = "Nephrite Axe",
    inventory_image = "nephrite_axe.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=3000, maxlevel=30},
        },
        damage_groups = {fleshy=11},
    },
})

minetest.register_tool("mcl_better_end:nephrite_sword", {
    description = "Nephrite Sword",
    inventory_image = "nephrite_sword.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=3000, maxlevel=30},
        },
        damage_groups = {fleshy=10},
    },
})

minetest.register_tool("mcl_better_end:nephrite_shovel", {
    description = "Nephrite Shovel",
    inventory_image = "nephrite_shovel.png",
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
    name = "nephrite",
    description = "Nephrite",
    durability = 700,
    enchantability = 10,
    points = {
            head = 4,
            torso = 10,
            legs = 7,
            feet = 4,
    },
    groups = { fire_immune=1 },
    toughness = 2,
    craft_material = "mcl_better_end:nightite_ingot",
    sound_equip = "mcl_armor_equip_diamond",
    sound_unequip = "mcl_armor_unequip_diamond",
})
