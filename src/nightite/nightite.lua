


-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:nightite_raw", {
    stack_max = 64,
    description = "Raw Nightite",
    inventory_image = "mcl_better_end_raw_nightite.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:nightite_ingot", {
    stack_max = 64,
    description = "Nightite Ingot",
    inventory_image = "mcl_better_end_nightite_ingot.png",
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
        "mcl_better_end_nightite_block.png",
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

mcl_tools.register_set("nightite", {
    craftable = true,
    material = "mcl_better_end:nightite_ingot",
    uses = 2000,
    level = 15,
    speed = 9,
    max_drop_level = 5,
    groups = { dig_class_speed = 18, enchantability = 60}
}, {
    ["sword"] = {
        description = ("Nightite Sword"),
        inventory_image = "nightite_sword.png",
        tool_capabilities = {
            full_punch_interval = 0.625,
            damage_groups = { fleshy = 10 }
        }
    },
    ["axe"] = {
        description = ("Nightite Axe"),
        inventory_image = "nightite_axe.png",
        tool_capabilities = {
            full_punch_interval = 1,
            damage_groups = { fleshy = 8 }
        }
    }
}, { _mcl_cooking_output = "mcl_better_end:nightite_raw" })


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
