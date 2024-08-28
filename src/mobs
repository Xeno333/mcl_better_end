-- Define the mob
minetest.register_entity("mcl_better_end:endfish", {
    hp_max = 10, -- Health points
    physical = true, -- Physical entity (can be interacted with)
    weight = 0, -- Weight (affects how it interacts with other entities)
    collisionbox = {-0.5, 0, -0.5, 0.5, 1.5, 0.5}, -- Collision box dimensions
    visual = "cube", -- Visual representation as a box
    mesh = "mymob.b3d", -- Mesh file for the mob
    textures = {"mymob_texture.png"}, -- Texture for the mesh
    visual_size = {x=1, y=1}, -- Size of the visual representation

    -- Behavior
    on_punch = function(self, hitter, tuch, point)
        -- Behavior when punched
        self.object:remove() -- Remove the mob when punched
    end,

    -- Step function called every server step
    on_step = function(self, dtime)
        -- Behavior per step (e.g., movement)
        -- Example: Move forward
        local pos = self.object:get_pos()
        pos.x = pos.x + 0.1
        self.object:set_pos(pos)
    end,

    -- Initialization
    on_activate = function(self, staticdata, dtime_s)
        -- Initialization code
    end,
})
