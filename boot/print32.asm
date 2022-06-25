[bits 32]

VIDEO_MEMORY equ 0xb8000
GREY_ON_BLACK equ 0x07

print32:
    pusha
    mov edx, VIDEO_MEMORY

print32_loop:
    mov al, [ebx]       ; ebx = char pointer
    mov ah, GREY_ON_BLACK

    cmp al, 0           ; check for '\0' (zero)
    je print32_done

    mov [edx], ax       ; store character + attribute in video memory
    add ebx, 1          ; increment char pointer
    add edx, 2          ; increment video mem pointer

    jmp print32_loop

print32_done:
    popa
    ret
