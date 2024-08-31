
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
    
    noise_size = {x = maxp.x-minp.x+1, y = maxp.y-minp.y+4, z = maxp.z-minp.z +1}
    perlin_map = minetest.get_perlin_map(np_perlin_3d, noise_size)
    noise_map = perlin_map:get_3d_map({y=minp.x,x=minp.y-1,z=minp.z})

    if minp.y > YMAX_biome then
        for y = minp.y, maxp.y do
            for z = minp.z, maxp.z do
                local vi = area:index(minp.x, y, z)
                for x = minp.x, maxp.x do
                    local noise = noise_map[x-minp.x+1][y-minp.y+2][z-minp.z+1]
                    
                    if not mcl_better_end.api.is_island(noise) then
                        data[vi] = mcl_better_end.mapgen.registered_nodes.air
                        light_data[vi] = light_level
                    else
                        data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone
                        for _, f in pairs(mcl_better_end.mapgen.ores) do
                            if y >= f.ymin and y <= f.ymax then
                                f.gen(data, vi, area, pr, x, y, z, noise_map, noise_center, lx,ly,lz)
                            end
                        end
                    end
                    vi = vi + 1
                end
            end
        end
        vm:set_data(data)
        vm:set_light_data(light_data)
        vm:write_to_map()
        vm:update_map()
        return
    end
    

    for y = minp.y, maxp.y do
        for z = minp.z, maxp.z do
            local vi = area:index(minp.x, y, z)
            for x = minp.x, maxp.x do
                local lx = x-minp.x+1
                local ly = y-minp.y+2
                local lz = x-minp.z+1
                local noise = noise_map[lx][ly][ly]
                local noise2
                local noise_center

                if mcl_better_end.api.is_free(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    light_data[vi] = light_level
                    goto keepitup2
                end

                noise2 = noise_map[lx][ly+1][ly]
                noise_center = perlin:get_3d({x = x, y = y, z = z})

                if mcl_better_end.api.is_island(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone
                    if mcl_better_end.api.is_free(noise2) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "island" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.gen(data, vi, area, pr, x, y, z, noise_map, noise_center, noise, noise2, lx,ly,lz)
                            end
                        end
                    end
                    goto keepitup
                elseif mcl_better_end.api.is_cave(noise, noise2) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    light_data[vi] = cave_light_level
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "cave" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.gen(data, vi, area, pr, x, y, z, noise_map, noise_center, noise, noise2, lx,ly,lz)
                        end
                    end
                    goto keepitup
                elseif mcl_better_end.api.is_sea(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.sea
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "sea" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.gen(data, vi, area, pr, x, y, z, noise_map, noise_center, noise, noise2, lx,ly,lz)
                        end
                    end
                    goto keepitup
                end
                
                ::keepitup::
                for _, f in pairs(mcl_better_end.mapgen.ores) do
                    if y >= f.ymin and y <= f.ymax then
                        f.gen(data, vi, area, pr, x, y, z, noise_map, noise_center, lx,ly,lz)
                    end
                end
                
                ::keepitup2::
                vi = vi + 1
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
                local noise = noise_map[lx][ly][ly]

                if mcl_better_end.api.is_free(noise) then
                    goto keepitup
                end

                local noise2 = noise_map[lx][ly+1][ly]
                local noise_center = perlin:get_3d({x = x, y = y, z = z})

                if mcl_better_end.api.is_island(noise) then
                    if mcl_better_end.api.is_free(noise2) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "island" and p.dec and noisesnoise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.dec(pr, x, y, z, noise_map, noise_center, noise, noise2, lx,ly,lz)
                            end
                        end
                    end
                    goto keepitup

                elseif mcl_better_end.api.is_cave(noise, noise2) then
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "cave" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.dec(pr, x, y, z, noise_map, noise_center, noise, noise2, lx,ly,lz)
                        end
                    end
                    goto keepitup

                elseif mcl_better_end.api.is_sea(noise) then
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "sea" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.dec(pr, x, y, z, noise_map, noise_center, noise, noise2, lx,ly,lz)
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
