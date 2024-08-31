


--add nodes
mcl_better_end.mapgen.registered_nodes.night_filler = minetest.get_content_id("mcl_better_end:end_stone_night_turf")
mcl_better_end.mapgen.registered_nodes.night_topper = minetest.get_content_id("mcl_better_end:night_grass")
mcl_better_end.mapgen.registered_nodes.night_candle_plant = minetest.get_content_id("mcl_better_end:night_candle_plant")
mcl_better_end.mapgen.registered_nodes.night_vines = minetest.get_content_id("mcl_better_end:night_vines")
mcl_better_end.mapgen.registered_nodes.night_vines_bottom = minetest.get_content_id("mcl_better_end:night_vines_bottom")



local topper = mcl_better_end.mapgen.registered_nodes.night_topper
local filler = mcl_better_end.mapgen.registered_nodes.night_filler
local night_candle_plant = mcl_better_end.mapgen.registered_nodes.night_candle_plant
local night_vines = mcl_better_end.mapgen.registered_nodes.night_vines
local night_vines_bottom = mcl_better_end.mapgen.registered_nodes.night_vines_bottom

mcl_better_end.api.register_biome({
    type = "cave",
    gen = function(data, vi, area, pr, x, y, z, noise_map, noise_center, plnoise, plnoise_1, lx,ly,lz)
        local noise = noise_map[lx][ly-1][lz]
        print(ly-1)
        if mcl_better_end.api.is_island(noise) then
            data[vi] = filler

            if pr:next(1, 60) == 2 then 
                minetest.add_entity({x = x, y = y+1, z = z}, "mobs_mc:endermite", minetest.serialize({}))
            end

            --add topww
            if pr:next(1, 20) == 3 then
                if mcl_better_end.api.is_cave(plnoise, plnoise_1) then
                    local vi = area:index(x, y+1, z)
                    if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                        data[vi] = topper
                    end
                end

            elseif pr:next(1, 200) == 3 then
                if mcl_better_end.api.is_cave(plnoise, plnoise_1) then
                    local vi = area:index(x, y+1, z)
                    if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                        data[vi] = night_candle_plant
                    end
                end
                
            end
        elseif mcl_better_end.api.is_island(plnoise_1) then
            if pr:next(1, 5) == 1 then
                data[vi] = night_vines
            end
        elseif data[area:index(x, y+1, z)] == night_vines then
            if pr:next(1, 2) == 1 then
                data[vi] = night_vines
            else
                data[vi] = night_vines_bottom
            end
        end
    end,
    noise_high = 1,
    noise_low = -1
})
