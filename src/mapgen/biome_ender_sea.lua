local YMAX = -26700
local YMIN = -26960
local BLOB_SCALE = 40  -- Adjust the scale of the blobs
local SMOOTH_FACTOR = 0.8  -- Adjust the smoothing factor
local TRANSITION_RADIUS = 10  -- Radius for smooth sea surface transition

local function smooth_transition(distance, radius)
    local t = math.min(distance / radius, 1)
    return 1 - t * t * (3 - 2 * t)
end

local function gen_sea(minp, maxp, seed)
    -- Check if the current Y range is within the desired bounds
    if maxp.y < YMIN or minp.y > YMAX then
        return
    end

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local c_air = minetest.get_content_id("air")
    local filler = minetest.get_content_id("mcl_better_end:ender_water")

    -- Create a Perlin noise map for sea-like blobs
    local perlin = minetest.get_perlin({
        offset = 0,
        scale = 1,
        spread = {x = BLOB_SCALE, y = BLOB_SCALE, z = BLOB_SCALE},
        seed = seed,
        octaves = 3,
        persist = 0.5
    })

    -- Loop through the area and set nodes
    local index = area.index
    for y = math.max(minp.y, YMIN), math.min(maxp.y, YMAX) do
        local transition = smooth_transition(y, TRANSITION_RADIUS)
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                -- Get the noise value
                local noise_center = perlin:get3d({x = x, y = y, z = z})
                local final_value = noise_center * transition

                -- Set the node based on the final value and sea level
                if final_value > 0.3 then  -- Adjust the threshold for sea size and shape
                    local vi = index(area, x, y, z)
                    data[vi] = filler
                end
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end

minetest.register_on_generated(gen_sea)
