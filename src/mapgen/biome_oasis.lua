


--add nodes
mcl_better_end.mapgen.registered_nodes.oasis_filler = minetest.get_content_id("mcl_better_end:end_stone_oasis_turf")
mcl_better_end.mapgen.registered_nodes.oasis_topper = minetest.get_content_id("mcl_better_end:end_oasis_grass")
--mcl_better_end.mapgen.registered_nodes.oasis_water = minetest.get_content_id("mcl_better_end:ender_water_real")
mcl_better_end.mapgen.registered_nodes.oasis_glow_berry_plant = minetest.get_content_id("mcl_better_end:end_glow_berry_plant")
mcl_better_end.mapgen.registered_nodes.sand = minetest.get_content_id("mcl_better_end:end_sand")


local topper = mcl_better_end.mapgen.registered_nodes.oasis_topper
local filler = mcl_better_end.mapgen.registered_nodes.oasis_filler
local water = mcl_better_end.mapgen.registered_nodes.oasis_water
local glow_berry_plant = mcl_better_end.mapgen.registered_nodes.oasis_glow_berry_plant
local sand = mcl_better_end.mapgen.registered_nodes.sand


mcl_better_end.api.register_biome({
    type = "island",
    gen = function(data, vi, area, pr, x, y, z, perlin_l, noise_center)
        if pr:next(1, 100) == 5 then
            data[vi] = sand
        else
            data[vi] = filler
        end
        

        --add topww
        if pr:next(1, 20) == 3 then
            if not mcl_better_end.api.is_island(x, y+1, z) then
                local vi = area:index(x, y+1, z)
                data[vi] = topper
            end

        elseif pr:next(1, 200) == 3 then
            if not mcl_better_end.api.is_island(x, y+1, z) then
                local vi = area:index(x, y+1, z)
                data[vi] = glow_berry_plant
            end
            
        end
    end,
    dec = function(pr, x, y, z, perlin_l, noise_center)
        if pr:next(1, 100) == 5 then
            minetest.place_schematic({x=x,y=y,z=z}, mcl_better_end.schematic_loc .. mcl_better_end.biomes.oasis.tree_schem[pr:next(1, #mcl_better_end.biomes.oasis.tree_schem)], "0", nil, false)
        end
    end,
    noise_high = 1,
    noise_low = 0
})
