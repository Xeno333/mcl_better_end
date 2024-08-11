
local YMAX = -25000--mcl_vars.mg_end_max
local YMIN = -27050--mcl_vars.mg_end_min

local cave_light_level = 4
local light_level = 10

local biome_size = 200

--Needed for context for some reason
local perlin
local perlin_l



-- Caching Perlin noise for a single coordinate
local function get_perlin_noise(perlin, x, y, z)
    return perlin:get_3d({x = x, y = y, z = z})
end



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



mcl_better_end.api.is_cave = function(x, y, z)
    local noise = get_perlin_noise(perlin_l, x, y, z)
    return (noise >= 0.8) or (get_perlin_noise(perlin_l, x, y + 1, z) >= 0.8)
end

mcl_better_end.api.is_island = function(x, y, z)
    local noise = get_perlin_noise(perlin_l, x, y, z)
    return (noise > 0.5 and noise < 0.8)
end

mcl_better_end.api.is_sea = function(x, y, z)
    return get_perlin_noise(perlin_l, x, y, z) < -0.5
end

mcl_better_end.api.is_free = function(x, y, z)
    local noise = get_perlin_noise(perlin_l, x, y, z)
    return not (noise >= 0.8 or (noise > 0.5 and noise < 0.8) or noise < -0.5)
end



--mapgen


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
        perlin_l = minetest.get_perlin({
                offset = 0,
                scale = 1,
                spread = {x = 50, y = 20, z = 50},
                seed = minetest.get_mapgen_setting("seed"),
                octaves = 3,
                persist = 0.5
            })
    end
)







--Gen

-- Mapgen Generation Function
function mcl_better_end.mapgen.gen(minp, maxp, seed)
    if maxp.y < YMIN or minp.y > YMAX then return end

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()
    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    for y = maxp.y, minp.y, -1 do
        for z = maxp.z, minp.z, -1 do
            for x = maxp.x, minp.x, -1 do
                local vi = area:index(x, y, z)

                if mcl_better_end.api.is_free(x, y, z) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    goto keepitup
                end

                local noise_center = get_perlin_noise(perlin, x, y, z)

                if mcl_better_end.api.is_island(x, y, z) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone
                    for _, f in pairs(mcl_better_end.mapgen.ores) do
                        f(data, vi, area, pr, x, y, z)
                    end
                    if mcl_better_end.api.is_free(x, y + 1, z) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "island" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.gen(data, vi, area, pr, x, y, z)
                            end
                        end
                    end
                    goto keepitup
                elseif mcl_better_end.api.is_cave(x, y, z) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    if mcl_better_end.api.is_cave(x, y + 1, z) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "cave" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.gen(data, vi, area, pr, x, y, z)
                            end
                        end
                    end
                    goto keepitup
                elseif mcl_better_end.api.is_sea(x, y, z) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.sea
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "sea" and p.gen and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.gen(data, vi, area, pr, x, y, z)
                        end
                    end
                    goto keepitup
                end

                ::keepitup::
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end

-- Mapgen Decoration Function
function mcl_better_end.mapgen.dec(minp, maxp, seed)
    if maxp.y < YMIN or minp.y > YMAX then return end

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local light_data = vm:get_light_data()
    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    for y = minp.y, maxp.y do
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                if mcl_better_end.api.is_free(x, y, z) then
                    local vi = area:index(x, y, z)
                    light_data[vi] = light_level
                    goto keepitup
                end
                
                local noise_center = get_perlin_noise(perlin, x, y, z)

                if mcl_better_end.api.is_island(x, y, z) then
                    if mcl_better_end.api.is_free(x, y + 1, z) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "island" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.dec(pr, x, y, z)
                            end
                        end
                    end
                    goto keepitup

                elseif mcl_better_end.api.is_cave(x, y, z) then
                    local vi = area:index(x, y, z)
                    light_data[vi] = cave_light_level
                    if mcl_better_end.api.is_free(x, y + 1, z) then
                        for _, p in pairs(mcl_better_end.biomes) do
                            if p.type == "cave" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                                p.dec(pr, x, y, z)
                            end
                        end
                    end
                    goto keepitup

                elseif mcl_better_end.api.is_sea(x, y, z) then
                    for _, p in pairs(mcl_better_end.biomes) do
                        if p.type == "sea" and p.dec and noise_center >= p.noise_low and noise_center <= p.noise_high then
                            p.dec(pr, x, y, z)
                        end
                    end
                    goto keepitup

                end

                ::keepitup::
            end
        end
    end

    vm:set_light_data(light_data)
    vm:write_to_map()
    vm:update_map()
end


minetest.register_on_generated(
    function(minp, maxp, seed)
        mcl_better_end.mapgen.gen(minp, maxp, seed)
        mcl_better_end.mapgen.dec(minp, maxp, seed)
    end
)