#include <neocore.h>
// #include "externs.h"

static void init();
static void update();

static void init() {
}

static void update() {
  nc_init_log();
  nc_log_info("HELLO NEO GEO !!!");
}

int main(void) {
  init();
  while(1) {
    nc_update();
    update();
  };
  return 0;
}
