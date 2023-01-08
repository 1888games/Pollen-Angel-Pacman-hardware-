
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; sets up game screen
; clears screen 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
start_game:
        
        
        ld a, 0
        ld (level_complete), a

        ld a, start_lives
        ld (player_lives), a

        ld a, 255
        ld (current_level), a

        ld hl,0                                                                                ;clear
        ld (current_score),hl                                                ;reset player score
        ld (current_score + 2),hl                                        ;reset player score

       
        ld hl,spr_initial_game_data                                        ;addr of game sprite data
        call set_sprites  

        ld ix, sprite0
        ld a, (ix + spr_x)
        ld (spawn_x), a

        ld a, (ix + spr_y)
        ld (spawn_y), a

        ld a, 16 * 4
        ld (wasp1 + wasp_base_frame),a

     
        ld a, 24 * 4
        ld (wasp2+ wasp_base_frame),a

        ld a, 20 * 4
        ld (wasp3+ wasp_base_frame),a
 
        ld a, 30 * 4
        ld (wasp4+ wasp_base_frame),a

        ld a, start_flowers
        ld (flowers_to_collect), a



        jp finishedWaiting

next_level:
        
        ld b, 100

wait_a_bit
        ld        (watchdog),a                       ;reset the watchdog
        halt

        djnz wait_a_bit

finishedWaiting:

                        
        
         ld hl,spr_initial_game_data                                        ;addr of game sprite data
        call set_sprites  


        ld a, 0
        ld (flowers_grown), a
        ld (level_complete), a                                                  ;and store

        ld a,palette_cyan_pink_yellow                                                               
        call fill_screen_area_colour                               

        call clear_tile_ram


        ld ix, sprite0
        ld a, (spawn_x)
        ld (ix+spr_x), a

        ld a, (spawn_y)
        ld (ix+spr_y), a

        call bee_initialise
       

        ld a, 0
        ld  hl,flower_positions                                        ;set all colour ram to palette 1
        ld  de,flower_positions + 1
        ld  bc,MAX_FLOWERS * 2                                                                       ;1k of palette ram
        ld  (hl),a                                                                        ;clear (hl), which then gets copied through to de
        ldir           


        ld a, (current_level)
        inc a 
        ;;ld a, 0 
        ld (current_level), a

        and %00000011
        call draw_map

      


        ;clear old messages
        ld de,msg_blank                                                                ;store text addr for instruction message
        ld hl,tile_ram_top_vis_line2                                ;vram address for 2nd line of tiles
        call borders_blit_text_only                                        ;write text to border
        ld de,msg_blank                                                                ;store text addr for instruction message
        ld hl,tile_ram_bot_vis_line1                                ;vram address for first of bottom line of tiles
        call borders_blit_text_only                                        ;write text to border


        ld de,msg_scoring                                                        ;store text addr for scoring message
        ld hl,tile_ram_top_vis_line1                                ;vram address for first of bottom line of tiles
        ld c,yellow                                                                  ;colour (yellow)
        call borders_blit_text                                                ;write text to border

        ld de,msg_blank                                                        ;store text addr for scoring message
        ld hl,tile_ram_top_vis_line2                              ;vram address for first of bottom line of tiles
        ld c,pink                                                                       ;colour (yellow)
        call borders_blit_text                                                ;write text to border

            ;set static instruction message on bottom line
        ld de,msg_progress                        ;store text addr for instruction message
        ld hl,tile_ram_bot_vis_line1              ;vram address for first of bottom line of tiles
        ld c,pink                          ;colour (yellow)
        call borders_blit_text                      ;write text to border

        ld de,msg_blank                                                        ;store text addr for scoring message
        ld hl,tile_ram_bot_vis_line2                              ;vram address for first of bottom line of tiles
        ld c,yellow                                                                ;colour (yellow)
        call borders_blit_text                                                ;write text to border

        ld a, (flowers_to_collect)
        ld (flowers_to_go), a                                                  ;do initial transfer of sprite data from rom to ram

        ld a,TIME_LIMIT                                                                     ;set game counter to 60 (in bcd)
        ld (game_time),a                                                        ;and store

        call reset_framenumber                                                ;set frame number to 0 so we start at a whole second



waitEnough:

        call get_new_flower
        call get_new_flower
        call get_new_flower

       
        call grow_flowers
        call grow_flowers
        call grow_flowers

        ld a, start_flower_time
        ld (new_flower_time), a
        ld (new_flower_timer), a


        ;and %00000111
        ;c;all draw_level


setRandom:
        ld a, (frame_counter)
        ld (rand_data), a

        neg
        ld (rand_data + 1), a

         ld a,game_mode                                                                ;pick game mode
        ld (mode),a        

        jp wait                                                                                ;finished setup goto wait section

