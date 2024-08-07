


--add nodes
mcl_better_end.mapgen.registered_nodes.plains_filler = minetest.get_content_id("mcl_better_end:end_stone_plains_turf")
mcl_better_end.mapgen.registered_nodes.plains_topper = minetest.get_content_id("mcl_better_end:end_stone_plains_grass")




mcl_better_end.biomes.plains = {
    gen = function(data, vi, area, pr, x, y, z)
        data[vi] = mcl_better_end.mapgen.registered_nodes.plains_filler

        --add top
        if pr:next(1, 10) == 5 then
            local vi = area:index(x, y+1, z)
            if data[vi] == mcl_better_end.mapgen.registered_nodes.air then
                data[vi] = mcl_better_end.mapgen.registered_nodes.plains_topper
            end
        end
    end
}