print16:
    pusha

print16_loop:
    mov al, [bx]    ; 'bx' is a pointer to the string
    cmp al, 0       ; if 'al' is '\0'
    je print16_done

    mov ah, 0x0e    ; Set Teletype Mode
    int 0x10        ; BIOS Interrupt

    
    add bx, 1       ; increment pointer
    jmp print16_loop

print16_done:
    popa
    ret

print16_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a    ; Newline char
    int 0x10
    mov al, 0x0d    ; Carriage return
    int 0x10

    popa
    ret

; Print hex values that are passed in 'dx' 
; Converts it to ASCII (0-9) and (A-F) in 'PRINT16_HEX_OUT'
; Reference: https://www.cs.bham.ac.uk/~exr/lectures/opsys/10_11/lectures/os-dev.pdf
print16_hex:
    pusha

    mov cx, 0

print16_hex_loop:
    cmp cx, 4
    je print16_hex_end

    
    mov ax, dx 
    and ax, 0x000f 
    add al, 0x30 
    cmp al, 0x39
    jle print16_hex_step2
    add al, 7

print16_hex_step2:
    mov bx, PRINT16_HEX_OUT + 5
    sub bx, cx
    mov [bx], al
    ror dx, 4

    add cx, 1
    jmp print16_hex_loop

print16_hex_end:
    mov bx, PRINT16_HEX_OUT
    call print16

    popa
    ret

PRINT16_HEX_OUT:
    db '0x0000',0
