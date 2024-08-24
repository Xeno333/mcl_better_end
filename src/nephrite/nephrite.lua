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

    groups = {pickaxey=4, building_block=1, material_stone=1, mbe_plains=1},
})



-- Enregistrement du minerai brut
minetest.register_craftitem("mcl_better_end:nephrite_raw", {
    stack_max = 64,
    description = "Raw Nephrite",
    inventory_image = "raw_nephrite.png",
})

-- Enregistrement du lingot
minetest.register_craftitem("mcl_better_end:nephrite_ingot", {
    stack_max = 64,
    description = "Nephrite Ingot",
    inventory_image = "nephrite.png",
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




minetest.register_tool("mcl_better_end:nephrite_sword", {
    description = "Nephrite Axe",
    inventory_image = "nephrite_axe.png",
    _mcl_toollike_wield = true,
	wield_scale = mcl_vars.tool_wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=6, enchantability=10, fire_immune=1 },
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=5,
		damage_groups = {fleshy=14},
		punch_attack_uses = 2500,
	},
	on_place = mcl_tools.tool_place_funcs.axe,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_better_end:nephrite_ingot",
	_mcl_diggroups = {
		axey = { speed = 9, level = 6, uses = 2500 }
	},
})

minetest.register_tool("mcl_better_end:nephrite_sword", {
    description = "Nephrite Sword",
    inventory_image = "nephrite_sword.png",
    _mcl_toollike_wield = true,
	wield_scale = mcl_vars.tool_wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=5, enchantability=10 },
	tool_capabilities = {
		full_punch_interval = 0.600,
		max_drop_level=5,
		damage_groups = {fleshy=13},
		punch_attack_uses = 2500,
	},
	sound = { breaks = "default_tool_breaks" },
	on_place = mcl_tools.tool_place_funcs.sword,
	_repair_material = "mcl_better_end:nephrite_ingot",
	_mcl_diggroups = {
		swordy = { speed = 8, level = 5, uses = 2500 },
		swordy_cobweb = { speed = 8, level = 5, uses = 2500 }
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
