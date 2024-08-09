-- Enregistrement du minerai enderite
minetest.register_node("mcl_better_end:enderite_ore", {
    description = "enderite Ore",
    tiles = {"end_stone_with_enderite.png"},
    is_ground_content = true,
    groups = {cracky = 3},
    drop = 'mcl_better_end:enderite_raw', -- Le minerai laisse tomber un morceau brut
})
-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:enderite_raw", {
    description = "Raw enderite",
    inventory_image = "enderite_raw.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:enderite_ingot", {
    description = "enderite Ingot",
    inventory_image = "enderite_ingot.png",
})

-- Recette de cuisson pour obtenir le lingot
minetest.register_craft({
    type = "cooking",
    output = "mcl_better_end:enderite_ingot",
    recipe = "mcl_better_end:enderite_raw",
    cooktime = 1,
})

-- Outils
minetest.register_tool("mcl_better_end:enderite_pickaxe", {
    description = "enderite Pickaxe",
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
    description = "enderite Axe",
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
    description = "enderite Sword",
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
    description = "enderite Shovel",
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
