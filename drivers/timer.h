#pragma once

#include "../kernel/util.h"

#define PIT_FREQUENCY 1193180

#define TIMER_OCW     0x36      // Square Wave Generator, low then high byte
#define TIMER_DATA    0x40      // Channel 0 Data Port (R/W)
#define TIMER_SPEAKER 0x42      // Channel 2 Data Port (R/W)
#define TIMER_COMMAND 0x43      // Command Register (W)

void init_timer(uint32_t freq);
uint32_t get_ticks();