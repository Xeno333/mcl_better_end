


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



minetest.register_tool("mcl_better_end:nightite_axe", {
    description = "Nightite Axe",
    inventory_image = "nightite_axe.png",
    _mcl_toollike_wield = true,
	wield_scale = wield_scale,
	groups = { tool=1, axe=1, dig_speed_class=6, enchantability=10, fire_immune=1 },
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=5,
		damage_groups = {fleshy=15},
		punch_attack_uses = 3000,
	},
	on_place = mcl_tools.tool_place_funcs.axe,
	sound = { breaks = "default_tool_breaks" },
	_repair_material = "mcl_better_end:nightite_ingot",
	_mcl_diggroups = {
		axey = { speed = 9, level = 6, uses = 3000 }
	},
})

minetest.register_tool("mcl_better_end:nightite_sword", {
    description = "Nightite Sword",
    inventory_image = "nightite_sword.png",
    _mcl_toollike_wield = true,
	wield_scale = cl_vars.tool_wield_scale,
	groups = { weapon=1, sword=1, dig_speed_class=5, enchantability=10 },
	tool_capabilities = {
		full_punch_interval = 0.600,
		max_drop_level=5,
		damage_groups = {fleshy=14},
		punch_attack_uses = 3000,
	},
	sound = { breaks = "default_tool_breaks" },
	on_place = mcl_tools.tool_place_funcs.sword,
	_repair_material = "mcl_better_end:nightite_ingot",
	_mcl_diggroups = {
		swordy = { speed = 8, level = 5, uses = 3000 },
		swordy_cobweb = { speed = 8, level = 5, uses = 3000 }
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
