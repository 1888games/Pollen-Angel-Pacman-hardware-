
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; data to be held in ram defined here                                 ;
; allocation of bytes for ram area assembler calculates                              ;
; addresses based on org statement and user_ram_start ($4c00)                  ;
; these are in affect our variables                                                                          ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; db define byte (8 bit value) creates space and sets value
; dw define word (16 bit value) creates space and sets value
; ds declares space for a number of bytes (often specified using a calculation for the assembler)
; defm defines a byte
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


        org user_ram_start                             ;allocate this data at user_ram_start $4c00


WASP_DATA_LENGTH:				equ 8

flower_positions:                ds MAX_FLOWERS * 2
flowers_grown:                    ds 1

wasp_frame:						ds 1

wasp1:
wasp1_x:						ds 1
wasp1_y:						ds 1
wasp1_target_1:					ds 1
wasp1_target_2:					ds 1
wasp1_speed:					ds 1
wasp1_direction:				ds 1
wasp1_frac:					    ds 1
wasp1_start_frame:				ds 1


wasp2:							ds WASP_DATA_LENGTH
wasp3:							ds WASP_DATA_LENGTH
wasp4:							ds WASP_DATA_LENGTH


freq1:                          ds 1
freq2:                          ds 1
freq3:                          ds 1

waitvsync:                      db 0                   ;if 1 then interrupt is finished and main loop can continue 
frame_counter:                  db 255                  ;value that increments every frame for stable animation and frame counts - doesn't reset just wraps so mods work consistently
frame_number:                   db 0                      ;holds a frame number in lsB and second counter in msB 60 to 0 resets to 60 when gets to zero 
seconds_counter:                db 0                      ;quick ref to seconds part


full_tile:                      db 0                    ;tile to use by bitmap renderer
save_reg:                       db 0                   ;temp storage for an 8 bit register
save_sp:                        dw 0                    ;storage area for stack when messing about with it
joystick_state:                 db 0                     ;holds previous state in upper nibble and current state in lower nibble  IN1 $5000
start_state:                    db 0                         ;holds current state of input byte IN1 - player 2 joystick and start buttons $5040
flip_screen:                    db 0                       ;holds status of flip screen (as i think the location $5003 is write only - it always reads back as ff)
sprite_data:                    ds 4*6 + 2*6 + 2*6 + 2*6                        ;space for the 6 sprites to store their sprite data 
                                                            ;4 bytes for sprite, pallete, x and y


flowers_to_go:                  db 1                                                           ;2 bytes for x and y velocity
                                                            ;2 bytes for tile addr (not used)
                                                            ;2 bytes for tilex and tiley
                                                            ;60 bytes in total for this data
temp_address:                   dw 0

msg_top_addr                    dw 0                    ;holds address of top changing display text 
msg_one_pos:                    dw 0                     ;start addr of top text
msg_bot_addr:                   dw 0                     ;holds index of in bottom_list text to display at bottom of screen
bot_counter:                    db 0                     ;counter for bottom scrolling message display


mode:                           db 0                      ;what mode is the system in 1 - title screen, 2 is game, 4 is end of game
high_score:                     ds 4                      ;current high score (again 4 bcd bytes)
current_score:                  ds 4                       ;space for current players score 4 bytes in bcd format (8 digits)
game_time:                      db 0                       ;holds the game time

level_complete:                 ds 1


flowers_to_collect              ds 1
player_lives:					db 0 

life_lost_counter:				ds 1
current_level:					ds 1

rand_data:						ds 2

temp_byte:                     db 0

bee_direction:					db 0

x_speed_pixel:					ds 1
x_speed_frac:					ds 1

y_speed_pixel:					ds 1
y_speed_frac:					ds 1

y_pos_frac:						ds 1
x_pos_frac:						ds 1

wing_timer:						ds 1
wing_time:						ds 1
wing_frame:						ds 1

bee_falling:					ds 1
bee_going_right:				ds 1

spawn_x:						ds 1
spawn_y:						ds 1





tile_direction:                                 ds 1

blocked_above:                                  ds 1
blocked_below:                                  ds 1
blocked_left:                                   ds 1
blocked_right:                                  ds 1
pollen_collected:								ds 1

pollen_frame:									ds 1

new_flower_timer:                               ds 1
new_flower_time:                                ds 1


                                                            ;y flip bit for sprites
sprite0:                                equ sprite_data                                                ;quick reference constants to load index registers with for sprite access
sprite1:                                equ sprite_data + 2
sprite2:                                equ sprite_data + 4
sprite3:                                equ sprite_data + 6
sprite4:                                equ sprite_data + 8
sprite5:                                equ sprite_data + $a
sprite_pos:                             equ sprite_data + spr_x
sprite_vels:                            equ sprite_data + spr_vel_x

        
        org $4e9c

CH1_E_NUM       ds 1    ; effects to play sequentially (bitmask)
CH1_E_1         ds 1    ; unused
CH1_E_CUR_BIT   ds 1   ; current effect
CH1_E_TABLE0   ds 1    ; table of parameters, initially copied from ROM
CH1_E_TABLE1    ds 1
CH1_E_TABLE2    ds 1
CH1_E_TABLE3    ds 1
CH1_E_TABLE4    ds 1
CH1_E_TABLE5    ds 1
CH1_E_TABLE6    ds 1
CH1_E_TABLE7    ds 1
CH1_E_TYPE      ds 1
CH1_E_DURATION  ds 1
CH1_E_DIR       ds 1
CH1_E_BASE_FREQ ds 1
CH1_E_VOL       ds 1

CH2_E_NUM       ds 16
CH3_E_NUM       ds 16


CH1_FREQ0       ds 1   ; 20 bits
CH1_FREQ1      ds 1
CH1_FREQ2       ds 1
CH1_FREQ3       ds 1
CH1_FREQ4      ds 1
CH1_VOL         ds 1
CH2_FREQ1       ds 1    ; 16 bits
CH2_FREQ2       ds 1
CH2_FREQ3       ds 1
CH2_FREQ4      ds 1
CH2_VOL        ds 1
CH3_FREQ1       ds 1    ; 16 bits
CH3_FREQ2      ds 1
CH3_FREQ3       ds 1
CH3_FREQ4       ds 1
CH3_VOL         ds 1

SOUND_COUNTER   ds 1    ; counter, incremented each VBLANK
                                ; (used to adjust sound volume)

SONG_TABLE_1    EQU     $3bc8
SONG_TABLE_2    EQU     $3bcc
SONG_TABLE_3    EQU     $3bd0
