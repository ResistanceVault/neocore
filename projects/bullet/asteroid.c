#include <neocore.h>
#include "externs.h"
#include "asteroid.h"

static Image_Physic asteroid;
static BYTE hit;

void asteroid_init() {
  hit = 0;
  image_physic_init(&asteroid, &asteroid_sprite, &asteroid_sprite_Palettes, 8, 8, 0, 0);
}

void asteroid_display() {
  image_physic_display(&asteroid, 200, 100);
}

void asteroid_update() {
  logger_init();
  logger_byte("HIT", hit);
}

BOOL asteroid_collide(Box *b) {
  BOOL r = false;
  if (box_collide(&asteroid.box, b)) {
    hit += 1;
    r = true;
  }
  return r;
}
