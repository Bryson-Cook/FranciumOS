#include "timer.h"
#include "screen.h"
#include "ports.h"
#include "../kernel/util.h"
#include "../cpu/isr.h"

uint32_t tick = 0;

static void timer_callback(registers_t *regs) {
    tick++;
    IGNORE(regs);
}

void init_timer(uint32_t freq) {
    register_interrupt_handler(IRQ0, timer_callback);

    // Calculate values
    uint32_t divisor = PIT_FREQUENCY / freq;
    uint8_t low  = (uint8_t)(divisor & 0xFF);
    uint8_t high = (uint8_t)( (divisor >> 8) & 0xFF);
    
    // Send data to ports
    outb(TIMER_COMMAND, TIMER_OCW);
    outb(TIMER_DATA, low);
    outb(TIMER_DATA, high);
}

uint32_t get_ticks() {
    return tick;
}