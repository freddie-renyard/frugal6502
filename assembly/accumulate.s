DISP_INST = $8000 ; Display - write to instruction register address
DISP_CHAR = $8001 ; Display - write character address

BIN = $00
BCD = $01

TARGET = $80

	.org $0200

init:
    lda #0
    sta TARGET

; Configure the display settings
disp_config:
	lda #%00000001
	sta DISP_INST

	lda #%00001110
	sta DISP_INST

	lda #%00000110
	sta DISP_INST

incr:
    lda TARGET
    adc #1
    sta TARGET
    sta BIN

; Code source : http://www.6502.org/source/integers/hex2dec-more.htm
BINBCD8:	
    SED		; Switch to decimal mode
    LDA #0		; Ensure the result is clear
    STA BCD+0
    STA BCD+1
    LDX #8		; The number of source bits

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

clear_disp:
    ; Same as routine above (disp_config).

    lda #%00000001
	sta DISP_INST

	lda #%00001110
	sta DISP_INST

	lda #%00000110
	sta DISP_INST

disp_bcd:

    lda #'V'
    sta DISP_CHAR
    lda #'a'
    sta DISP_CHAR
    lda #'l'
    sta DISP_CHAR
    lda #'u'
    sta DISP_CHAR
    lda #'e'
    sta DISP_CHAR
    lda #':'
    sta DISP_CHAR
    lda #' '
    sta DISP_CHAR

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

stall: 
    jmp incr