-- Recettes pour les outils
minetest.register_craft({
    output = 'mcl_better_end:nightite_pickaxe',
    recipe = {
        {'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot'},
        {'', 'mcl_core:stick', ''},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:nightite_axe',
    recipe = {
        {'', 'mcl_better_end:nightite_ingot', 'mcl_better_end:nightite_ingot'},
        {'', 'mcl_core:stick', 'mcl_better_end:nightite_ingot'},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:nightite_sword',
    recipe = {
        {'', 'mcl_better_end:nightite_ingot', ''},
        {'', 'mcl_better_end:nightite_ingot', ''},
        {'', 'mcl_core:stick', ''},
    }
})

minetest.register_craft({
    output = 'mcl_better_end:nightite_shovel',
    recipe = {
        {'', 'mcl_better_end:nightite_ingot', ''},
        {'', 'mcl_core:stick', ''},
        {'', 'mcl_core:stick', ''},
    }
})
