-- Recettes pour les outils
minetest.register_craft({
    output = 'mcl_better_end:nephrite_pickaxe',
    recipe = {
        {'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot'},
        {'', 'mcl_core:stick', ''},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:nephrite_ingot',
    recipe = {
        {'mcl_better_end:nephrite_raw', 'mcl_better_end:nephrite_raw', 'mcl_better_end:nephrite_raw'},
        {'mcl_better_end:nephrite_raw', 'mcl_better_end:nephrite_raw', 'mcl_better_end:nephrite_raw'},
        {'', 'mcl_better_end:nephrite_raw', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:nephrite_axe',
    recipe = {
        {'', 'mcl_better_end:nephrite_ingot', 'mcl_better_end:nephrite_ingot'},
        {'', 'mcl_core:stick', 'mcl_better_end:nephrite_ingot'},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:nephrite_sword',
    recipe = {
        {'', 'mcl_better_end:nephrite_ingot', ''},
        {'', 'mcl_better_end:nephrite_ingot', ''},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:nephrite_shovel',
    recipe = {
        {'', 'mcl_better_end:nephrite_ingot', ''},
        {'', 'mcl_core:stick', ''},
        {'', 'mcl_core:stick', ''},
    }
})
