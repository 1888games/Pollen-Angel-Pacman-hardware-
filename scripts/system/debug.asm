       


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; HELPER FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; takes a byte and outputs the hex value to top or bottom rows only
; hl holds address of vram to place data
; c holds value to output
; a little tricky as tiles stored in ascii, so need to do adjustments to move between
; the stock digits and the 6 hex additional digits
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show_hex:
        ld b,2   
                                                                                                     ;do this twice
.nibbleout:

        xor a                                                                                                ;clear carry
        ld a,c                                                                                                ;get byte to output
        rlca
        rlca
        rlca
        rlca                                                                                                ;rotate 4 times to swap nibbles
        ld c,a                                                                                                ;store temp for next time
        and $f                                                                                                ;mask 
        cp $a                                                                                                ;are we bigger than 9
        jp p,.alphahex                                                                                ;adjust for a to f
        add 48                                                                                                ;it's 0-9 so add 48 for tile number
        jp .output                                                                                        ;now render to screen
.alphahex:
        add 55                                                                                                ;add 55 (so a becomes 65 - ASCII A)
.output:
        ld (hl),a                                                                                        ;write tile value to vram
        dec hl                                                                                                ;move to next column on the right for lower nibble
        djnz .nibbleout
        ret


show_hex_game:
        ld b,2   
                                                                                                     ;do this twice
.nibbleout2:

        xor a                                                                                                ;clear carry
        ld a,c                                                                                                ;get byte to output
        rlca
        rlca
        rlca
        rlca                                                                                                ;rotate 4 times to swap nibbles
        ld c,a                                                                                                ;store temp for next time
        and $f                                                                                                ;mask 
        cp $a                                                                                                ;are we bigger than 9
        jp p,.alphahex2                                                                                ;adjust for a to f
        add 48                                                                                                ;it's 0-9 so add 48 for tile number
        jp .output2                                                                                        ;now render to screen
.alphahex2:
        add 55                                                                                                ;add 55 (so a becomes 65 - ASCII A)
.output2:

        ld (hl),a
        
        ld a, l
        sub 32
       ld l, a

        ld a, h
       sbc 0
        ld h, a

                                                                                                 ;move to next column on the right for lower nibble
        djnz .nibbleout2
        ret