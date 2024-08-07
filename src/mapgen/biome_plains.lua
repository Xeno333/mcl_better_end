
local YMAX = -26990--mcl_vars.mg_end_max
local YMIN = -27010--mcl_vars.mg_end_min


function mcl_better_end.mapgen.gen_plains(minp, maxp, seed)
    -- Check if the current Y range is within the desired bounds
    if maxp.y < YMIN or minp.y > YMAX then
        return
    end


    -- Create a Perlin noise map for sea-like blobs
    local perlin = minetest.get_perlin({
        offset = 0,
        scale = 1,
        spread = {x = 100, y = 1, z = 100},
        seed = minetest.get_mapgen_setting("seed"),
        octaves = 3,
        persist = 0.5
    })


    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local filler = minetest.get_content_id("mcl_better_end:end_stone_plains_turf")
    local topper = minetest.get_content_id("mcl_better_end:end_stone_plains_grass")
    local air = minetest.get_content_id("air")

    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    -- Loop through the area and set nodes
    for y = math.max(minp.y, YMIN), math.min(maxp.y, YMAX) do
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                --do tuff
                local vi = area:index(x, y, z)
                if data[vi] == air then
                    if minetest.get_node({x = x, y = y-1, z = z}).name == "mcl_end:end_stone" then  -- Adjust the threshold for sea size and shape

                        local noise_center = perlin:get3d({x = x, y = 1, z = z})
                        if noise_center > 0 then
                            data[vi] = filler

                            --biome gen

                            --add top
                            if pr:next(1, 10) == 5 then
                                local vi = area:index(x, y+1, z)
                                if data[vi] == air then
                                    data[vi] = topper
                                end
                            end

                            --end biome gen
                        end
                    end
                end
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end

minetest.register_on_generated(
    function(minp, maxp, seed)
        mcl_better_end.mapgen.gen_plains(minp, maxp, seed)
    end
)