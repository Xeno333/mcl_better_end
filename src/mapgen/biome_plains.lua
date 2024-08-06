
local function gen_plains(minp, maxp, seed)
    local YMAX = mcl_vars.mg_end_max
    local YMIN = mcl_vars.mg_end_min

    -- Check if the current Y range is within the desired bounds
    if maxp.y < YMIN or minp.y > YMAX then
        return
    end


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
                    if minetest.get_node({x = x, y = y-1, z = z}).name == "weeeemcl_end:end_stone" then  -- Adjust the threshold for sea size and shape
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

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end

minetest.register_on_generated(
    function(minp, maxp, seed)
        gen_plains(minp, maxp, seed)
    end
)