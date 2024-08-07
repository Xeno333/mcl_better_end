
local YMAX = -26990--mcl_vars.mg_end_max
local YMIN = -27010--mcl_vars.mg_end_min

--Needed for context for some reason
local perlin
minetest.register_on_joinplayer(
    function() 
        perlin = minetest.get_perlin({
            offset = 0,
            scale = 1,
            spread = {x = 100, y = 1, z = 100},
            seed = minetest.get_mapgen_setting("seed"),
            octaves = 3,
            persist = 0.5
        })
    end
)


mcl_better_end.mapgen.registered_nodes = {
    air = minetest.get_content_id("air"),
    end_stone = minetest.get_content_id("mcl_end:end_stone"),
    enderite_ore = minetest.get_content_id("mcl_better_end:enderite_ore")
}


function mcl_better_end.mapgen.gen(minp, maxp, seed)
    -- Check if the current Y range is within the desired bounds
    if maxp.y < YMIN or minp.y > YMAX then
        return
    end

    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    -- Loop through the area and set nodes
    for y = math.max(minp.y, YMIN), math.min(maxp.y, YMAX) do
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                --do tuff
                local vi = area:index(x, y, z)
                if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                    if minetest.get_node({x = x, y = y-1, z = z}).name == "mcl_end:end_stone" then  -- Adjust the threshold for sea size and shape
                        --biome
                        local noise_center = perlin:get_3d({x = x, y = 1, z = z})

                        --plains
                        if noise_center > 0 then
                            mcl_better_end.biomes.plains.gen(data, vi, area, pr, x, y, z)
                        end
                    end

                --ores
                elseif y < -27000 then
                    if data[vi] == mcl_better_end.mapgen.registered_nodes.end_stone then
                        for _, f in pairs(mcl_better_end.mapgen.ores) do
                            f(data, vi, area, pr, x, y, z)
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
        mcl_better_end.mapgen.gen(minp, maxp, seed)
    end
    
)