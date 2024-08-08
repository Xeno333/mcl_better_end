

minetest.register_globalstep(function(dtime)
    for _, player in ipairs(minetest.get_connected_players()) do
        local pos = player:get_pos()
        
        -- Check if the player is below -26000
        if (pos.y < -26000) and (pos.y > -27100) then
            -- Set gravity to 0.5 for the player
            player:set_physics_override({
                gravity = 0.5,
            })
        else
            -- Reset gravity to default (1.0)
            player:set_physics_override({
                gravity = 1.0,
            })
        end
    end
end)
