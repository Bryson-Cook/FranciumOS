; Defined in isr.c
[extern isr_handler]
[extern irq_handler]

; Interrupt Service Routine (ISR)
isr_common_stub:
    ; Save state
	pusha
	mov ax, ds
	push eax           
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

    push esp            ; registers_t *r
	call isr_handler
	pop eax

    ; Restore state
	pop eax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	popa
	add esp, 8          ; Cleans up the pushed error code and pushed ISR number
	iret                ; pop CS, EIP, EFLAGS, SS, and ESP

; Interrupt Request (IRS)
irq_common_stub:
    ; Save state
    pusha
    mov ax, ds
    push eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; Call C function
    push esp
    call irq_handler
    pop ebx

    ; Restore state
    pop ebx
    mov ds, bx
    mov es, bx
    mov fs, bx
    mov gs, bx
    popa
    add esp, 8
    iret

; ISR variables 
global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; Divide By Zero Exception
isr0:
    push byte 0
    push byte 0
    jmp isr_common_stub

; Debug Exception
isr1:
    push byte 0
    push byte 1
    jmp isr_common_stub

; Non-maskable Interrupt Exception
isr2:
    push byte 0
    push byte 2
    jmp isr_common_stub

; Breakpoint (INT3) Exception
isr3:
    push byte 0
    push byte 3
    jmp isr_common_stub

; Overflow (INTO) Exception
isr4:
    push byte 0
    push byte 4
    jmp isr_common_stub

; Bound Range Exceeded Exception
isr5:
    push byte 0
    push byte 5
    jmp isr_common_stub

; Invalid Opcode Exception
isr6:
    push byte 0
    push byte 6
    jmp isr_common_stub

; Device Not Available Exception
isr7:
    push byte 0
    push byte 7
    jmp isr_common_stub

; Double Fault Exception (Error Code)
isr8:
    push byte 8
    jmp isr_common_stub

; Coprocessor Segment Overrun Exception (Outdated)
isr9:
    push byte 0
    push byte 9
    jmp isr_common_stub

; Invalid TSS Exception (Error Code)
isr10:
    push byte 10
    jmp isr_common_stub

; Segment Not Present Exception (Error Code)
isr11:
    push byte 11
    jmp isr_common_stub

; Stack-Segment Fault Exception (Error Code)
isr12:
    push byte 12
    jmp isr_common_stub

; General Protection Fault Exception (Error Code)
isr13:
    push byte 13
    jmp isr_common_stub

; Page Fault Exception (Error Code)
isr14:
    push byte 14
    jmp isr_common_stub

; Reserved Exception
isr15:
    push byte 0
    push byte 15
    jmp isr_common_stub

; Floating Point Exception
isr16:
    push byte 0
    push byte 16
    jmp isr_common_stub

; Alignment Check Exception
isr17:
    push byte 0
    push byte 17
    jmp isr_common_stub

; Machine Check Exception
isr18:
    push byte 0
    push byte 18
    jmp isr_common_stub

; Reserved Exception
isr19:
    push byte 0
    push byte 19
    jmp isr_common_stub

; Reserved Exception
isr20:
    push byte 0
    push byte 20
    jmp isr_common_stub

; Reserved Exception
isr21:
    push byte 0
    push byte 21
    jmp isr_common_stub

; Reserved Exception
isr22:
    push byte 0
    push byte 22
    jmp isr_common_stub

; Reserved Exception
isr23:
    push byte 0
    push byte 23
    jmp isr_common_stub

; Reserved Exception
isr24:
    push byte 0
    push byte 24
    jmp isr_common_stub

; Reserved Exception
isr25:
    push byte 0
    push byte 25
    jmp isr_common_stub

; Reserved Exception
isr26:
    push byte 0
    push byte 26
    jmp isr_common_stub

; Reserved Exception
isr27:
    push byte 0
    push byte 27
    jmp isr_common_stub

; Reserved Exception
isr28:
    push byte 0
    push byte 28
    jmp isr_common_stub

; Reserved Exception
isr29:
    push byte 0
    push byte 29
    jmp isr_common_stub

; Reserved Exception
isr30:
    push byte 0
    push byte 30
    jmp isr_common_stub

; Reserved Exception
isr31:
    push byte 0
    push byte 31
    jmp isr_common_stub



; IRQ variables
global irq0
global irq1
global irq2
global irq3
global irq4
global irq5
global irq6
global irq7
global irq8
global irq9
global irq10
global irq11
global irq12
global irq13
global irq14
global irq15

; System Timer
irq0:
	push byte 0
	push byte 32
	jmp irq_common_stub

; PS2 Keyboard
irq1:
	push byte 1
	push byte 33
	jmp irq_common_stub

; ???
irq2:
	push byte 2
	push byte 34
	jmp irq_common_stub

; Serial Port 2
irq3:
	push byte 3
	push byte 35
	jmp irq_common_stub

; Serial Port 1
irq4:
	push byte 4
	push byte 36
	jmp irq_common_stub

; Parallel Port 3 or Sound Card
irq5:
	push byte 5
	push byte 37
	jmp irq_common_stub

; Floppy Disk
irq6:
	push byte 6
	push byte 38
	jmp irq_common_stub

; Parallel Port 1 (and 2)
irq7:
	push byte 7
	push byte 39
	jmp irq_common_stub

; Real Time Clock
irq8:
	push byte 8
	push byte 40
	jmp irq_common_stub

; Advanced Configuration and Power Interface
irq9:
	push byte 9
	push byte 41
	jmp irq_common_stub

; Intentionally Empty
irq10:
	push byte 10
	push byte 42
	jmp irq_common_stub

; Intentionally Empty
irq11:
	push byte 11
	push byte 43
	jmp irq_common_stub

; PS2 Mouse
irq12:
	push byte 12
	push byte 44
	jmp irq_common_stub

; ???
irq13:
	push byte 13
	push byte 45
	jmp irq_common_stub

; Primary ATA
irq14:
	push byte 14
	push byte 46
	jmp irq_common_stub

; Secondary ATA
irq15:
	push byte 15
	push byte 47
	jmp irq_common_stub
