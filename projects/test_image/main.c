#include <neocore.h>
#include <math.h>

NEOCORE_INIT

int main(void) {
  gpu_init();
  while(1) {
    WAIT_VBL
    logger_init();
    logger_info("HELLO NEO GEO !!!");
    SCClose();
  };
  SCClose();
  return 0;
}
