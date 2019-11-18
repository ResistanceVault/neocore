#include <neocore.h>
#include "externs.h"

NEOCORE_INIT

int main(void) {
  aSpritePhysic player;
  picturePhysic asteroid;
  gpu_init();
  box_init(&player.box, 48, 16, 0, 0);
  box_init(&asteroid.box, (asteroid_sprite.tileWidth MULT8), 32, 0, 0);
  animated_sprite_physic_display(&player, &player_sprite, &player_sprite_Palettes, 10, 10, PLAYER_SPRITE_ANIM_IDLE);
  picturePhysicDisplay(&asteroid, &asteroid_sprite, &asteroid_sprite_Palettes, 100, 100);
  while(1) {
    waitVBlank();
    joypadUpdate();

    if (joypadIsLeft() && player.as.posX > 0) { animated_sprite_physic_move(&player, -1, 0); }
    if (joypadIsRight() && player.as.posX < 280) { animated_sprite_physic_move(&player, 1, 0); }
    if (joypadIsUp() && player.as.posY > 0) {
      animated_sprite_physic_move(&player, 0, -1);
      aSpriteSetAnim(&player.as, PLAYER_SPRITE_ANIM_UP);
    }
    if (joypadIsDown() && player.as.posY < 200) {
      animated_sprite_physic_move(&player, 0, 1);
      aSpriteSetAnim(&player.as, PLAYER_SPRITE_ANIM_DOWN);
    }
    if (!joypadIsDown() && !joypadIsUp()) { aSpriteSetAnim(&player.as, PLAYER_SPRITE_ANIM_IDLE); }
    (box_collide(&player.box, &asteroid.box)) ? animated_sprite_flash(&player.as, 4) : animated_sprite_flash(&player.as, false);

    aSpriteAnimate(&player.as);
    SCClose();
  };
  SCClose();
  return 0;
}
