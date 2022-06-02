DISP_INST = $8000 ; Display - write to instruction register address
DISP_CHAR = $8001 ; Display - write character address

	.org $0200

; Configure the display settings
disp_config:
	lda #%00000001
	sta DISP_INST

	lda #%00001110
	sta DISP_INST

	lda #%00000110
	sta DISP_INST

hello:
	; Write the characters to the display
	lda #"H"
	sta DISP_CHAR

	lda #"e"
	sta DISP_CHAR

	lda #"l"
	sta DISP_CHAR

	lda #"l"
	sta DISP_CHAR

	lda #"o"
	sta DISP_CHAR

	lda #" "
	sta DISP_CHAR

	lda #"w"
	sta DISP_CHAR

	lda #"o"
	sta DISP_CHAR

	lda #"r"
	sta DISP_CHAR

	lda #"l"
	sta DISP_CHAR

	lda #"d"
	sta DISP_CHAR

	lda #"!"
	sta DISP_CHAR

	jmp disp_config
