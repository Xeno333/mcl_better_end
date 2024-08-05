
--[[minetest.register_decoration({
    name = "mcl_better_end:end_stone_plains_turf",
    deco_type = "simple",
    place_on = {"mcl_end:end_stone"},
    flags = "all_floors",
    sidelen = 16,
    y_min = mcl_vars.mg_end_min,
    y_max = mcl_vars.mg_end_max,
    noise_params = {
        offset = -0.012,
        scale = 0.024,
        spread = {x = 100, y = 100, z = 100},
        seed = 257,
        octaves = 3,
        persist = 100
    },
    decoration = "mcl_better_end:end_stone_plains_turf",
    height = 1,
    --height_max = 1,
    biomes = {"EndSmallIslands"},
})]]--

local function gen_plains_turf(minp, maxp, seed)
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

    -- Loop through the area and set nodes
    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do
            if y >= YMIN and y <= YMAX then
                for x = minp.x, maxp.x do
                    if minetest.get_node({x = x, y = y, z = z}).name == "air" then
                        if minetest.get_node({x = x, y = y-1, z = z}).name == "mcl_end:end_stone" then  -- Adjust the threshold for sea size and shape
                            local vi = area:index(x, y, z)
                            data[vi] = filler
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




local function gen_plains_grass(minp, maxp, seed)
    local YMAX = mcl_vars.mg_end_max
    local YMIN = mcl_vars.mg_end_min

    -- Check if the current Y range is within the desired bounds
    if maxp.y < YMIN or minp.y > YMAX then
        return
    end


    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local filler = minetest.get_content_id("mcl_better_end:end_stone_plains_grass")

    -- Loop through the area and set nodes
    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do
            if y >= YMIN and y <= YMAX then
                for x = minp.x, maxp.x do
                    if math.random(1, 10) == 5 then
                        if minetest.get_node({x = x, y = y, z = z}).name == "air" then
                            if minetest.get_node({x = x, y = y-1, z = z}).name == "mcl_better_end:end_stone_plains_turf" then  -- Adjust the threshold for sea size and shape
                                    local vi = area:index(x, y, z)
                                    data[vi] = filler
                            end
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
        gen_plains_turf(minp, maxp, seed)
        gen_plains_grass(minp, maxp, seed)
    end
)