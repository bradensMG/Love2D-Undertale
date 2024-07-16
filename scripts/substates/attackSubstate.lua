mask_shader = love.graphics.newShader[[
   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
         // a discarded pixel wont be applied as the stencil.
         discard;
      }
      return vec4(1.0);
   }
]]

function my_stencil_function()
   love.graphics.setShader(mask_shader)
   -- blue -- love.graphics.setColor(0, .75, 1, 1)
   -- orange -- love.graphics.setColor(1, .5, .2, 1)
   love.graphics.draw(bone, love.mouse.getX(), love.mouse.getY())
   love.graphics.setShader()
end

function draw_attack()
    love.graphics.stencil(my_stencil_function, "replace", 1)
    love.graphics.setStencilTest("greater", 0)
    love.graphics.rectangle("fill", box_x + 2, box_y + 2, box_width - 4, box_height - 4)
    love.graphics.setStencilTest()
end