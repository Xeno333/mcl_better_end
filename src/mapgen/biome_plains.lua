


--add nodes
mcl_better_end.mapgen.registered_nodes.plains_filler = minetest.get_content_id("mcl_better_end:end_stone_plains_turf")
mcl_better_end.mapgen.registered_nodes.plains_topper = minetest.get_content_id("mcl_better_end:end_plains_grass")
mcl_better_end.mapgen.registered_nodes.plains_magibulb = minetest.get_content_id("mcl_better_end:end_plains_magibulb_plant")


local topper = mcl_better_end.mapgen.registered_nodes.plains_topper
local filler = mcl_better_end.mapgen.registered_nodes.plains_filler
local magibulb = mcl_better_end.mapgen.registered_nodes.plains_magibulb



mcl_better_end.api.register_biome({
    gen = function(data, vi, area, pr, x, y, z)
        data[vi] = filler

        --add top
        if pr:next(1, 10) == 5 then
            local vi = area:index(x, y+1, z)
            if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                data[vi] = topper
            end
        elseif pr:next(1, 500) == 46 then
            local vi = area:index(x, y+1, z)
            if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                data[vi] = magibulb
            end
        end
    end,
    noise_high = 0,
    noise_low = -1
})