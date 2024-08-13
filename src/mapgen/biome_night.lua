


--add nodes
mcl_better_end.mapgen.registered_nodes.night_filler = minetest.get_content_id("mcl_better_end:end_stone_night_turf")
mcl_better_end.mapgen.registered_nodes.night_topper = minetest.get_content_id("mcl_better_end:night_grass")
mcl_better_end.mapgen.registered_nodes.night_candle_plant = minetest.get_content_id("mcl_better_end:night_candle_plant")


local topper = mcl_better_end.mapgen.registered_nodes.night_topper
local filler = mcl_better_end.mapgen.registered_nodes.night_filler
local night_candle_plant = mcl_better_end.mapgen.registered_nodes.night_candle_plant

mcl_better_end.api.register_biome({
    type = "cave",
    gen = function(data, vi, area, pr, x, y, z)
        if mcl_better_end.api.is_island(x, y-1, z) then
            data[vi] = filler

            --add topww
            if pr:next(1, 20) == 3 then
                if mcl_better_end.api.is_cave(x, y+1, z) then
                    local vi = area:index(x, y+1, z)
                    if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                        data[vi] = topper
                    end
                end

            elseif pr:next(1, 200) == 3 then
                if mcl_better_end.api.is_cave(x, y+1, z) then
                    local vi = area:index(x, y+1, z)
                    if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                        data[vi] = night_candle_plant
                    end
                end
                
            end
        end
    end,
    dec = function(pr, x, y, z)
        if pr:next(1, 600) == 2 then 
            minetest.add_entity({x = x, y = y+1, z = z}, "mobs_mc:endermite", minetest.serialize({}))
        end
    end,
    noise_high = 1,
    noise_low = -1
})
