

                //    x   y   w

level_data:         defw level_1_data, level_2_data, level_3_data, level_4_data

level_1_data:  
// platforms  
                defm  tile_platform, palette_orange_green_orange, horizontal
                defm  14, 11, 08
                defm  04, 22, 04
                defm  09, 29, 12
                defm  21, 06, 04
                defm  02, 08, 13   
                defm  21, 25, 05  
                defm  11, 19, 07   
                defm  06, 04, 04                  
                defm  -1
              
// spikes_down   
                defm  tile_spikes_down, spikes_colour, horizontal
                defm  14, 12, 08    
                defm  00, 00, 28
                defm  05, 23, 02
                defm  06, 09, 05
                defm  -1             

// spikes_up
                
                defm  tile_spikes_up, spikes_colour, horizontal
                defm 00, 31, 28
                defm 09, 28, 04
                defm 17, 28, 04
                defm -1
               
// spikes_right

                defm  tile_spikes_right, spikes_colour, vertical
                defm 00, 07, 09
                defm 00, 19, 04
                defm -1
            
// spikes_left          
                defm tile_spikes_left, spikes_colour, vertical
                defm 27, 07, 09
                defm 27, 19, 04
                defm -1  
                defm -2 
  
// wasps
                 //  x, y, target, speed
                defm 040, 185, 120, 150        // horiz yellow
               
                defm 000, 50, 220, 050    // vert yellow
                defm 200, 180, 100, 250    // horiz orange
                defm 125, 95, 045, 75      // vert orange



level_2_data:  
// platforms  
                defm  tile_platform, palette_orange_green_orange, horizontal
                
                defm 2, 25, 15
                defm 14, 30, 3
                defm 12, 19, 12
                defm 09, 14, 3
                defm 24, 14, 4
                defm 05, 08, 20
                defm 09, 02, 13
                          
                defm  -1
              
// spikes_down   
                defm  tile_spikes_down, spikes_colour, horizontal
                defm  00, 00, 28
                 defm 2, 26, 15
                  defm 12, 20, 12
                  defm 24, 15, 4
                  defm 05, 09, 20
                  defm 11, 03, 9
          
                defm  -1             

// spikes_up
                
                defm  tile_spikes_up, spikes_colour, horizontal
                defm 00, 31, 28
                defm 14, 18, 5
                defm 05, 07, 6
                defm 13, 07, 4
                defm 8, 24, 2
                defm 09, 01, 13
                
                defm -1
               
// spikes_right

                defm  tile_spikes_right, spikes_colour, vertical
                defm 0, 12, 16
                defm 0, 2, 5
                defm -1
            
// spikes_left          
                defm tile_spikes_left, spikes_colour, vertical
                defm 27, 12, 19
                defm -1  
                defm -2 
  
// wasps
                 //  x, y, target, speed
                defm 100, 080, 200, 160        // horiz yellow
               
                defm 220, 170, 100, 120    // vert yellow
                defm 210, 180, 060, 240    // horiz orange
                defm 100, 050, 025, 75      // vert orange






level_3_data:  
// platforms  13321
                defm  tile_platform, palette_orange_green_orange, horizontal
                
                defm  5, 24, 3
                defm  11, 24, 3
                defm  17, 24, 2


                defm  3, 19, 16 
                

                defm  06,04 ,5
                defm  09,08 ,5
                defm  12,12 ,5
                defm  15,16 ,5
                defm  20,09 ,7
                defm  20,04 ,7
                         
                defm  -1
              
// spikes_down   
                defm  tile_spikes_down, spikes_colour, horizontal
                 defm  00, 00, 28
                defm  3, 20, 16
                  defm  20,10 ,7
                    defm  20,05 ,7
                defm  -1             

// spikes_up
                
                defm  tile_spikes_up, spikes_colour, horizontal
                defm 00, 31, 28
                defm  06,03 ,1
                defm  09,07 ,1
                defm  12,11 ,1
                defm  15,15 ,1

                defm  10,03 ,1
                defm  13,07 ,1
                defm  16,11 ,1
                defm  19,15 ,1

                defm  5, 18, 5 

                defm -1
               
// spikes_right

                defm  tile_spikes_right, spikes_colour, vertical
                defm  0,23,6
                defm  8, 24, 1
                defm  14, 24, 1
                defm  19, 24, 1
                defm -1
            
// spikes_left          
                defm tile_spikes_left, spikes_colour, vertical
                
                defm 27, 0, 31
                defm  4, 24, 1
                defm  10, 24, 1
                defm  16, 24, 1
                defm -1  
                defm -2 
  
// waspsz
                 //  x, y, target, speed
                defm 093, 125, 210, 250        // horiz yellow
               
                defm 200, 250, 070, 170    // vert yellow
                defm 80,  60, 120, 250    // horiz orange
                defm 50, 160, 100, 190      // vert orange

            
   
level_4_data:  
// platforms  
                defm  tile_platform, palette_orange_green_orange, horizontal
                defm  6, 19, 12
                defm  24, 16, 3
                defm  24, 11, 3
                defm  24, 6, 3
                defm  2, 24, 6
                defm  8, 29, 14
                            
                defm  -1
              
// spikes_down   
                defm  tile_spikes_down, spikes_colour, horizontal
                
                defm  00, 00, 28
                defm  6, 20, 12
                defm  24, 15, 3
             
                defm  -1             

// spikes_up
                
                defm  tile_spikes_up, spikes_colour, horizontal
                defm 00, 31, 28
                 defm  9, 18, 4
                  defm  24, 15, 1
                   defm  24, 10, 1
                    defm  24, 5, 1
                   defm  8, 28, 14
             
              
                defm -1
               
// spikes_right

                defm  tile_spikes_right, spikes_colour, vertical
                defm 00, 07, 22
               
                defm -1
            
// spikes_left          
                defm tile_spikes_left, spikes_colour, vertical
                defm 27, 04, 24
               
                defm -1  
                defm -2 
  
// wasps
                 //  x, y, target, speed
                defm 070, 140, 170, 230       // horiz yellow
               
                defm 200, 155, 100, 190    // vert yellowz
                defm 220, 150, 85, 250    // horiz orange
                defm 140, 90, 050, 230      // vert orange      

                




spr_initial_game_data:
        ;sprite number * 4 to but into top 6 bits (0-63) flips then in bit 0 and 1, and pallete byte
        defm $00*4, palette_yellow_blue_white ; sprite 0, flipped in x, palette 1
        defm 16*4, palette_yellow_blue_white ; sprite 1
        defm 24*4, palette_red_orange_white ; sprite 2 
        defm 20*4, palette_yellow_blue_white  
        defm 28*4, palette_red_orange_white ; sprite 4
       
        defm $3f*4, 0 ; sprite 5                ;bullet sprite invisible
        ;starting positions x,y
        defm 220, 040        ;sprite 0
        defm 0, 200        ;sprite 1
        defm 0, 150        ;sprite 2
        defm 0, 100        ;sprite 3
        defm 0, 50        ;sprite 4
        defm 0, 0        ;sprite 5
       

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; some messages to display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

txt_game_title:         defm  "POLLEN ANGEL",0
txt_game_author:        defm "WRITTEN IN 48 HOURS FOR",0
txt_copyright:          defm "LUDUM DARE 52",0

txt_game_title1:         defm  "Z80 ASSEMBLY RUNNING",0
txt_game_author1:        defm "ON PACMAN ARCADE",0
txt_copyright1:          defm "HARDWARE FROM 1980.",0

txt_instruct_1:         defm "COLLECT POLLEN FROM THE",0  
txt_instruct_2:         defm "FLOWERS AS FAST AS YOU CAN",0  
txt_instruct_3:         defm "WHILST AVOIDING WASPS AND",0  
txt_instruct_4:         defm "DEADLY SPIKES. ",0  
txt_instruct_5:         defm "FLOWERS WILL WILT IF LEFT",0  
txt_instruct_6:         defm "FOR TOO LONG. HARVEST SIX",0   
txt_instruct_7:         defm "TO COMPLETE EACH LEVEL.",0


                                           ;0123456789012345678901234567 - for alignment purposes
;msg_instruction:        defm        "WELCOME TO  THIS LITTLE GAME",0
;msg_quit_game:                defm    " 2P START  TO QUIT TO TITLE ",0
msg_debug:                        defm        "DEBUG                       ",0
msg_scoring:                defm        "SCORE      FLOWERS      BEST",0
msg_progress:               defm        "LEVEL       LIVES       TIME",0
msg_game_over:                defm        "  GAME    OVER  ",0
msg_gameover_blank:        defm        "                ",0
msg_blank:                        defm        "                            ",0 ;use this label to also refer to a blank message
msg_level_complete:              defm      " LEVEL COMPLETE ", 0
msg_bonus:                           defm   " BONUS    0000  ",0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; a list of message width of the screen (28 columns)
; to display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bot_mess_seconds:        defm 0        ; change every second
bot_mess_1:                        defm        "      PRESS 1 TO START       ",0
bot_mess_2:                        defm        "      BY ARLASOFT 2023      ",0
                                        ;                 0123456789012345678901234567 - for alignment purposes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; this is the addressess of the messages to display (above), 
; the code looks for an address of zero to restart the list
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
bottom_list:                defw        bot_mess_1,msg_blank,bot_mess_2,msg_blank,0

wing_speeds:    .defm start_wing_speed + 1, 3, 2, 1, 1, 0



row_starts:     defw row_0, row_1, row_2



tile_column_to_sprite_x:        
                
               defm 237,229,221,213,205,197,189,181,173,165,157,149,141,133,125,117,109,101,93,85,77,69,61,53,45,37,29,21


tile_row_to_sprite_y:
                
                defm 255,248,240,232,224,216,208,200,192,184,176,168,160,152,144,136,128,120,112,104,96,88,80,72,64,56,48,40,32,24,16,8


EffectTable1:

    defm $73, $20, $00, $0c, $00, $0A, $1F, $00
    defm $72, $20, $fb, $87, $00, $02, $0F, $00



EffectTable2:

    defm $59, $01, $06, $08, $00, $00, $02, $00
    defm $59, $01, $06, $09, $00, $00, $02, $00
    defm $59, $02, $06, $0a, $00, $00, $02, $00
    defm $59, $03, $06, $0b, $00, $00, $02, $00
    defm $59, $04, $06, $0c, $00, $06, $02, $00
    defm $24, $00, $06, $08, $02, $00, $0A, $00
    defm $36, $07, $87, $6F, $00, $00, $04, $00
    defm $70, $04, $00, $00, $00, $00, $08, $00

EffectTable3:

    defm $1C, $70, $8B, $08, $08, $01, $06, $00
    defm $1C, $70, $8B, $08, $08, $01, $06, $00
    defm $56, $0C, $FF, $8C, $00, $02, $08, $00
    defm $56, $00, $02, $0A, $07, $03, $0C, $00
    defm $36, $38, $FE, $12, $F8, $04, $0F, $FC
    defm $22, $01, $01, $06, $00, $01, $07, $00


tile_column_lookup:    defw column_0, column_1, column_2, column_3, column_4, column_5, column_6, column_7
                       defw column_8, column_9, column_10, column_11, column_12, column_13, column_14, column_15
                       defw column_16, column_17, column_18, column_19, column_20, column_21, column_22, column_23
                       defw column_24, column_25, column_26, column_27


sprite_column_lookup:   

        defm 30,30,30,30,30,30,29,29,29,29,29,29,29,29,28,28,28,28,28,28,28,28,27,27,27,27,27,27,27,27,26,26,26,26,26,26,26,26,25,25,25,25,25,25,25,25,24,24,24,24,24,24,24,24,23,23,23,23,23,23,23,23,22,22,22,22,22,22,22,22,21,21,21,21,21,21,21,21,20,20,20,20,20,20,20,20,19,19,19,19,19,19,19,19,18,18,18,18,18,18,18,18,17,17,17,17,17,17,17,17,16,16,16,16,16,16,16,16,15,15,15,15,15,15,15,15,14,14
        defm 14,14,14,14,14,14,13,13,13,13,13,13,13,13,12,12,12,12,12,12,12,12,11,11,11,11,11,11,11,11,10,10,10,10,10,10,10,10,9,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,7,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,-1,-1,-1,-1,-1,-1,-1,-1,-2,-2

sprite_row_lookup:

    defm 0,0,0,0,0,0,0,0,0,0,0,0,0,0,31,31,31,31,31,31,31,31,30,30,30,30,30,30,30,30,29,29,29,29,29,29,29,29,28,28,28,28,28,28,28,28,27,27,27,27,27,27,27,27,26,26,26,26,26,26,26,26,25,25,25,25,25,25,25,25,24,24,24,24,24,24,24,24,23,23,23,23,23,23,23,23,22,22,22,22,22,22,22,22,21,21,21,21,21,21,21,21,20,20,20,20,20,20,20,20,19,19,19,19,19,19,19,19,18,18,18,18,18,18,18,18,17,17
        defm 17,17,17,17,17,17,16,16,16,16,16,16,16,16,15,15,15,15,15,15,15,15,14,14,14,14,14,14,14,14,13,13,13,13,13,13,13,13,12,12,12,12,12,12,12,12,11,11,11,11,11,11,11,11,10,10,10,10,10,10,10,10,9,9,9,9,9,9,9,9,8,8,8,8,8,8,8,8,7,7,7,7,7,7,7,7,6,6,6,6,6,6,6,6,5,5,5,5,5,5,5,5,4,4,4,4,4,4,4,4,3,3,3,3,3,3,3,3,2,2,2,2,2,2,2,2,1,1


valid_colours:
        
        defm 1, 3, 5, 7, 9, 14, 15, 16, 17, 18, 20, 21, 22, 23, 24, 25

