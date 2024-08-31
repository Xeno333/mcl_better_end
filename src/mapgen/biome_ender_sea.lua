-- Define items to add to the chest with their max count and chance
local items_to_add = {
    {i = "mcl_better_end:ender_shard", c = 1, x = 5},
    {i = "mcl_better_end:end_glow_berry", c = 16, x = 3},
    {i = "mcl_end:crystal", c = 32, x = 20},
    {i = "mcl_throwing:ender_pearl", c = 4, x = 3},
    {i = "mcl_throwing:ender_pearl", c = 16, x = 10},
    {i = "mcl_armor:elytra", c = 1, x = 10},
}


--due to migration to mineclonia
minetest.register_alias("mcl_end:end_rod_cyan", "mcl_end:end_rod")



-- Function to place a schematic and a chest, then fill the chest with items
local function make_sub(pos, pr)
    -- Place the schematic
    minetest.place_schematic(pos, mcl_better_end.schematic_loc .. "/end_sub.mts", "0", nil, true)

    -- Define chest position
    local chest_pos = {x = pos.x + 4, y = pos.y + 1, z = pos.z + 4}

    -- Place the chest
    minetest.set_node(chest_pos, {name = "mcl_chests:chest"})

    -- Get chest metadata and inventory
    local meta = minetest.get_meta(chest_pos)
    local inv = meta:get_inventory()
    inv:set_size("main", 16)  -- Initialize inventory

    local slots_used_c = 0
    local slots_used = {}

    -- Fill the chest with items
    while slots_used_c < 6 do
        for _, item in ipairs(items_to_add) do
            local item_name = item.i
            local quantity = item.c

            -- Determine if the item should be included based on chance
            if pr:next(1, item.x) == item.x then
                -- Select a random slot
                local slot = pr:next(1, 16)
                while slots_used[slot] do
                    slot = pr:next(1, 16)
                end
                
                inv:set_stack("main", slot, item_name .. " " .. pr:next(1, quantity))

                slots_used[slot] = true
                slots_used_c = slots_used_c + 1
                if slots_used_c == 16 then
                    return
                end
            end
        end
    end
end



mcl_better_end.api.register_biome({
    type = "sea",
    dec = function(pr, x, y, z, perlin_l, noise_center, plnoise, plnoise_1)
        if pr:next(1, 4000) == 5 then
            if plnoise < (mcl_better_end.api.consts.sea_ends + 0.00001) then
                make_sub({x=x,y=y,z=z}, pr)
            end
        end
    end,
    noise_high = 1,
    noise_low = 0
})

--[[minetest.register_chatcommand("spawn_endsub", {
    params = "<radius>",
    description = "Check if the area around you is empty within a certain radius",
    func = function(player_name, param)
        -- Get the player's position
        local player = minetest.get_player_by_name(player_name)
        local pos = player:get_pos()
        make_sub(pos, PseudoRandom(math.random(1, 1000)))
    end,
})]]--