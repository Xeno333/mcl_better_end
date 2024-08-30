local YMAX = -26500
local YMIN = -27100

mcl_better_end.mapgen.registered_nodes.enderite_ore = minetest.get_content_id("mcl_better_end:enderite_ore")

mcl_better_end.mapgen.ores.enderite = {
    gen = function(data, vi, area, pr, x, y, z, perlin_l, noise_center)
        --enderite
        if data[vi] == mcl_better_end.mapgen.registered_nodes.end_stone then
            if pr:next(1, 1000) == 5 then
                if pr:next(1, 7) == 5 then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.enderite_ore
                end
            end
        end
    end,
    ymax = YMAX,
    ymin = YMIN,
}