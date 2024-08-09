-- Enregistrement du minerai Nephrite
minetest.register_node("mcl_better_end:nephrite_ore", {
    description = "Nephrite Ore",
    tiles = {"end_stone_with_nephrite.png"},
    is_ground_content = true,
    groups = {cracky = 3},
    drop = 'mcl_better_end:nephrite_raw', -- Le minerai laisse tomber un morceau brut
})
-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:nephrite_raw", {
    description = "Raw Nephrite",
    inventory_image = "nephrite_raw.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:nephrite_ingot", {
    description = "Nephrite Ingot",
    inventory_image = "nephrite_ingot.png",
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
