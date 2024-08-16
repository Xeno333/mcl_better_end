


--add nodes
mcl_better_end.mapgen.registered_nodes.plains_filler = minetest.get_content_id("mcl_better_end:end_stone_plains_turf")
mcl_better_end.mapgen.registered_nodes.plains_topper = minetest.get_content_id("mcl_better_end:end_plains_grass")
mcl_better_end.mapgen.registered_nodes.plains_magibulb = minetest.get_content_id("mcl_better_end:end_plains_magibulb_plant")
mcl_better_end.mapgen.registered_nodes.plains_chorus_plant = minetest.get_content_id("mcl_end:chorus_plant")
mcl_better_end.mapgen.registered_nodes.plains_chorus_flower_dead = minetest.get_content_id("mcl_end:chorus_flower_dead")


local topper = mcl_better_end.mapgen.registered_nodes.plains_topper
local filler = mcl_better_end.mapgen.registered_nodes.plains_filler
local magibulb = mcl_better_end.mapgen.registered_nodes.plains_magibulb
local chorus_plant = mcl_better_end.mapgen.registered_nodes.plains_chorus_plant
local chorus_plant_top = mcl_better_end.mapgen.registered_nodes.plains_chorus_flower_dead


local function grow_chorus_branch(pos, height, pr, data, area)
    local current_pos = {x = pos.x, y = pos.y, z = pos.z}
    for i = 0, height do
        current_pos.y = current_pos.y + 1
        local vi = area:index(current_pos.x, current_pos.y, current_pos.z)
        data[vi] = chorus_plant

        -- Randomly decide if we branch
        if pr:next(1, 2) == 1 then
            local branch_dir = pr:next(1, 4)
            local branch_pos
            if not mcl_better_end.api.is_free(current_pos.x, current_pos.y, current_pos.z) then
                return 
            end
            if branch_dir == 1 then
                branch_pos = {x = current_pos.x + 1, y = current_pos.y, z = current_pos.z}
            elseif branch_dir == 2 then
                branch_pos = {x = current_pos.x - 1, y = current_pos.y, z = current_pos.z}
            elseif branch_dir == 3 then
                branch_pos = {x = current_pos.x, y = current_pos.y, z = current_pos.z + 1}
            else
                branch_pos = {x = current_pos.x, y = current_pos.y, z = current_pos.z - 1}
            end
            
            local vi = area:index(branch_pos.x, branch_pos.y, branch_pos.z)
            data[vi] = chorus_plant

            -- Potentially grow a flower on the branch
            if pr:next(1, 2) == 1 then
                local vi = area:index(branch_pos.x, branch_pos.y + 1, branch_pos.z)
                data[vi] = chorus_plant_top
            end
            current_pos = branch_pos
        end
    end
    local vi = area:index(current_pos.x, current_pos.y, current_pos.z)
    data[vi] = chorus_plant_top
end


mcl_better_end.api.register_biome({
    type = "island",
    gen = function(data, vi, area, pr, x, y, z, perlin_l, noise_center)
        data[vi] = filler

        if pr:next(1, 20) == 5 then
            if not mcl_better_end.api.is_island(x, y+1, z) then
                local vi = area:index(x, y+1, z)
                data[vi] = topper
            end

        elseif pr:next(1, 100) == 5 then
            data[vi] = mcl_better_end.mapgen.registered_nodes.end_stone    
            grow_chorus_branch({x = x, y = y, z = z}, pr:next(1, 20), pr, data, area)

        elseif pr:next(1, 200) == 46 then
            if not mcl_better_end.api.is_island(x, y+1, z) then
                local vi = area:index(x, y+1, z)
                data[vi] = magibulb
            end
        end
        
    end,
    dec = function(pr, x, y, z, perlin_l, noise_center)
        if pr:next(1, 600) == 2 then 
            minetest.add_entity({x = x, y = y+1, z = z}, "mobs_mc:enderman", minetest.serialize({}))

        elseif pr:next(1, 800) == 2 then 
            minetest.add_entity({x = x, y = y+1, z = z}, "mobs_mc:shulker", minetest.serialize({}))
        end
    end,
    noise_high = 0,
    noise_low = -1
})
