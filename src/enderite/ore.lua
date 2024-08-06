local YMAX = -27000
local YMIN = -27020



minetest.register_node("mcl_better_end:enderite_ore", {
    description = "Ore of Enderite",
    tiles = {
        "mcl_end_end_stone.png^end_stone_with_enderite.png",
    },
    stack_max = 64,

    sounds = mcl_sounds.node_sound_stone_defaults(),
    _mcl_blast_resistance = 1200,
    _mcl_hardness = 70,
    light_source = 10,  -- This makes the block emit light

    groups = {pickaxey=7, building_block=1, material_stone=1, mbe_plains=1},
})




local function gen_enderite_ore(minp, maxp, seed)
    -- Check if the current Y range is within the desired bounds
    if maxp.y < YMIN or minp.y > YMAX then
        return
    end


    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
    local data = vm:get_data()

    local filler = minetest.get_content_id("mcl_better_end:enderite_ore")
    local bye = minetest.get_content_id("mcl_end:end_stone")
    
    local pr = PseudoRandom((seed + minp.x + maxp.z) / 3)

    -- Loop through the area and set nodes
    for y = math.max(minp.y, YMIN), math.min(maxp.y, YMAX) do
        for z = minp.z, maxp.z do
            for x = minp.x, maxp.x do
                if pr:next(1, 1000) == 5 then
                    if pr:next(1, 10) == 5 then
                        local vi = area:index(x, y, z)
                        if data[vi] == bye then  -- Adjust the threshold for sea size and shape
                                data[vi] = filler
                        end
                    end
                end
            end
        end
    end

    vm:set_data(data)
    vm:write_to_map()
    vm:update_map()
end


minetest.register_on_generated(
    function(minp, maxp, seed)
        gen_enderite_ore(minp, maxp, seed)
    end
)