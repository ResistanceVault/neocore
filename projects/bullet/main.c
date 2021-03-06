/*
  David Vandensteen
  2020
*/
#include <neocore.h>
#include <math.h>
#include "player.h"
#include "asteroid.h"

NEOCORE_INIT

static void init();
static void display();
static void update();

static void init() {
  gpu_init();
  player_init(100, 100);
  asteroid_init();
}

static void display() {
  player_display();
  asteroid_display();
}

static void update() {
  player_update();
  asteroid_update();
}

int main(void) {
  init();
  display();
  while(1) {
    wait_vbl();
    update();
    SCClose();
  };
  SCClose();
  return 0;
}
