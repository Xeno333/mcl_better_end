


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
        if pr:next(1, 20) == 5 then
            if not mcl_better_end.api.is_island(x, y+1, z) then
                local vi = area:index(x, y+1, z)
                data[vi] = topper
            end
        elseif pr:next(1, 500) == 46 then
            if not mcl_better_end.api.is_island(x, y+1, z) then
                local vi = area:index(x, y+1, z)
                data[vi] = magibulb
            end
        end
    end,
    noise_high = 0,
    noise_low = -1
})