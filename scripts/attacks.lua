mask_shader = love.graphics.newShader[[
   vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
      if (Texel(texture, texture_coords).rgb == vec3(0.0)) {
         // a discarded pixel wont be applied as the stencil.
         discard;
      }
      return vec4(1.0);
   }
]]

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
   return x1 < x2+w2 and
          x2 < x1+w1 and
          y1 < y2+h2 and
          y2 < y1+h1
 end

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

   if CheckCollision(player.x + player.hitbox_leniency, player.y + player.hitbox_leniency, player.img:getWidth() - (player.hitbox_leniency * 2), player.img:getHeight() - (player.hitbox_leniency * 2), love.mouse.getX(), love.mouse.getY(), 10, 100) then
      inv_frame_timer = inv_frame_timer + (love.timer.getDelta() * 30)
      if inv_frame_timer > player.inv_frames then
         inv_frame_timer = 0
         hurt_player()
      end
   end
end