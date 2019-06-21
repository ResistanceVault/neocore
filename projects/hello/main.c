/*
	David Vandensteen
	2019
    <dvandensteen@gmail.com>
*/

#include <stdio.h>
#include <stdlib.h>
#include <DATlib.h>
#include <neocore.h>

typedef struct bkp_ram_info {
	WORD debug_dips;
	BYTE stuff[254];
	//256 bytes
} bkp_ram_info;

bkp_ram_info bkp_data;

int main(void) {
  gpuInit();
  while(1) {
    waitVBlank();
    loggerInit();
    /* logger set automatically the cursor position on next line */
    loggerInfo("HELLO NEO GEO !!!");
    loggerInfo("");
    loggerDword("FRAME : ", DAT_frameCounter);
    loggerInfo("");
    loggerInt("PRINT INT : ", 10);
    loggerShort("PRINT SHORT", -10);

    /* force a position */
    loggerPositionSet(7, 20);
    loggerInfo("NEOCORE BY DAVID VANDENSTEEN");

    /* logger is an easy way to write a text with coordinate constraint "less" */

    SCClose();
  };
	SCClose();
  return 0;
}
