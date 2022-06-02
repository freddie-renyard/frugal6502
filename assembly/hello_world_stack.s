DISP_INST = $8000 ; Display - write to instruction register address
DISP_CHAR = $8001 ; Display - write character address

HEAP_ADDR = $0300 ; Address that points to the start of the string in the heap.

; String constants
LINE_BREAK = $0A    ; \n
NULL = $00          ; \0

	.org $0200

main:

    ldx #$00

    jsr lcd_config_b

	; Write the string to the display
    jsr write_string

	jmp stall

; Configure the display settings - clear display, set to one line mode.
lcd_config_a:

	lda #%00000001
	sta DISP_INST

	lda #%00001110
	sta DISP_INST

	lda #%00000110
	sta DISP_INST

    rts

; Configure the display settings - clear display, set to two line mode.
lcd_config_b:
    lda #%00000001
	sta DISP_INST

	lda #%00111000
	sta DISP_INST

	lda #%00001110
	sta DISP_INST

	lda #%00000110
	sta DISP_INST

    rts

stall:
    nop
    jmp stall

write_string:

    lda HEAP_ADDR, x    ; Get the current character that the X register points to (plus heap offset).
    inx                 ; Increment the string pointer.

    cmp #LINE_BREAK     ; Check if the char represents a line break (0x0A = \n in ASCII)
    beq line_break

    cmp #NULL
    bne write_letter    ; Check if the last byte of the string has been loaded (C-style \0 termination)

    rts

line_break:
    lda #%11000000
    sta DISP_INST

    jmp write_string

write_letter:
    sta DISP_CHAR       ; Display the character.
    jmp write_string

; Set up constants
    .org HEAP_ADDR
    .byte "Hello!", LINE_BREAK, "How are you?", NULL