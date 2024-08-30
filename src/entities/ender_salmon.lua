local S = minetest.get_translator(minetest.get_current_modname())

local ender_salmon = {
	description = S("Ender Salmon"),
	type = "animal",
	spawn_class = "water_ambient",
	can_despawn = true,
	passive = true,
	hp_min = 3,
	hp_max = 3,
	xp_min = 1,
	xp_max = 3,
	armor = 100,
	spawn_in_group = 5,
	tilt_swim = true,
	collisionbox = {-0.4, 0.0, -0.4, 0.4, 0.79, 0.4},
	visual = "mesh",
	mesh = "extra_mobs_salmon.b3d",
	textures = {
		{"extra_mobs_salmon.png"},
	},
	sounds = {
	},
	animation = {
		stand_start = 1, stand_end = 20,
		walk_start = 1, walk_end = 20,
		run_start = 1, run_end = 20,
	},
	drops = {
		{name = "mcl_fishing:salmon_raw",
		chance = 1,
		min = 1,
		max = 1,},
		{name = "mcl_bone_meal:bone_meal",
		chance = 20,
		min = 1,
		max = 1,},
	},
	visual_size = {x=3, y=3},
	makes_footstep_sound = false,
	swim = true,
	fly = true,
	fly_in = "mcl_better_end:ender_water",
	jump = false,
	view_range = 16,
	runaway = true,

	on_punch = function(self, hitter)
		local pos = self.object:get_pos()
		local max_attempts = 64
		local attempts = 0
		local teleported = false

		while not teleported and attempts < max_attempts do
			local new_pos = {
				x = pos.x + math.random(-5, 5),
				y = pos.y + math.random(-1, 1),
				z = pos.z + math.random(-5, 5),
			}

			local node_at_new_pos = minetest.get_node(new_pos).name
			local node_under_new_pos = minetest.get_node({x = new_pos.x, y = new_pos.y + -1, z = new_pos.z}).name

			if node_at_new_pos == "mcl_better_end:ender_water" or (node_under_new_pos ~= "air" and node_at_new_pos == "air") then
				self.object:set_pos(new_pos)
				minetest.add_particle({
					pos = pos,
					expirationtime = 1.0,
					minsize = 1,
					maxsize = 3,
					collisiondetection = false,
					texture = "mcl_portals_particle"..math.random(1, 5)..".png",
				})
				minetest.sound_play("mobs_mc_enderman_teleport_src", {pos = new_pos, gain = 1.0, max_hear_distance = 10})
				teleported = true
			end
			attempts = attempts + 1
		end
	end,
}

mcl_mobs.register_mob("mcl_better_end:ender_salmon", ender_salmon)

mcl_mobs.spawn_setup({
	name = "mcl_better_end:ender_salmon",
	type_of_spawning = "water",
	dimension = "end",
	min_height = mobs_mc.water_level - 16,
	max_height = mobs_mc.water_level + 1,
	min_light = 0,
	max_light = minetest.LIGHT_MAX + 1,
	aoc = 7,
	chance = 260,
})

-- spawn egg
mcl_mobs.register_egg("mcl_better_end:ender_salmon", S("Ender Salmon"), "#a00f10", "#0e8474", 0)

ender_salmon.on_step = function(self, dtime)
    -- Custom swimming logic
    local pos = self.object:get_pos()

    -- Make the salmon move in a sine wave pattern for more natural movement
    local wave_amplitude = 1.5  -- How much it deviates from the path
    local wave_frequency = 2.0  -- How fast it "wiggles"
    
    local new_x = pos.x + math.sin(minetest.get_gametime() * wave_frequency) * wave_amplitude
    local new_z = pos.z + math.cos(minetest.get_gametime() * wave_frequency) * wave_amplitude
    local new_y = pos.y + math.sin(minetest.get_gametime() * wave_frequency * 0.5) * (wave_amplitude / 2)

    -- Apply new position
    self.object:set_velocity({
        x = (new_x - pos.x) * dtime * 10,
        y = (new_y - pos.y) * dtime * 10,
        z = (new_z - pos.z) * dtime * 10,
    })
end
