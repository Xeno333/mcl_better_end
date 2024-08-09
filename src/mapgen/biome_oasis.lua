


--add nodes
mcl_better_end.mapgen.registered_nodes.oasis_filler = minetest.get_content_id("mcl_better_end:end_stone_oasis_turf")
mcl_better_end.mapgen.registered_nodes.oasis_topper = minetest.get_content_id("mcl_better_end:end_oasis_grass")
mcl_better_end.mapgen.registered_nodes.oasis_water = minetest.get_content_id("mcl_better_end:ender_water_real")


local topper = mcl_better_end.mapgen.registered_nodes.oasis_topper
local filler = mcl_better_end.mapgen.registered_nodes.oasis_filler
local water = mcl_better_end.mapgen.registered_nodes.oasis_water


local function gen_pond(data, vi, area, pr, x, y, z)
end

mcl_better_end.api.register_biome({
    gen = function(data, vi, area, pr, x, y, z)
        data[vi] = filler

        --add topww
        if pr:next(1, 20) == 3 then
            if not mcl_better_end.api.is_island(x, y+1, z) then
                local vi = area:index(x, y+1, z)
                data[vi] = topper
            end
        end
    end,
    noise_high = 1,
    noise_low = 0
})