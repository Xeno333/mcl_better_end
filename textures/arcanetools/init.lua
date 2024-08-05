-- Enregistrement du minerai Nephrite
minetest.register_node("arcanetools:nephrite_ore", {
    description = "Nephrite Ore",
    tiles = {"end_stone_with_nephrite.png"},
    is_ground_content = true,
    groups = {cracky = 3},
    drop = 'arcanetools:nephrite_raw', -- Le minerai laisse tomber un morceau brut
})
-- Enregistrement du minerai brut
minetest.register_craftitem("arcanetools:nephrite_raw", {
    description = "Raw Nephrite",
    inventory_image = "nephrite_raw.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("arcanetools:nephrite_ingot", {
    description = "Nephrite Ingot",
    inventory_image = "nephrite_ore.png",
})

-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    type = "cooking",
    output = "arcanetools:nephrite_ingot",
    recipe = "arcanetools:nephrite_raw",
    cooktime = 1,
})

-- Outils
minetest.register_tool("arcanetools:nephrite_pickaxe", {
    description = "Nephrite Pickaxe",
    inventory_image = "nephrite_pick.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            cracky = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=300, maxlevel=20},
        },
        damage_groups = {fleshy=40},
    },
})

minetest.register_tool("arcanetools:nephrite_axe", {
    description = "Nephrite Axe",
    inventory_image = "nephrite_axe.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            choppy = {times={[1]=0.1, [2]=0.1, [3]=0.1}, uses=30, maxlevel=20},
        },
        damage_groups = {fleshy=4},
    },
})

-- Recettes pour les outils
minetest.register_craft({
    output = 'arcanetools:nephrite_pickaxe',
    recipe = {
        {'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot'},
        {'', 'mcl_core:stick', ''},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'arcanetools:nephrite_axe',
    recipe = {
        {'', 'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot'},
        {'', 'mcl_core:stick', 'arcanetools:nephrite_ingot'},
        {'', 'mcl_core:stick', ''},
    }
})

-- Armures
minetest.register_tool("arcanetools:nephrite_helmet", {
    description = "Nephrite Helmet",
    inventory_image = "nephrite_helmet.png",
    groups = {armor_head=1, armor_heal=12, armor_use=100, armor_fire=10},
    armor_groups = {fleshy=20},
    wear = 0,
    damage_groups = {cracky=2, snappy=1, level=3},
})

minetest.register_tool("arcanetools:nephrite_chestplate", {
    description = "Nephrite Chestplate",
    inventory_image = "nephrite_chestplate.png",
    groups = {armor_torso=1, armor_heal=12, armor_use=100, armor_fire=10},
    armor_groups = {fleshy=20},
    wear = 0,
    damage_groups = {cracky=2, snappy=1, level=3},
})

minetest.register_tool("arcanetools:nephrite_leggings", {
    description = "Nephrite Leggings",
    inventory_image = "nephrite_leggings.png",
    groups = {armor_legs=1, armor_heal=12, armor_use=100, armor_fire=10},
    armor_groups = {fleshy=20},
    wear = 0,
    damage_groups = {cracky=2, snappy=1, level=3},
})

minetest.register_tool("arcanetools:nephrite_boots", {
    description = "Nephrite Boots",
    inventory_image = "nephrite_boots.png",
    groups = {armor_feet=1, armor_heal=12, armor_use=100, armor_fire=10},
    armor_groups = {fleshy=20},
    wear = 0,
    damage_groups = {cracky=2, snappy=1, level=3},
})

-- Recettes pour les armures
minetest.register_craft({
    output = 'arcanetools:nephrite_helmet',
    recipe = {
        {'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot'},
        {'arcanetools:nephrite_ingot', '', 'arcanetools:nephrite_ingot'},
        {'', '', ''},
    }
})

minetest.register_craft({
    output = 'arcanetools:nephrite_chestplate',
    recipe = {
        {'arcanetools:nephrite_ingot', '', 'arcanetools:nephrite_ingot'},
        {'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot'},
        {'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot'},
    }
})

minetest.register_craft({
    output = 'arcanetools:nephrite_leggings',
    recipe = {
        {'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot', 'arcanetools:nephrite_ingot'},
        {'arcanetools:nephrite_ingot', '', 'arcanetools:nephrite_ingot'},
        {'arcanetools:nephrite_ingot', '', 'arcanetools:nephrite_ingot'},
    }
})

minetest.register_craft({
    output = 'arcanetools:nephrite_boots',
    recipe = {
        {'', '', ''},
        {'arcanetools:nephrite_ingot', '', 'arcanetools:nephrite_ingot'},
        {'arcanetools:nephrite_ingot', '', 'arcanetools:nephrite_ingot'},
    }
})

