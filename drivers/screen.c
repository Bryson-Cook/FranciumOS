#include "screen.h"
#include "ports.h"
#include <stdint.h>
#include "../kernel/mem.h"
#include "../kernel/util.h"

uint32_t t;

void set_cursor(int offset) {
    offset /= 2;
    outb(VGA_CTRL_REGISTER, 14);
    outb(VGA_DATA_REGISTER, (uint8_t) (offset >> 8));
    outb(VGA_CTRL_REGISTER, 15);
    outb(VGA_DATA_REGISTER, (uint8_t) (offset & 0xff));
}

int get_cursor() {
    outb(VGA_CTRL_REGISTER, 14);
    int offset = inb(VGA_DATA_REGISTER) << 8;
    outb(VGA_CTRL_REGISTER, 15);
    offset += inb(VGA_DATA_REGISTER);
    return offset * 2;
}

int get_offset(int col, int row) {
    return 2 * (row * VGA_WIDTH + col);
}

int get_offset_row(int offset) {
    return offset / (2 * VGA_WIDTH);
}

int get_offset_col(int offset) { 
    return (offset - (get_offset_row(offset)*2*VGA_WIDTH))/2; 
}

int set_offset_newline(int offset) {
    return get_offset(0, get_offset_row(offset) + 1);
}

void terminal_putentryat(char character, int offset) {
    uint8_t *vidmem = (uint8_t *) VGA_MEMORY;
    vidmem[offset] = character;
    vidmem[offset + 1] = vga_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
}

int terminal_scroll(int offset) {
    memory_copy(
            (uint8_t * )(get_offset(0, 1) + VGA_MEMORY),
            (uint8_t * )(get_offset(0, 0) + VGA_MEMORY),
            VGA_WIDTH * (VGA_HEIGHT - 1) * 2
    );

    for (int col = 0; col < VGA_WIDTH; col++) {
        terminal_putentryat(' ', get_offset(col, VGA_HEIGHT - 1));
    }

    return offset - 2 * VGA_WIDTH;
}

void terminal_writestring(const char *data) {
    int offset = get_cursor();
    int i = 0;
    while (data[i] != 0) {
        if (offset >= VGA_HEIGHT * VGA_WIDTH * 2) {
            offset = terminal_scroll(offset);
        }
        if (data[i] == '\n') {
            offset = set_offset_newline(offset);
        } else {
            terminal_putentryat(data[i], offset);
            offset += 2;
        }
        i++;
    }
    set_cursor(offset);
}

void terminal_newline() {
    int newOffset = set_offset_newline(get_cursor());
    if (newOffset >= VGA_HEIGHT * VGA_WIDTH * 2) {
        newOffset = terminal_scroll(newOffset);
    }
    set_cursor(newOffset);
}

void terminal_clearscreen() {
    int screen_size = VGA_WIDTH * VGA_HEIGHT;
    for (int i = 0; i < screen_size; ++i) {
        terminal_putentryat(' ', i * 2);
    }
    set_cursor(get_offset(0, 0));
}

void terminal_backspace() {
    int newCursor = get_cursor() - 2;
    terminal_putentryat(' ', newCursor);
    set_cursor(newCursor);
}

void terminal_printerror() {
	uint8_t *vidmem = (uint8_t *) VGA_MEMORY;
    vidmem[2*(VGA_WIDTH)*(VGA_HEIGHT)-2] = 'E';
    vidmem[2*(VGA_WIDTH)*(VGA_HEIGHT)-1] =  vga_color(VGA_COLOR_WHITE, VGA_COLOR_LIGHT_RED);
}
