#include "../drivers/screen.h"
#include "../drivers/timer.h"
#include "../drivers/keyboard.h"
#include "../drivers/ports.h"

#include "util.h"

#include <cpuid.h>

static int get_model(void) {
    int ebx, unused;
    __cpuid(0, unused, ebx, unused, unused);
    return ebx;
}

void launch_shell() {
    terminal_writestring("\nWelcome to FranciumOS v0.0.1\n");
    terminal_writestring("\n> ");
}

void execute_command(char *input) {
    if (strcmp(input, "EXIT") == 0) {
        exit_command();
    } else if(strcmp(input, "ERROR") == 0) {
        error_command();
    } else if(strcmp(input, "CLEAR") == 0){
        clear_command();
    } else if(strcmp(input, "HELP") == 0){
        help_command(); 
    } else if(strcmp(input, "ABOUT") == 0){
        about_command(); 
    } else if(strcmp(input, "INFO") == 0){
        info_command(); 
    } else {
       command_unknown(input);
    }

    terminal_writestring("> ");
}

void exit_command() {
    terminal_writestring("SYSTEM HALTED!\n");
    asm volatile("hlt");
}

void error_command() {
    terminal_printerror();
}

void clear_command() {
    terminal_clearscreen();
}

void help_command() {
    terminal_writestring("Exit  - Halt CPU\n");
    terminal_writestring("Error - Print terminal error\n");
    terminal_writestring("Clear - Clear terminal\n");
    terminal_writestring("Help  - Display help menu\n");
    terminal_writestring("About - About this project\n");
    terminal_writestring("Info - System information\n");
}

void about_command() {
    terminal_writestring("Francium, being the most unstable element,\n");
    terminal_writestring("also is a fitting name for this project.\n");
    terminal_writestring("This project takes a lot of reading and debugging...\n");
    terminal_writestring("and so it takes a while to fix or add things.\n");
    terminal_writestring("Overall, it is a great learning expreience and\n");
    terminal_writestring("probably should never ever be used. :)\n");
    terminal_writestring("-Bryson Cook\n");
}

void info_command() {
    uint32_t ticks_int = get_ticks();
    char ticks_string[12];
    int_to_ascii(ticks_int, ticks_string);
    terminal_writestring("Current ticks: ");
    terminal_writestring(ticks_string);
    terminal_newline();

    int model_int = get_model();
    char model_string[12];
    int_to_ascii(model_int, model_string);
    terminal_writestring("Model: ");
    terminal_writestring(model_string);
    terminal_newline();

}

void command_unknown(char* input) {
    terminal_writestring("Unknown command: ");
    terminal_writestring(input);
    terminal_newline();
}