
local YMAX = -27020
local YMIN = -27060
local BLOB_SCALE = 30  -- Adjust the scale of the blobs
local SMOOTH_FACTOR = 5  -- Adjust the smoothing factor
local TAPER_HEIGHT = 40  -- Height at which tapering starts



local function generate_custom_end_island(minp, maxp, seed)
    -- Debug print to check the Y range being generated
    minetest.log("action", "Generating from " .. minp.y .. " to " .. maxp.y)

    -- Check if the current Y range is within the desired bounds
    if maxp.y < YMIN or minp.y > YMAX then
        return
    end

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local c_air = minetest.get_content_id("air")
    local filler = minetest.get_content_id("mcl_better_end:end_stone_plains_turf")


    -- Create a Perlin noise map
    local perlin = minetest.get_perlin({
        offset = 0,
        scale = 1,
        spread = {x = BLOB_SCALE, y = BLOB_SCALE, z = BLOB_SCALE},
        seed = seed,
        octaves = 3,
        persist = 0.5
    })


    -- Optimize by computing noise values less frequently
    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do
            if y >= YMIN and y <= YMAX then
                for x = minp.x, maxp.x do
                    local vi = area:index(x, y, z)
                    
                    -- Get noise value for the current position
                    local noise_center = perlin:get3d({x = x, y = y, z = z})
                    
                    -- Calculate taper based on height
                    local taper = math.max(0, 1 - ((y - YMIN) / TAPER_HEIGHT))
                    local noise_with_taper = noise_center * taper
                    
                    if noise_with_taper > 0.3 then  -- Adjust the threshold for blob size and shape
                        data[vi] = filler
                    else
                        data[vi] = c_air
                    end
                end
            end
        end
    end


    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end


minetest.register_on_generated(generate_custom_end_island)