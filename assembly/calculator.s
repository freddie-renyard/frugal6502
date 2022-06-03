; A Polish notation stack calculator, inspired by the example given in 'The C Programming Language'

; System Addresses
DISP_INST = $8000 ; Display - write to instruction register address
DISP_CHAR = $8001 ; Display - write character address

RST_VEC = $0200
HEAP_ADDR = $0400
TEXT_OFFSET = $50

NULL = 0

; MANUAL MEMORY ALLOCATION
TEMP = $03
RESULT = $04
BIN = $10
BCD = $11

; CALCULATOR OPERANDS
OP1 = $20
OP2 = $21
OP3 = $22
OP4 = $24

    .org RST_VEC

main:
    jsr lcd_config_b

    ldy #0
    jsr disp_string      ; Display the calculation to be performed

    jsr line_break

    ldy #TEXT_OFFSET
    jsr disp_string

    jsr perform_calc
    
    ;jsr inv_dabble

    lda RESULT
    jsr BINBCD8
    jsr disp_bcd_3_digit

    jmp stall

perform_calc:
    ; Perform the calculation in the string.
    ldy #0

    ; Get the first operand in the string.
    lda HEAP_ADDR, y

    sbc #$30 ; subtract the offset.

    ; HERE: check that the number is between 0 and 9. Add a number and check the carry!!
    clc
    adc #246
    bcc store_bcd_1
    jmp eval_digit_2

eval_digit_2:

    rts

store_bcd_1:
    lda HEAP_ADDR, y
    sbc #$30 ; subtract the offset.
    sta BCD
    sta RESULT ; Debug
    jmp eval_digit_2

store_bcd_2:
    nop

store_bcd_3:
    nop

disp_string:
    ; Displays the string whose first character is pointed to by the y register.
    lda HEAP_ADDR, y
    jsr disp_char
    rts

disp_char:
    ; String display loop.
    sta DISP_CHAR

    iny
    lda HEAP_ADDR, y

    cmp #NULL
    bne disp_char

    rts

inv_dabble:

    ; Ensure that the starting registers are 0
    lda #0
    sta BIN
    ldy #0

    jsr dabble_iter

    rts

dabble_iter:

    iny         ; Increment the number of overall shifts that have been performed.

    clc         ; Clear the carry bit to ensure it doesn't interfere with execution
    lsr BCD+1   ; Shift the most significant BCD byte right
    ror BCD     ; Rotate the carry bit into the least significant BCD
    ror BIN     ; Rotate the carry bit into the output binary

    lda BCD+1   ; Load the Most significant BCD.
    cmp #8      
    bcs sub_3_digit_3
    jmp digit_2

digit_2:
    lda BCD     ; Get the second most significant BCD
    lsr
    lsr
    lsr
    lsr
    cmp #8      
    bcs sub_3_digit_2
    jmp digit_1

digit_1:
    ; Convert back into the representation and store the 
    ; result in a temporary memory address.
    clc
    asl
    asl
    asl
    asl
    sta TEMP

    lda BCD         ; Get the least significant BCD
    and #%00001111  ; clear all bits that aren't part of the least significant BCD
    cmp #8      
    bcs sub_3_digit_1

finish:
    ; Combine the two least significant BCDs together and store them.
    ora TEMP 
    sta BCD

    ; Check if 8 shifts have been performed.
    cpy #8
    bcc dabble_iter

    rts

sub_3_digit_3:
    sbc #3
    sta BCD+1
    jmp digit_2

sub_3_digit_2:
    sbc #3
    jmp digit_1

sub_3_digit_1:
    sbc #3
    jmp finish

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

line_break:
    ; Go to the next line on the display.
    lda #%11000000
    sta DISP_INST

    rts

; Code source : http://www.6502.org/source/integers/hex2dec-more.htm
BINBCD8:
    ; Conversion will be performed on the value in the A register.
    sta BIN
    SED		    ; Switch to decimal mode
    LDA #0		; Ensure the result is clear
    STA BCD+0
    STA BCD+1
    LDX #8		; The number of source bits

    jmp CNVBIT

CNVBIT:		
    ASL BIN		; Shift out one bit
    LDA BCD+0	; And add into result
    ADC BCD+0
    STA BCD+0
    LDA BCD+1	; propagating any carry
    ADC BCD+1
    STA BCD+1
    DEX		; And repeat for next bit
    BNE CNVBIT
    CLD		; Back to binary

    rts

; Display a 3 digit bcd number on the screen.
disp_bcd_3_digit:

    lda BCD+1
    adc #%00110000
    sta DISP_CHAR

    lda BCD
    lsr 
    lsr 
    lsr
    lsr
    adc #%00110000
    sta DISP_CHAR

    lda BCD
    and #%00001111
    adc #%00110000
    sta DISP_CHAR

    rts

stall:
    nop
    jmp stall

; Constant memory pool declaration
    .org HEAP_ADDR
    .byte "33 3 +", $00

    .org (HEAP_ADDR + TEXT_OFFSET)
    .byte "Result: ", $00