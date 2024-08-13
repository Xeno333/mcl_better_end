
minetest.register_craftitem("mcl_better_end:ender_shard", {
    stack_max = 64,
    description = "Ender Shard",
    inventory_image = "ender_shard.png",
})

minetest.register_on_mods_loaded(function()
    local endermite_def = minetest.registered_entities["mobs_mc:endermite"]

    if endermite_def then
        table.insert(endermite_def.drops, {name = "mcl_better_end:ender_shard", chance = 100})
    end
end)