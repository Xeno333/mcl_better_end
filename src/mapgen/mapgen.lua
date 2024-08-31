
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
    
        -- Calculate the size of the noise map
        noise_size = {x = maxp.x - minp.x + 1, y = maxp.y - minp.y + 1, z = maxp.z - minp.z + 1}
        
        -- Create the PerlinNoiseMap object
        perlin_map = minetest.get_perlin_map(np_perlin_3d, noise_size)
        
        -- Calculate the 3D noise map
        noise_map = perlin_map:get_3d_map({x=minp.x,y=minp.y,z=minp.z})
-- Main generation loop
if minp.y > YMAX_biome then
    for y = maxp.y, minp.y, -1 do
        for z = maxp.z, minp.z, -1 do
            for x = maxp.x, minp.x, -1 do
                -- Calculate the index in the area
                local vi = area:index(x, y, z)
                
                -- Access the noise value from the map
                local noise_x = x - minp.x + 1
                local noise_y = y - minp.y + 1
                local noise_z = z - minp.z + 1
                
                -- Check bounds for the noise map array
                local noise = noise_map[noise_x][noise_y][noise_z]
                
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
