/*
  David Vandensteen
  2019
*/
#include <neocore.h>
#ifndef PLAYER_H
#define PLAYER_H

#define PLAYER_MAX_X  280
#define PLAYER_MIN_X  0

#define PLAYER_MAX_Y  200
#define PLAYER_MIN_Y  0

void player_init();
void player_update();
void player_display();
void player_collide(box *b);
void player_collides(box *boxes[], BYTE box_max);
aSpritePhysic *player_get();

#endif