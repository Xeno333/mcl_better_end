
local YMAX = -10000--mcl_vars.mg_end_max
local YMAX_biome = -25000--mcl_vars.mg_end_max
local YMIN = -27050--mcl_vars.mg_end_min

local cave_light_level = 4
local light_level = 10

local biome_size = 200

--Needed for context for some reason
local perlin
local perlin_l



--api

mcl_better_end.mapgen.registered_nodes = {
    end_stone = minetest.get_content_id("mcl_end:end_stone"),
    air = minetest.get_content_id("air"),
    sea = minetest.get_content_id("mcl_better_end:ender_water"),
}

--API
mcl_better_end.api.register_biome = function(e)
    mcl_better_end.biomes[#mcl_better_end.biomes + 1] = e
end



mcl_better_end.api.consts.sea_starts = -0.5
mcl_better_end.api.consts.sea_ends = -1


mcl_better_end.api.is_cave = function(noise, noise2)
    return (noise >= 0.8) or (noise2 >= 0.8)
end

mcl_better_end.api.is_island = function(noise)
    return (noise > 0.5 and noise < 0.8)
end

mcl_better_end.api.is_sea = function(noise)
    return noise < mcl_better_end.api.consts.sea_starts
end

mcl_better_end.api.is_free = function(noise)
    return not (noise >= 0.8 or (noise > 0.5 and noise < 0.8) or noise < -0.5)
end



--mapgen
local np_perlin_3d, noise_size, perlin_map, noise_map

minetest.register_on_joinplayer(
    function() 
        perlin = minetest.get_perlin({
            offset = 0,
            scale = 1,
            spread = {x = biome_size, y = biome_size/2, z = biome_size},
            seed = minetest.get_mapgen_setting("seed"),
            octaves = 3,
            persist = 0.5
        })
        -- Define the Perlin noise parameters
        np_perlin_3d = {
            offset = 0,
            scale = 1,
            spread = {x = 50, y = 20, z = 50},
            seed = minetest.get_mapgen_setting("seed"),
            octaves = 3,
            persist = 0.5
        }
        noise_size = {x = 80, y = 80, z = 80}
        perlin_map = minetest.get_perlin_map(np_perlin_3d, noise_size)
        
    end
)







--Genwe 

-- Mapgen Generation Function
function mcl_better_end.mapgen.gen(minp, maxp, seed)
    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()
    local light_data = vm:get_light_data()
    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)
    maxp.y = maxp.y - 1
    
        -- Create the PerlinNoiseMap object
        
        -- Calculate the 3D noise map
        noise_map = perlin_map:get_3d_map({x=minp.x,y=minp.y,z=minp.z})
-- Main generation loop
if minp.y > YMAX_biome then
    for y = maxp.y, minp.y, -1 do
        for z = maxp.z, minp.z, -1 do
            for x = maxp.x, minp.x, -1 do
                local vi = area:index(x, y, z)
                local noise = noise_map[x-minp.x+1][y-minp.y+1][z-minp.z+1]
                
                if not mcl_better_end.api.is_island(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    light_data[vi] = light_level
                else
                    data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone
                    for _, f in pairs(mcl_better_end.mapgen.ores) do
                        if y >= f.ymin and y <= f.ymax then
                            --f.gen(data, vi, area, pr, x, y, z, noise_map)
                        end
                    end
                end
            end
        end
    end
        vm:set_data(data)
        vm:set_light_data(light_data)
        vm:write_to_map()
        vm:update_map()
        return
    end
    
    local noises = {l={}, m={}}

    for y = maxp.y, minp.y, -1 do
        if not noises.l[y] then
            noises.l[y] = {}
            noises.m[y] = {}
        end
        if not noises.l[y + 1] then
            noises.l[y + 1] = {}
        end
        for z = maxp.z, minp.z, -1 do
            if not noises.l[y][z] then
                noises.l[y][z] = {}
                noises.m[y][z] = {}
            end
            if not noises.l[y+1][z] then
                noises.l[y+1][z] = {}
            end
            for x = maxp.x, minp.x, -1 do
                if not noises.l[y][z][x] then
                    noises.l[y][z][x] = {}
                    noises.m[y][z][x] = {}
                end
                local vi = area:index(x, y, z)

                local noise = perlin_l:get_3d({x = x, y = y, z = z})
                noises.l[y][z][x] = noise

                if mcl_better_end.api.is_free(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    light_data[vi] = light_level
                    goto keepitup2
                end

                if not noises.l[y+1][z][x] then
                    noises.l[y+1][z][x] = perlin_l:get_3d({x = x, y = y + 1, z = z})
                end
                local noise2 = noises.l[y+1][z][x]
                local noise_center = perlin:get_3d({x = x, y = y, z = z})
                noises.m[y][z][x] = noise_center

                if mcl_better_end.api.is_island(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone
                    if mcl_better_end.api.is_free(noise2) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "island" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.gen(data, vi, area, pr, x, y, z, perlin_l, noise_center, noise, noise2)
                            end
                        end
                    end
                    goto keepitup
                elseif mcl_better_end.api.is_cave(noise, noise2) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    light_data[vi] = cave_light_level
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "cave" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.gen(data, vi, area, pr, x, y, z, perlin_l, noise_center, noise, noise2)
                        end
                    end
                    goto keepitup
                elseif mcl_better_end.api.is_sea(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.sea
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "sea" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.gen(data, vi, area, pr, x, y, z, perlin_l, noise_center, noise, noise2)
                        end
                    end
                    goto keepitup
                end
                
                ::keepitup::
                for _, f in pairs(mcl_better_end.mapgen.ores) do
                    if y >= f.ymin and y <= f.ymax then
                        f.gen(data, vi, area, pr, x, y, z, perlin_l, noise_center)
                    end
                end
                
                ::keepitup2::
            end
        end
    end

    vm:set_data(data)
    vm:set_light_data(light_data)
    vm:write_to_map()
    vm:update_map()

    for y = minp.y, maxp.y do
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                local noise = noises.l[y][z][x]

                if mcl_better_end.api.is_free(noise) then
                    goto keepitup
                end

                local noise2 = noises.l[y+1][z][x]
                local noise_center = noises.m[y][z][x]

                if mcl_better_end.api.is_island(noise) then
                    if mcl_better_end.api.is_free(noise2) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "island" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.dec(pr, x, y, z, perlin_l, noise_center, noise, noise2)
                            end
                        end
                    end
                    goto keepitup

                elseif mcl_better_end.api.is_cave(noise, noise2) then
                    local vi = area:index(x, y, z)
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "cave" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.dec(pr, x, y, z, perlin_l, noise_center, noise, noise2)
                        end
                    end
                    goto keepitup

                elseif mcl_better_end.api.is_sea(noise) then
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "sea" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.dec(pr, x, y, z, perlin_l, noise_center, noise, noise2)
                        end
                    end
                    goto keepitup

                end

                ::keepitup::
            end
        end
    end
end


minetest.register_on_generated(
    function(minp, maxp, seed)
        if maxp.y < YMIN or minp.y > YMAX then return end
        mcl_better_end.mapgen.gen({x=minp.x, y=minp.y - 1,z=minp.z}, maxp, seed)
    end
)





-- Set the 3D noise parameters for the terrain.
local np_terrain = {
	offset = 0,
	scale = 1,
	spread = {x = 384, y = 192, z = 384},
	seed = 5900033,
	octaves = 5,
	persist = 0.63,
	lacunarity = 2.0,
	--flags = ""
}

-- Set singlenode mapgen (air nodes only).
-- Disable the engine lighting calculation since that will be done for a
-- mapchunk of air nodes and will be incorrect after we place nodes.
minetest.set_mapgen_setting("mg_name", "singlenode", true)
minetest.set_mapgen_setting("mg_flags", "nolight", true)

-- Get the content IDs for the nodes used.
local c_stone, c_water
minetest.register_on_mods_loaded(function()
	c_stone = minetest.get_content_id("mapgen_stone")
	c_water = minetest.get_content_id("mapgen_water_source")
end)

-- Initialize noise object to nil. It will be created once only during the
-- generation of the first mapchunk, to minimise memory use.
local nobj_terrain = nil

-- Localise noise buffer table outside the loop, to be re-used for all
-- mapchunks, therefore minimising memory use.
local nvals_terrain = {}

-- Localise data buffer table outside the loop, to be re-used for all
-- mapchunks, therefore minimising memory use.
local data = {}

-- Whether the 'biomegen' mod exists.
local use_biomegen = minetest.get_modpath('biomegen')

-- On generated function.

-- 'minp' and 'maxp' are the minimum and maximum positions of the mapchunk that
-- define the 3D volume.
minetest.register_on_generated(function(minp, maxp, seed)
	-- Start time of mapchunk generation.
	local t0 = os.clock()

	-- Noise stuff.

	-- Side length of mapchunk.
	local sidelen = maxp.x - minp.x + 1
	-- Required dimensions of the 3D noise perlin map.
	local permapdims3d = {x = sidelen, y = sidelen, z = sidelen}
	-- Create the perlin map noise object once only, during the generation of
	-- the first mapchunk when 'nobj_terrain' is 'nil'.
	nobj_terrain = nobj_terrain or
		minetest.get_perlin_map(np_terrain, permapdims3d)
	-- Create a flat array of noise values from the perlin map, with the
	-- minimum point being 'minp'.
	-- Set the buffer parameter to use and reuse 'nvals_terrain' for this.
	nobj_terrain:get_3d_map_flat(minp, nvals_terrain)

	-- Voxelmanip stuff.

	-- Load the voxelmanip with the result of engine mapgen. Since 'singlenode'
	-- mapgen is used this will be a mapchunk of air nodes.
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	-- 'area' is used later to get the voxelmanip indexes for positions.
	local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	-- Get the content ID data from the voxelmanip in the form of a flat array.
	-- Set the buffer parameter to use and reuse 'data' for this.
	vm:get_data(data)

	-- Generation loop.

	-- Noise index for the flat array of noise values.
	local ni = 1
	-- Process the content IDs in 'data'.
	-- The most useful order is a ZYX loop because:
	-- 1. This matches the order of the 3D noise flat array.
	-- 2. This allows a simple +1 incrementing of the voxelmanip index along x
	-- rows.
	for z = minp.z, maxp.z do
	for y = minp.y, maxp.y do
		-- Voxelmanip index for the flat array of content IDs.
		-- Initialise to first node in this x row.
		local vi = area:index(minp.x, y, z)
		for x = minp.x, maxp.x do
			-- Consider a 'solidness' value for each node,
			-- let's call it 'density', where
			-- density = density noise + density gradient.
			local density_noise = nvals_terrain[ni]
			-- Density gradient is a value that is 0 at water level (y = 1)
			-- and falls in value with increasing y. This is necessary to
			-- create a 'world surface' with only solid nodes deep underground
			-- and only air high above water level.
			-- Here '128' determines the typical maximum height of the terrain.
			local density_gradient = (1 - y) / 128
			-- Place solid nodes when 'density' > 0.
			if density_noise + density_gradient > 0 then
				data[vi] = c_stone
			-- Otherwise if at or below water level place water.
			elseif y <= 1 then
				data[vi] = c_water
			end

			-- Increment noise index.
			ni = ni + 1
			-- Increment voxelmanip index along x row.
			-- The voxelmanip index increases by 1 when
			-- moving by 1 node in the +x direction.
			vi = vi + 1
		end
	end
	end

	if use_biomegen then
		-- Generate biomes, decorations, ores and dust using biomegen.
		-- It will also call :set_data() for us.
		biomegen.generate_all(data, area, vm, minp, maxp, seed)
	else
		-- After processing, write content ID data back to the voxelmanip.
		vm:set_data(data)
	end

	-- Calculate lighting for what has been created.
	vm:calc_lighting()
	-- Write what has been created to the world.
	vm:write_to_map()
	-- Liquid nodes were placed so set them flowing.
	vm:update_liquids()

	-- Print generation time of this mapchunk.
	local chugent = math.ceil((os.clock() - t0) * 1000)
	print("[lvm_example] Mapchunk generation time " .. chugent .. " ms")
end)