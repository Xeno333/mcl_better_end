mcl_better_end.biomes.oasis = {}


minetest.register_node("mcl_better_end:end_stone_oasis_turf", {
    description = "End Stone with Blue Mold",
    tiles = {
        "end_stone_oasis_turf_top.png",   -- Top texture
        "mcl_end_end_stone.png",   -- Bottom texture
        "mcl_end_end_stone.png^end_stone_oasis_turf_side.png",   -- Side texture 1
        "mcl_end_end_stone.png^end_stone_oasis_turf_side.png",   -- Side texture 2
        "mcl_end_end_stone.png^end_stone_oasis_turf_side.png",   -- Side texture 3
        "mcl_end_end_stone.png^end_stone_oasis_turf_side.png",   -- Side texture 4
    },
    stack_max = 64,

    drop = "mcl_end:end_stone",
    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 9,
    _mcl_hardness = 3,
    _mcl_silk_touch_drop = true,
    light_source = 0,

    groups = {pickaxey=1, building_block=1, material_stone=1},
})


mcl_better_end.biomes.oasis.tree_schem = {
    "/oasis_tree_1.mts",
    "/oasis_tree_2.mts",
    "/oasis_tree_3.mts",
    "/oasis_tree_4.mts",
}

minetest.register_node("mcl_better_end:custom_sapling", {
    description = "Oasis Sapling",
    drawtype = "plantlike",
    tiles = {"oasis_sapling.png"},

    groups = {snappy = 2, dig_immediate = 3, attached_node = 1, sapling = 1, flammable = 2},

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random(300, 1500))
    end,
    on_timer = function(pos)
        -- Check if the sapling is on the correct turf
        local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}
        local below_node = minetest.get_node(below_pos).name

        if below_node == "mcl_better_end:end_stone_oasis_turf" then
			minetest.set_node(pos, {name = "air"})
            -- Randomly select a tree schematic
            local schematics = mcl_better_end.biomes.oasis.tree_schem
            local random_schem = mcl_better_end.schematic_loc .. schematics[math.random(#schematics)]

            -- Place the schematic at the sapling's position
            minetest.place_schematic(pos, random_schem, "random", nil, true)
        end
    end,

    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3},
    },
    sounds = mcl_sounds.node_sound_leaves_defaults(),
})



minetest.register_node("mcl_better_end:end_oasis_trunk", {
    description = "Blue Trunk",
    tiles = {
        "blue_end_trunk.png",
    },
    stack_max = 64,
    paramtype2 = "facedir",
	on_place = mcl_util.rotate_axis,

    sounds = mcl_sounds.node_sound_wood_defaults(),

    _mcl_blast_resistance = 9,
    _mcl_hardness = 3,
    light_source = 0,

    groups = {axey=1, building_block=1},
})


minetest.register_node("mcl_better_end:end_oasis_leaves", {
    description = "Blue Leaves",
    drawtype = "allfaces_optional",
    paramtype = "light",
    is_ground_content = false,
    tiles = {
        "blue_end_tree_leaves.png",   -- Top texture
    },
    _mcl_silk_touch_drop = true,
    stack_max = 64,
    sounds = mcl_sounds.node_sound_leaves_defaults(),

    light_source = 5,

    drop = {
        max_items = 1,
        items = {
            {
                items = {"mcl_better_end:custom_sapling"},
                rarity = 20, -- 1 in 100 chance to drop
            },
        }
    },

    groups = {building_block=1, mbe_plains=1},
})

minetest.register_node("mcl_better_end:end_oasis_grass", {
	description = ("Ender Oasis Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"end_oasis_grass.png"},
	inventory_image = "end_oasis_grass.png",
	wield_image = "end_oasis_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 4,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})













minetest.register_node("mcl_better_end:end_glow_berry_plant", {
	description = ("Ender Glow Berry Plant"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"end_glow_berry_plant.png"},
	inventory_image = "end_glow_berry_plant.png",
	wield_image = "end_glow_berry_plant.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 10,
    _mcl_silk_touch_drop = true,
    drop = {
        max_items = 4,
        items = {
            {
                items = {"mcl_better_end:end_glow_berry"},
                rarity = 1, -- 1 in 100 chance to drop
            },
            {
                items = {"mcl_better_end:end_glow_berry"},
                rarity = 2, -- 1 in 100 chance to drop
            },
            {
                items = {"mcl_better_end:end_glow_berry"},
                rarity = 4, -- 1 in 100 chance to drop
            },
            {
                items = {"mcl_better_end:end_glow_berry"},
                rarity = 6, -- 1 in 100 chance to drop
            },
        }
    },
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})

minetest.register_node("mcl_better_end:end_glow_berry_plant_1", {
	description = ("Ender Glow Berry Plant"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"end_glow_berry_plant_1.png"},
	inventory_image = "end_glow_berry_plant_1.png",
	wield_image = "end_glow_berry_plant_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 4,
    drop = nil,
    _mcl_silk_touch_drop = true,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})

minetest.register_node("mcl_better_end:end_glow_berry_plant_2", {
	description = ("Ender Glow Berry Plant"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"end_glow_berry_plant_2.png"},
	inventory_image = "end_glow_berry_plant_2.png",
	wield_image = "end_glow_berry_plant_2.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 6,
    drop = {
        max_items = 1,
        items = {
            {
                items = {"mcl_better_end:end_glow_berry"},
                rarity = 20, -- 1 in 100 chance to drop
            },
        }
    },
    _mcl_silk_touch_drop = true,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})

minetest.register_node("mcl_better_end:end_glow_berry_plant_3", {
	description = ("Ender Glow Berry Plant"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"end_glow_berry_plant_3.png"},
	inventory_image = "end_glow_berry_plant_3.png",
	wield_image = "end_glow_berry_plant_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
    light_source = 8,
    drop = {
        max_items = 2,
        items = {
            {
                items = {"mcl_better_end:end_glow_berry"},
                rarity = 20, -- 1 in 100 chance to drop
            },
            {
                items = {"mcl_better_end:end_glow_berry"},
                rarity = 40, -- 1 in 100 chance to drop
            },
        }
    },
    _mcl_silk_touch_drop = true,
	groups = {dig_immediate=3, shearsy=1, dig_by_water=1, destroy_by_lava_flow=1, dig_by_piston=1, deco_block=1, compostability=50},
	sounds = mcl_sounds.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
})

minetest.register_abm({
	label = "Grow Glow Berry Plant",
	nodenames = {"mcl_better_end:end_glow_berry_plant_1", "mcl_better_end:end_glow_berry_plant_2", "mcl_better_end:end_glow_berry_plant_3"},
	interval = 20,
	chance = 5,
	action = function(pos, node)
		if node.name == "mcl_better_end:end_glow_berry_plant_1" then
			minetest.set_node(pos, {name = "mcl_better_end:end_glow_berry_plant_2"})
		elseif node.name == "mcl_better_end:end_glow_berry_plant_2" then
			minetest.set_node(pos, {name = "mcl_better_end:end_glow_berry_plant_3"})
		elseif node.name == "mcl_better_end:end_glow_berry_plant_3" then
			minetest.set_node(pos, {name = "mcl_better_end:end_glow_berry_plant"})
		end
	end,
})


minetest.register_craftitem("mcl_better_end:end_glow_berry", {
    description = "Glow Berry", -- The name of the food item
    inventory_image = "end_glow_berry.png", -- The texture of the food item
	_mcl_saturation = 1,
	on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type == "node" then
                if minetest.get_node(pointed_thing.under).name == "mcl_better_end:end_stone_oasis_turf" and minetest.get_node(pointed_thing.above).name == "air" then
                    minetest.set_node(pointed_thing.above, {name = "mcl_better_end:end_glow_berry_plant_1"})
                    itemstack:take_item(1)
                    return itemstack
                end
            else
                minetest.item_eat(1)
            end
        end,
	on_secondary_use = minetest.item_eat(1),
    groups = {food = 2, eatable = 1}, -- Item groups, 'food' and 'eatable' are important for food items

    stack_max = 64, -- Maximum number of items per stack
})












--liquid

minetest.register_node("mcl_better_end:ender_water_real", {
    description = "Ender Water",

	drawtype = "liquid",
	paramtype = "light",
	liquidtype = "source",
	use_texture_alpha = "blend",
	drop = "",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
    
	tiles = {{
		name = "ender_water.png", 
		animation = {
			type = "vertical_frames", 
			aspect_w = 32, 
			aspect_h = 32, 
			length = 3,
		},
	}, },
	special_tiles = { {
		name = "ender_water.png", 
		animation = {
			type = "vertical_frames", 
			aspect_w = 32, 
			aspect_h = 32, 
			length = 3,
		},
		backface_culling = false,
	}, },
	
    liquid_alternative_flowing = "mcl_better_end:ender_water_real_flowing",
    liquid_alternative_source = "mcl_better_end:ender_water_real",
    
	drowning = 0,
    liquid_range = 5,

	sounds = mcl_sounds.node_sound_water_defaults(),
    
    liquid_renewable = false,
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
    light_source = 4,  -- This makes the block emit light

	liquid_viscosity = 2,
	groups = { water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1, melt_around=1, dig_by_piston=1, mbe_ender_sea=1},
	_mcl_blast_resistance = 100,
	_mcl_hardness = -1,

})

minetest.register_node("mcl_better_end:ender_water_real_flowing", {
    description = "Ender Water",

	drawtype = "flowingliquid",
	paramtype = "light",
	liquidtype = "flowing",
	use_texture_alpha = "blend",
	drop = "",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
    
	tiles = {{
		name = "ender_water.png", 
		animation = {
			type = "vertical_frames", 
			aspect_w = 32, 
			aspect_h = 32, 
			length = 3,
		},
	}, },
	special_tiles = { {
		name = "ender_water.png", 
		animation = {
			type = "vertical_frames", 
			aspect_w = 32, 
			aspect_h = 32, 
			length = 3,
		},
		backface_culling = false,
	}, },
	
    liquid_alternative_flowing = "mcl_better_end:ender_water_real_flowing",
    liquid_alternative_source = "mcl_better_end:ender_water_real",
    
	drowning = 0,
    liquid_range = 5,

	sounds = mcl_sounds.node_sound_water_defaults(),
    
    liquid_renewable = false,
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
    light_source = 4,  -- This makes the block emit light

	liquid_viscosity = 2,
	groups = { water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1, melt_around=1, dig_by_piston=1, mbe_ender_sea=1},
	_mcl_blast_resistance = 100,
	_mcl_hardness = -1,

})
minetest.register_node("mcl_better_end:blublu_block", {
    description = "Blublu Block",
    tiles = {
        "blublu_block.png",
    },
    stack_max = 64,
	paramtype2 = "facedir",
	on_place = mcl_util.rotate_axis,

    drop = "mcl_end:end_stone",
    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 5,
    _mcl_hardness = 2,
    light_source = 0,

	groups = {pickaxey=1, building_block=1, material_stone=1, purpur_block=1},
})

minetest.register_craft({
    output = 'mcl_better_end:blublu_block',
    recipe = {
        {'', 'mcl_better_end:end_glow_berry', ''},
        {'mcl_better_end:end_glow_berry', 'mcl_end:end_stone', 'mcl_better_end:end_glow_berry'},
        {'', 'mcl_better_end:end_glow_berry', ''},
    }
})


minetest.register_node("mcl_better_end:blublu_pillar", {
    description = "Blublu Piller",
    tiles = {
        "blublu_pillar_top.png",
        "blublu_pillar_top.png",
        "blublu_pillar.png",
    },
    stack_max = 64,
	paramtype2 = "facedir",
	on_place = mcl_util.rotate_axis,

    drop = "mcl_end:end_stone",
    sounds = mcl_sounds.node_sound_stone_defaults(),

    _mcl_blast_resistance = 5,
    _mcl_hardness = 2,
    light_source = 0,

	groups = {pickaxey=1, building_block=1, material_stone=1, purpur_block=1},
})


mcl_stairs.register_stair("blublu_block", "mcl_better_end:blublu_block",
                {pickaxey=1, material_stone=1},
                {"blublu_block.png"},
                "Blublu Stairs",
                mcl_sounds.node_sound_stone_defaults(), 6, 1.5,
                nil)
mcl_stairs.register_slab("blublu_block", "mcl_better_end:blublu_block",
                {pickaxey=1, material_stone=1},
                {"blublu_block.png"},
                "Blublu Slab",
                mcl_sounds.node_sound_stone_defaults(), 6, 2,
                "Double Blublu Slab")
