
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


-- Hash function
local function hash(x, y, z)
    return math.abs((x * 73856093) ~ (y * 19349663) ~ (z * 83492791)) % 256
end

-- Linear interpolation function
local function lerp(t, a, b)
    return a + t * (b - a)
end

-- Gradient function
local function grad(hash, x, y, z)
    local h = hash % 16
    local u = h < 8 and x or y
    local v = h < 4 and y or (h == 12 or h == 14) and x or z
    return ((h % 2 == 0) and u or -u) + ((h % 4 == 0) and v or -v)
end

-- Smoothstep function
local function fade(t)
    return t * t * t * (t * (t * 6 - 15) + 10)
end

-- 3D Noise function
local function noise3D(x, y, z)
    local X = math.floor(x) % 256
    local Y = math.floor(y) % 256
    local Z = math.floor(z) % 256

    x = x - math.floor(x)
    y = y - math.floor(y)
    z = z - math.floor(z)

    local u = fade(x)
    local v = fade(y)
    local w = fade(z)

    local A = hash(X, Y, Z)
    local AA = hash(X + 1, Y, Z)
    local AB = hash(X, Y + 1, Z)
    local B = hash(X + 1, Y + 1, Z)

    local p0 = grad(A, x, y, z)
    local p1 = grad(AA, x - 1, y, z)
    local p2 = grad(AB, x, y - 1, z)
    local p3 = grad(B, x - 1, y - 1, z)
    local p4 = grad(A, x, y, z - 1)
    local p5 = grad(AA, x - 1, y, z - 1)
    local p6 = grad(AB, x, y - 1, z - 1)
    local p7 = grad(B, x - 1, y - 1, z - 1)

    local l0 = lerp(u, p0, p1)
    local l1 = lerp(u, p2, p3)
    local l2 = lerp(u, p4, p5)
    local l3 = lerp(u, p6, p7)

    local l4 = lerp(v, l0, l1)
    local l5 = lerp(v, l2, l3)

    return lerp(w, l4, l5)
end





--Gen
local noises = {}

-- Mapgen Generation Function
function mcl_better_end.mapgen.gen(minp, maxp, seed)
    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()
    local light_data = vm:get_light_data()
    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)


    if minp.y > YMAX_biome then
        for y = maxp.y, minp.y, -1 do
            for z = maxp.z, minp.z, -1 do
                for x = maxp.x, minp.x, -1 do
                    local vi = area:index(x, y, z)
                    local noise = perlin_l:get_3d({x = x, y = y, z = z})
                    
                    if not mcl_better_end.api.is_island(noise) then
                        data[vi] = mcl_better_end.mapgen.registered_nodes.air
                        light_data[vi] = light_level
                    else
                        data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone
                        for _, f in pairs(mcl_better_end.mapgen.ores) do
                            if y >= f.ymin and y <= f.ymax then
                                f.gen(data, vi, area, pr, x, y, z, perlin_l)
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
    
    noises.l = {}
    noises.m = {}

    for y = maxp.y, minp.y, -1 do
        for z = maxp.z, minp.z, -1 do
            for x = maxp.x, minp.x, -1 do
                local vi = area:index(x, y, z)
                if not noises.l[x] then
                    noises.l[x] = {}
                    noises.m[x] = {}
                end
                if not noises.l[x][y] then
                    noises.l[x][y] = {}
                    noises.m[x][y] = {}
                end
                if not noises.l[x][y][z] then
                    noises.l[x][y][z] = {}
                    noises.m[x][y][z] = {}
                end
                if not noises.l[x][y + 1] then
                    noises.l[x][y + 1] = {}
                end
                if not noises.l[x][y + 1][z] then
                    noises.l[x][y + 1][z] = noise3D(x, y+1, z)
                end

                local noise_center = noise3D(x, y, z)
                local noise = noise3D(x, y, z)
                local noise2 = noises.l[x][y + 1][z]

                noises.l[x][y][z] = noise
                noises.m[x][y][z] = noise_center


                if mcl_better_end.api.is_free(noise) then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    light_data[vi] = light_level
                    goto keepitup2

                elseif mcl_better_end.api.is_island(noise) then
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
                else
                    data[vi] = mcl_better_end.mapgen.registered_nodes.air
                    light_data[vi] = light_level
                    goto keepitup2
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
end

-- Mapgen Decoration Function
function mcl_better_end.mapgen.dec(minp, maxp, seed)
    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    for y = minp.y, maxp.y do
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                local noise = noises.l[x][y][z]
                local noise2 = noises.l[x][y+1][z]

                if mcl_better_end.api.is_free(noise) or mcl_better_end.api.is_island(noise2) then
                    goto keepitup
                end
                
                local noise_center = noises.m[x][y][z]

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
        mcl_better_end.mapgen.gen(minp, maxp, seed)
        if maxp.y < YMIN or minp.y > YMAX_biome then return end
        mcl_better_end.mapgen.dec(minp, maxp, seed)
    end
)
