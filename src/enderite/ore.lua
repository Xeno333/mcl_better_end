local YMAX = -27020
local YMIN = -27100

mcl_better_end.mapgen.registered_nodes.enderite_ore = minetest.get_content_id("mcl_better_end:enderite_ore")

mcl_better_end.mapgen.ores.enderite = function(data, vi, area, pr, x, y, z)
    if y > YMAX or y < YMIN then
        return
    end
    --enderite
    if pr:next(1, 1000) == 5 then
        if pr:next(1, 50) == 5 then
            print("BBB")
            data[vi] = mcl_better_end.mapgen.registered_nodes.enderite_ore
        end
    end
end