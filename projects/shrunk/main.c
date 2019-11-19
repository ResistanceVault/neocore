#include <neocore.h>
#include "externs.h"

NEOCORE_INIT

int main(void) {
  picture logo1, logo2, logo3;
  BYTE logo1_shrunk_x = 0;
  BYTE logo2_shrunk_y = 0;
  gpu_init();
  logger_init();
  palette_disable_autoinc(); /* logo1, logo2 & logo3 use the same palette ... disable auto counter */
  logger_info("HORIZONTAL SHRUNK");
  image_display(&logo1, &logo_sprite, &logo_sprite_Palettes, 10, 20);
  logger_set_position(1, 10);
  logger_info("VERTICAL SHRUNK");
  image_display(&logo2, &logo_sprite, &logo_sprite_Palettes, 10, 80);
  logger_set_position(1, 19);
  logger_info("PROPORTIONAL SHRUNK");
  image_display(&logo3, &logo_sprite, &logo_sprite_Palettes, 10, 150);
  palette_enable_autoinc();

  while(1) {
    waitVBlank();
    if (DAT_frameCounter % 5 == 0) logo1_shrunk_x++;
    logo2_shrunk_y +=3 ;
    image_shrunk(&logo1, &logo_sprite, shrunkForge(logo1_shrunk_x, 0xFF));
    image_shrunk(&logo2, &logo_sprite, shrunkForge(0XF, logo2_shrunk_y));
    image_shrunk(&logo3, &logo_sprite, shrunkPropTableGet(DAT_frameCounter & SHRUNK_TABLE_PROP_SIZE)); /* neocore provide a precalculated table for keep "aspect ratio" */
    SCClose();
  };
  SCClose();
  return 0;
}
