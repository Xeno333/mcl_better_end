local YMAX = -25500
local YMIN = -26000

--oasis
local noise_high = 1
local noise_low = 0

mcl_better_end.mapgen.registered_nodes.nephrite_ore = minetest.get_content_id("mcl_better_end:nephrite_ore")

mcl_better_end.mapgen.ores.nephrite = {
    gen = function(data, vi, area, pr, x, y, z, perlin_l, noise_center)
        if not (noise_center < noise_high and noise_center > noise_low) then 
            return
        end
        --nephrite
        if data[vi] == mcl_better_end.mapgen.registered_nodes.end_stone then
            if pr:next(1, 1000) == 5 then
                if pr:next(1, 10) == 5 then
                    data[vi] = mcl_better_end.mapgen.registered_nodes.nephrite_ore
                end
            end
        end
    end,
    ymax = YMAX,
    ymin = YMIN,
}