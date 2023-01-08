                               org $38                                                                                ;assemble from $38 (where the vblank interrupt will jump to)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; vertical blank interrupt routine
; interrupt generated when screen has finished drawing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
vblank:             
            
        di                                          ;disable any interrupts (so we don't get interrupted)
        push        af                                        ;save accumulator, flags and registers we are going to destroy
        push        ix                                                                         
        push        hl                                                                        
        push        de                                                                        
        push        bc                                                                        
                                
        xor        a                                ;clear accumulator
        ld        (irq_enable),a                   ;disable ints on the board
        ld        (watchdog),a                       ;reset the watchdog
                
        ;increment frame counter                                                
        ld a,(frame_counter)                          ;get current value
        inc a                                          ;increment 
        ld (frame_counter),a                           

        ;sort out frame counter
        ld hl,(frame_number)                             ;get 16 bit frame counter - l holds frame, h holds seconds
        dec l                                                 ;reduce number of frames by 1
        jp p,dont_reset_frame_counter                      ;only reset if it goes negative


        ld l,$3b                                          ;load back up with 59
        inc h                                           ;add one to seconds


dont_reset_frame_counter:
        ld (frame_number),hl                           ;store new counter


chan1:

        ld a, (frame_counter)
        and %00000001
        jp nz, skip

        ld a, (freq1)
        cp 0
        jp z, skip
        dec a
        ld (freq1), a
    
skip:

chan2:
        
        ld a, (frame_counter)
        and %00000001
        jp nz, skip2

        ld a, (freq2)
        cp 16
        jp z, skip2
        inc a
        ld (freq2), a

skip2:

        ld a, 1
        ld (freq3), a

        ld      a, $1           ; a = 1zz1
        ld      (snd_en),a      ; enable audio

        ld      a, (freq1)        ; a = 0x0f
        ld      (v1_volume),a   ; Set the volume to maximum
        ld      a, $03      ; a = 0x02
        ld      (v1_waveform),a ; switch to waveform 3 
        ld      a, (freq1)       ; a = 0x0E
        ld      (v1_freq2),a    ; set one of the frequency registers


        ld      a, (freq2)        ; a = 0x0f
        rrca
        rrca 
        ld      (v2_volume),a   ; Set the volume to maximum
        ld      a, $06     ; a = 0x02
        ld      (v2_waveform),a ; switch to waveform 3 
        ld      a, (freq2)       ; a = 0x0E
        ld      (v2_freq2),a    ; set one of the frequency registers

        ld      a, (x_speed_pixel)        ; a = 0x0f
        add 1
        ld      (v3_volume),a   ; Set the volume to maximum
        ld      a, $01     ; a = 0x02
        ld      (v3_waveform),a ; switch to waveform 3 
        ld      a, (x_speed_frac)        ; a = 0x0f
        add 1
        ld      (v3_freq2),a    ; set one of the frequency registers

        ; main vblank routines
        call set_sprite_data                              ;copy sprite data over to registers
        call input_manager                                  ;update input states
        ;call flip_input                                  ;check for screen flip inputs
vbend:                        
        xor a                                               ;clear a
        ld        (watchdog),a                             ;and reset the watchdog
        inc a                                              ;enable interrupts again
        ld (irq_enable),a                                  ; enable ints on the board
        pop        bc                                      ;restore registers in reverse order of push
        pop        de
        pop        hl
        pop        ix
        pop        af
        ei                                                ;enable interrupts again
        reti                                               ;return from interrupt


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; rest frame number to start second counting from 0 frame
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
reset_framenumber:

        ld a,$39                                                                        ;set up frame number for 0 so seconds are reset
        ld (frame_number),a                                                        ;reset frame number
        ret




