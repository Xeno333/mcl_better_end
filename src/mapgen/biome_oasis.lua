


--add nodes
mcl_better_end.mapgen.registered_nodes.oasis_filler = minetest.get_content_id("mcl_better_end:end_stone_oasis_turf")
mcl_better_end.mapgen.registered_nodes.oasis_topper = minetest.get_content_id("mcl_better_end:end_oasis_grass")


local topper = mcl_better_end.mapgen.registered_nodes.oasis_topper
local filler = mcl_better_end.mapgen.registered_nodes.oasis_filler 


mcl_better_end.api.register_biome({
    gen = function(data, vi, area, pr, x, y, z)
        data[vi] = filler

        --add top
        if pr:next(1, 5) == 3 then
            local vi = area:index(x, y+1, z)
            if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                data[vi] = topper
            end
        end
    end,
    noise_high = 1,
    noise_low = 0
})