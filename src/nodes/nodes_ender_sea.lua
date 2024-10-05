minetest.register_node("mcl_better_end:ender_water", {
    description = "Ender Water",

	drawtype = "liquid",
	paramtype = "light",
	liquidtype = "source",
	use_texture_alpha = "blend",
	drop = "",
	post_effect_color = {a = 64, r = 100, g = 100, b = 200},
    
	tiles = {{
		name = "mcl_better_end_ender_water.png", 
		animation = {
			type = "vertical_frames", 
			aspect_w = 32, 
			aspect_h = 32, 
			length = 3,
		},
	}, },
	special_tiles = { {
		name = "mcl_better_end_ender_water.png", 
		animation = {
			type = "vertical_frames", 
			aspect_w = 32, 
			aspect_h = 32, 
			length = 3,
		},
		backface_culling = false,
	}, },
	
    liquid_alternative_flowing = "mcl_better_end:ender_water",
    liquid_alternative_source = "mcl_better_end:ender_water",
    
	drowning = 0,
    liquid_range = 0,

	sounds = mcl_sounds.node_sound_water_defaults(),
    
    liquid_renewable = false,
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
    light_source = 6,  -- This makes the block emit light

	liquid_viscosity = 2,
	groups = { water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1, melt_around=1, dig_by_piston=1, mbe_ender_sea=1},
	_mcl_blast_resistance = 100,
	_mcl_hardness = -1,

})