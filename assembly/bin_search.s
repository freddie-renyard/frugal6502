; Conduct a binary search of the characters defined in
; the heap. Print the position of the character in the
; string to the display.

; System Addresses
DISP_INST = $8000 ; Display - write to instruction register address
DISP_CHAR = $8001 ; Display - write character address

RST_VEC = $0200
HEAP_ADDR = $0400

; Constants
STALL_T = 64
NULL = $00

; MANUAL MEMORY MANAGEMENT - in the zero-page to save access times.
RESULT  = $00       ; The address at which the search result is stored.
LOW     = $01       ; Where the low value is stored
HIGH    = $02       ; Where the high value is stored

TARGET  = $05       ; Where the target character is stored

SEED    = $06       ; Where the seed for the pseudorandom number generator is found.

BIN     = $07       ; Where the target for the binary to BCD conversion is stored.
BCD     = $08       ; Where the BCD results are stored (packed across two bytes)

    .org RST_VEC

; Equivalent binary search algorithm in C (for comparison):

; int bin_search(int x, int* arr, int n) {
;    
;    int low = 0;
;    int high = n - 1;
;    int mid;
;
;    while (low <= high) {
;       mid = low + (high - low) / 2;
;
;        if (x < arr[mid]) {
;            high = mid - 1;
;        } else if (x > arr[mid]) {
;            low = mid + 1;
;        } else {
;            return mid;
;        }
;    }
;
;    return -1;
;} 

main:
    jsr lcd_config_b    ; Configure the display for two line mode
    
    ldx #0              ; Ensure that the heap pointer is set to 0.
    jsr write_string    ; Write the target string to the display
    jsr line_break      ; Go to the next line to print the result.

    jsr get_letter      ; Load a random target letter to the A register.
    jsr bin_search      ; Conduct the search.

    lda RESULT          ; Load the value to convert into the A register
    jsr BINBCD8         ; Convert the value to BCD.

    jsr disp_bcd_3_digit    ; Display the converted BCD.

    jsr stall           ; Stall to allow the result to be seen.

    jmp main            ; Repeat forever.

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
    ; Stall execution so that the results of the search can be seen.
    ldx #STALL_T
    jsr delay
    rts

delay:
    ; Decrement the x register until it is 0.
    dex
    cpx #0
    bne delay
    rts

write_string:
    lda HEAP_ADDR, x    ; Get the current character that the X register points to (plus heap offset).
    inx                 ; Increment the string pointer.

    cmp #NULL
    bne write_letter    ; Check if the last byte of the string has been loaded (C-style \0 termination)

    rts

line_break:
    ; Go to the next line on the display.
    lda #%11000000
    sta DISP_INST

    rts

write_letter:
    sta DISP_CHAR
    jmp write_string

bin_search:

    sta DISP_CHAR    
    sta TARGET      ; Store the value of A (the target of the search)

    jsr get_length  ; Compute the HIGH value

    ; Ensure the HIGH value indexes a zero indexed string.
    ldx HIGH
    dex
    stx HIGH 

    ; Ensure the low index begins at 0.
    lda #0
    sta LOW

    ; Begin iterating the search loop.
    jsr search_iter

    rts

search_iter:

    ; Display an arrow for each iteration.
    lda #%00111110
    sta DISP_CHAR

    ; Check that the limits aren't indicating that the element
    ; isn't in the list.
    lda HIGH
    cmp LOW
    bcc not_found

    sbc LOW     ; Get the midpoint of the two limits.
    lsr         ; Divide by two.
    adc LOW     ; Add LOW back into the A register.

    tax         ; Transfer the midpoint value to the X register.
    lda HEAP_ADDR, x    ; Get the relevant character to compare to.

    cmp TARGET
    beq found       ; The value has been found.
    bcc val_lower   ; The high value needs to be set to the midpoint-1.
    jmp val_higher  ; The low value needs to be set to the midpoint+1.

not_found:
    lda #$FF
    sta RESULT
    rts

found:
    stx RESULT
    rts 

val_lower:
    inx
    stx LOW
    jmp search_iter

val_higher:
    dex
    stx HIGH
    jmp search_iter

get_length:
    ldx #0
    jmp incr_length

incr_length:

    lda HEAP_ADDR, x
    inx

    cmp #NULL ; Compare the current letter to the null terminator.

    bne incr_length 

    dex         ; Decrement x, as the null terminator has been counted.
    stx HIGH    ; Store the value at the HIGH address.

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

get_letter:
    ; Get a random letter from the target string and load it into the A register.

    ; Get a random number in the A register.
    jsr get_rand

    ; Shift the random number (range 0 - 2^8) to get a range of 16 (2 ^ 4).
    lsr
    lsr
    lsr
    lsr
    tax 

    lda HEAP_ADDR, x

    rts

get_rand:
    ; Generate random number.
    lda SEED

    ; Multiply the seed by 5.
    asl 
    asl
    clc
    adc SEED
    clc
    
    ; Add 17 to the seed.
    adc #17 

    sta SEED

    rts

    .org HEAP_ADDR
    .byte "abcdefghijklmnopq", NULL