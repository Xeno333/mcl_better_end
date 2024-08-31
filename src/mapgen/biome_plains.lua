


--add nodes
mcl_better_end.mapgen.registered_nodes.plains_filler = minetest.get_content_id("mcl_better_end:end_stone_plains_turf")
mcl_better_end.mapgen.registered_nodes.plains_topper = minetest.get_content_id("mcl_better_end:end_plains_grass")
mcl_better_end.mapgen.registered_nodes.plains_magibulb = minetest.get_content_id("mcl_better_end:end_plains_magibulb_plant")
mcl_better_end.mapgen.registered_nodes.plains_chorus_plant = minetest.get_content_id("mcl_end:chorus_plant")
mcl_better_end.mapgen.registered_nodes.plains_chorus_flower_dead = minetest.get_content_id("mcl_end:chorus_flower_dead")
mcl_better_end.mapgen.registered_nodes.sand = minetest.get_content_id("mcl_better_end:end_sand")


local sand = mcl_better_end.mapgen.registered_nodes.sand
local topper = mcl_better_end.mapgen.registered_nodes.plains_topper
local filler = mcl_better_end.mapgen.registered_nodes.plains_filler
local magibulb = mcl_better_end.mapgen.registered_nodes.plains_magibulb
local chorus_plant = mcl_better_end.mapgen.registered_nodes.plains_chorus_plant
local chorus_plant_top = mcl_better_end.mapgen.registered_nodes.plains_chorus_flower_dead


local function grow_chorus_branch(pos, height, pr, data, area, noise_map, lx,ly,lz)
    local current_pos = {x = pos.x, y = pos.y, z = pos.z}
    for i = 0, height do
        y = y + 1
        if ly+y > 80 or ly-y < 0 or lz+z > 80 or lz-z < 0 or lz+z > 80 or lz-z < 0 then break end
        local vi = area:index(pos.x+x, pos.y+y, pos.z+z)
        data[vi] = chorus_plant

        -- Randomly decide if we branch  
        if pr:next(1, 2) == 1 then
            local branch_dir = pr:next(1, 4)
            local branch_pos
            local noise = noise_map[x][y][z]
            if not mcl_better_end.api.is_free(noise) then
                return 
            end
            if branch_dir == 1 then
                branch_pos = {x = x + 1, y = y, z = z}
            elseif branch_dir == 2 then
                branch_pos = {x = x - 1, y = y, z = z}
            elseif branch_dir == 3 then
                branch_pos = {x = x, y = y, z = z + 1}
            else
                branch_pos = {x = x, y = y, z = z - 1}
            end
            
            local vi = area:index(branch_pos.x, branch_pos.y, branch_pos.z)
            data[vi] = chorus_plant

            -- Potentially grow a flower on the branch
            if pr:next(1, 2) == 1 then
                local vi = area:index(branch_pos.x, branch_pos.y + 1, branch_pos.z)
                data[vi] = chorus_plant_top
            end
            y = branch_pos.y
            x = branch_pos.x
            z = branch_pos.z
        end
    end
    local vi = area:index(current_pos.x, current_pos.y, current_pos.z)
    data[vi] = chorus_plant_top
end


mcl_better_end.api.register_biome({
    type = "island",
    gen = function(data, vi, area, pr, x, y, z, noise_map, noise_center, plnoise, plnoise_1, lx,ly,lz)
        if noise_center < -0.5 then
            data[vi] = sand
        else
            data[vi] = filler
        end
        

        if pr:next(1, 600) == 2 then 
            minetest.add_entity({x = x, y = y+1, z = z}, "mobs_mc:enderman", minetest.serialize({}))

        elseif pr:next(1, 800) == 2 then 
            minetest.add_entity({x = x, y = y+1, z = z}, "mobs_mc:shulker", minetest.serialize({}))
        end


        if pr:next(1, 20) == 5 then
            if not mcl_better_end.api.is_island(plnoise_1) then
                local vi = area:index(x, y+1, z)
                data[vi] = topper
            end

        elseif pr:next(1, 100) == 5 then
            data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone    
            grow_chorus_branch({x = x, y = y, z = z}, pr:next(1, 20), pr, data, area, noise_map)

        elseif pr:next(1, 200) == 46 then
            if not mcl_better_end.api.is_island(plnoise_1) then
                local vi = area:index(x, y+1, z)
                data[vi] = magibulb
            end
        end
        
    end,
    noise_high = 0,
    noise_low = -1
})
