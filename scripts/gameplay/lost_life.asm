
lose_update:
    
     ld a, (temp_byte)
     add 2
     ld (temp_byte), a
     srl a
     srl a
     srl a
     srl a
     add 1
     ld b, a

     ld ix, sprite0
     ld a, (ix+spr_y)
     sub b


     ld (ix+spr_y), a
     cp 10
     jp nc, wait

    jp  lose_reset

                                                             
    
	
	 jp wait


lose_reset:

	  ld a,(player_lives)  
	  dec a
	  ld (player_lives), a
	  cp 0
	  jp nz, NotGameOver

	  jp start_game_over

NotGameOver:
        

    ld ix, sprite0
    res flipy,(ix)                              ;flip x - set to 1

	  ;ld a,palette_cyan_pink_yellow                                                               
    ; call fill_screen_area_colour 

     ;ld de, (droid_screen_location)
    ; ld a, blank_tile
    ; ld (de), a    

     ;ld de, (droid_screen_location + 2)
     ;ld (de), a   

    ; ld de, (droid_screen_location + 4)
    ; ld (de), a  

     ;ld de, (droid_screen_location +6 )
    ; ld (de), a  

    call bee_initialise
            
    ld ix, sprite0
    ld a, (spawn_x)
    ld (ix+spr_x), a

    ld a, (spawn_y)
    ld (ix+spr_y), a


	 ld a, game_mode
	 ld (mode), a



	jp wait


lose_set: 

  call SFX_died

	ld a, life_lost
   	ld (mode),a  

    ld a, 50
    ld (life_lost_counter), a

    ld ix, sprite0
    set flipy,(ix)                              ;flip x - set to 1

    ld a, 0
    ld (temp_byte), a

    ret

	



