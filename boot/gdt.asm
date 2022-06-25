gdt_start:          ; Null descriptor
    dd 0x0          ; 4 bytes
    dd 0x0          ; 4 bytes


gdt_code:           ; Kernel Code Segment Descriptor
    dw 0xffff       ; Limit             (bits 0-15)
    dw 0x0          ; Base              (bits 0-15)
    db 0x0          ; Base              (bits 16-23)
    db 10011010b    ; Flags, Type flags
    db 11001111b    ; Flags, Limit      (bits 16-19)
    db 0x0          ; Base              (bits 24-31)

gdt_data:           ; Kernel Data Segment Descriptor
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b    ; Only change from Kernel Code Segment
    db 11001111b
    db 0x0

gdt_end:            ; TODO: Add a user code segment, user data segment (Ring 3) and eventually a Task State Segment (TSS)

; GDT descriptor
gdt_descriptor:
    dw gdt_end - gdt_start - 1  ; Size of GDT
    dd gdt_start                ; Start address of GDT

; Segment Constants
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
