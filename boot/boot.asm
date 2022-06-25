[org 0x7c00]
KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl        ; Save boot drive stored in 'dl' provided by BIOS
mov bp, 0x9000
mov sp, bp

mov bx, MSG_16BIT_MODE
call print16
call print16_nl

call load_kernel            ; read the kernel from disk
call switch_to_32bit        ; disable interrupts, load GDT, Finally jumps to 'BEGIN_32BIT'
jmp $                       ; Infinite loop (Never should enter)

%include "boot/print16.asm"
%include "boot/print32.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print16
    call print16_nl

    mov bx, KERNEL_OFFSET   ; Read from disk and store in 0x1000
    mov dh, 31
    mov dl, [BOOT_DRIVE]
    call disk_load          ; Called from disk.asm
    ret

[bits 32]
BEGIN_32BIT:
    mov ebx, MSG_32BIT_MODE
    call print32
    call KERNEL_OFFSET      ; Enter Kernel
    jmp $                   ; Infinite loop (Never should enter)


BOOT_DRIVE db 0             ; 'dl' can be overwritten, best practice to save the value somewhere
MSG_16BIT_MODE db "MODE: 16-bit Real Mode", 0
MSG_32BIT_MODE db "MODE: 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory.", 0
MSG_ERROR db "[ERROR] Unknown Error!", 0

; Padding and signature
times 510 - ($-$$) db 0
dw 0xaa55
