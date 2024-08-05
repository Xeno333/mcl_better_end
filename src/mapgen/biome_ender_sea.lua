
local function generate_custom_end_island(minp, maxp, seed)
    if minp.y < -27010 or maxp.y > -27060 then
        return
    end
    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local c_air = minetest.get_content_id("air")
    local c_endstone = minetest.get_content_id("mcl_end:end_stone")

    -- Loop through the area and set nodes
    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do
            for x = minp.x, maxp.x do
                local vi = area:index(x, y, z)
                if math.random() < 0.01 then  -- Adjust the condition to your liking
                    data[vi] = c_endstone
                else
                    data[vi] = c_air
                end
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end

minetest.register_on_generated(generate_custom_end_island)