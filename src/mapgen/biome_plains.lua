

	minetest.register_decoration({
		name = "mcl_better_end:end_grass",
		deco_type = "simple",
		place_on = {"mcl_end:end_stone"},
		flags = "all_floors",
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.024,
			spread = {x = 100, y = 100, z = 100},
			seed = 257,
			octaves = 3,
			persist = 0.6
		},
		y_min = mcl_vars.mg_end_min,
		y_max = mcl_vars.mg_end_max,w
		decoration = "mcl_flowers:tallgrass",
		height = 1,
		height_max = 8,
		biomes = {"End", "EndMidlands", "EndHighlands", "EndBarrens", "EndSmallIslands"},
	})
