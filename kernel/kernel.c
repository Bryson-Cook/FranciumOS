#include "../cpu/idt.h"
#include "../cpu/isr.h"
#include "../drivers/screen.h"
#include "../drivers/timer.h"
#include "../drivers/keyboard.h"
#include "../drivers/ports.h"

#include "util.h"
#include "mem.h"
#include "shell.h"

void kernel_main() {
    isr_install();
    irq_install();
    
    launch_shell();

    for(;;) { /* Do nothing */ }
}


