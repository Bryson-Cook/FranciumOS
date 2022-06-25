[bits 16]
switch_to_32bit:
    cli                     ; Disable interrupts
    lgdt [gdt_descriptor]   ; Load the GDT
    mov eax, cr0
    or eax, 0x1             ; Set PE (Protected Mode Enable) bit in cr0 
    mov cr0, eax
    jmp CODE_SEG:init_32bit ; Far Jump

[bits 32]
init_32bit:                 
    mov ax, DATA_SEG        ; Update the segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Update the stack
    mov esp, ebp

    call BEGIN_32BIT        ; Called from boot.asm
