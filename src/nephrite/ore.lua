local YMAX = -26920
local YMIN = -26900

mcl_better_end.mapgen.registered_nodes.nephrite_ore = minetest.get_content_id("mcl_better_end:nephrite_ore")

mcl_better_end.mapgen.ores.nephrite = function(data, vi, area, pr, x, y, z)
    if y > YMAX or y < YMIN then
        return
    end
    --nephrite
    if pr:next(1, 1000) == 5 then
        if pr:next(1, 100) == 5 then
            print("AAA")
            data[vi] = mcl_better_end.mapgen.registered_nodes.nephrite_ore
        end
    end
end