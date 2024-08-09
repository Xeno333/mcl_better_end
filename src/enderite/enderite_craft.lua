-- Recettes pour les outils
minetest.register_craft({
    output = 'mcl_better_end:enderite_pickaxe',
    recipe = {
        {'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot'},
        {'', 'mcl_core:stick', ''},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:enderite_axe',
    recipe = {
        {'', 'mcl_better_end:enderite_ingot', 'mcl_better_end:enderite_ingot'},
        {'', 'mcl_core:stick', 'mcl_better_end:enderite_ingot'},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:enderite_sword',
    recipe = {
        {'', 'mcl_better_end:enderite_ingot', ''},
        {'', 'mcl_better_end:enderite_ingot', ''},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:enderite_shovel',
    recipe = {
        {'', 'mcl_better_end:enderite_ingot', ''},
        {'', 'mcl_core:stick', ''},
        {'', 'mcl_core:stick', ''},
    }
})
