bee_initialise:

	ld a, 0
	ld (wing_frame), a
	ld (bee_direction), a
	ld (x_speed_pixel), a
	ld (x_speed_frac), a
	ld (y_speed_pixel), a
	ld (y_speed_frac), a
	ld (bee_falling), a
	ld (bee_going_right), a


    ld a, start_wing_speed
    ld (wing_time), a
    ld (wing_timer), a





    ret




checkFlower:
	
	ld ix, sprite0
	call convert_sprite_to_tile

	dec hl

	ld a, l
	add 32
	ld l, a

	ld a, h
	adc 0
	ld h, a

	ld a, (hl)
	cp tile_flower
	jp z, collectingPollen

	ld a, l
	sub 32
	ld l, a

	ld a, h
	sbc 0
	ld h, a

	ld a, (hl)
	cp tile_flower
	jp z, collectingPollen

	ld a, l
	sub 32
	ld l, a

	ld a, h
	sbc 0
	ld h, a

	ld a, (hl)
	cp tile_flower
	jp z, collectingPollen

	ld ix, sprite0
	call convert_sprite_to_tile

	ld a, l
	add 32
	ld l, a

	ld a, h
	adc 0
	ld h, a

	ld a, (hl)
	cp tile_flower
	jp z, collectingPollen

	ld a, l
	sub 32
	ld l, a

	ld a, h
	sbc 0
	ld h, a

	ld a, (hl)
	cp tile_flower
	jp z, collectingPollen

	ld a, l
	sub 32
	ld l, a

	ld a, h
	sbc 0
	ld h, a

	ld a, (hl)
	cp tile_flower
	jp z, collectingPollen


	
	xor a
	ld (pollen_collected), a
	ld (pollen_frame), a
	ret

collectingPollen:

	push hl

	ld a, 1
	call score_points

	pop hl
		
	ld a, 32
	ld (pollen_frame), a
	

	call SFX_suck
	ld a, (pollen_collected)
	inc a
	ld (pollen_collected), a
	cp 90
	ret nz

	ld iyl, (tile_flower_eaten)
	ld iyh, (palette_orange_green_orange)
	call draw_map_tile

	ld a, 100
	call score_points

	ld a, (flowers_to_go)
	dec a
	ld (flowers_to_go), a
	cp 0
	ret nz 	

	call show_lives

	ld a, 1
	ld (level_complete), a



	ret




bee_update:
	
	
	call checkFlower
	call checkCollisionUp	
	call checkCollisionDown

	ld a, (blocked_above)
	cp 0
	jp nz, noSide

	ld a, (blocked_below)
	cp 0
	jp nz, noSide



	call checkCollisionLeft
	call checkCollisionRight
	

noSide:	

	call checkJoystick
	call check_wings
	call drag
	call applyForcesY
	call applyForcesX

	

	
	ret



checkCollisionRight:

	ld a, 0
	ld (blocked_right), a


	ld a, l
	sub 64
	ld l, a

	ld a, h
	sbc 0
	ld h, a

	;ld a, 4
	;ld (hl), a

	ld a, (hl)
	cp tile_platform
	jp nz, notHitPlatformRight

	ld a, 1
	ld (blocked_right), a

notHitPlatformRight:

	cp tile_spikes_left
	jp nz, notHitSpikeRight

	call lose_set

	pop hl
	
	ret

notHitSpikeRight:

	ret




checkCollisionLeft:

	ld a, 0
	ld (blocked_left), a

	ld ix, sprite0
	call convert_sprite_to_tile

	ld a, l
	add 32
	ld l, a

	ld a, h
	adc 0
	ld h, a

	;ld a, 4
	;ld (hl), a

	ld a, (hl)
	cp tile_platform
	jp nz, notHitPlatformLeft

	ld a, 1
	ld (blocked_left), a

notHitPlatformLeft:

	cp tile_spikes_right
	jp nz, notHitSpikeLeft

	call lose_set

	pop hl
	
	ret

notHitSpikeLeft:

	;ld a, l
	;sub 32
	;ld l, a

	;ld a, h
	;sbc 0
	;ld h, a

	;ld a, (hl)
	;cp tile_platform
	;jp nz, notHitPlatformRightUp

	;ld a, 1
	;ld (blocked_above), a


	;cp tile_spikes_down
	;jp nz, notHitSpikeRightUp

	;call lose_set

	;pop hl
	
	;ret

	ret



checkCollisionUp:

	
	ld a, 0
	ld (blocked_above), a

	ld ix, sprite0
	call convert_sprite_to_tile


	dec hl
	ld a, (hl)
	cp tile_platform
	jp nz, notHitPlatformLeftUp

	ld a, 1
	ld (blocked_above), a

notHitPlatformLeftUp:

	cp tile_spikes_down
	jp nz, notHitSpikeLeftUp

	call lose_set

	pop hl
	
	ret

notHitSpikeLeftUp:

	ld a, l
	sub 32
	ld l, a

	ld a, h
	sbc 0
	ld h, a

	ld a, (hl)
	cp tile_platform
	jp nz, notHitPlatformRightUp

	ld a, 1
	ld (blocked_above), a

	
notHitPlatformRightUp:

	cp tile_spikes_down
	jp nz, notHitSpikeRightUp

	call lose_set

	pop hl
	
	ret

notHitSpikeRightUp:

	ret



checkCollisionDown:
	
	ld a, 0
	ld (blocked_below), a

	inc hl
	

	ld a, (hl)
	cp tile_platform
	jp nz, notHitPlatformRightDown

	ld a, 1
	ld (blocked_below), a

notHitPlatformRightDown:

	cp tile_spikes_up
	jp nz, notHitSpikeRightDown

	call lose_set

	pop hl
	
	ret

notHitSpikeRightDown:

	ld a, l
	add 32
	ld l, a

	ld a, h
	adc 0
	ld h, a

	ld a, (hl)
	cp tile_platform
	jp nz, notHitPlatformLeftDown

	ld a, 1
	ld (blocked_below), a

	
notHitPlatformLeftDown:

	cp tile_spikes_up
	jp nz, notHitSpikeLeftDown

	call lose_set

	pop hl
	
	ret

notHitSpikeLeftDown:

	ret



MAX_Y_SPEED	 equ 3
MAX_X_SPEED  equ 3


drag:	
		
	

		ld a, (x_speed_frac)
		sub 2
		ld (x_speed_frac), a

		ld a, (x_speed_pixel)
		sbc 0
		ld (x_speed_pixel), a
		jp p, .StillGoingY

		ld a, 0
		ld (x_speed_frac), a

		xor a
		ld (x_speed_pixel), a

.StillGoingY:

		ld a, (y_speed_frac)
		sub 2
		ld (y_speed_frac), a

		ld a, (y_speed_pixel)
		sbc 0
		ld (y_speed_pixel), a
		jp p, .StillGoingX

		ld a, 0
		ld (y_speed_frac), a

		xor a
		ld (y_speed_pixel), a

.StillGoingX

	ret



gravity:


		ld a, gravity_force
		ld b, a

		ld a, (y_speed_frac)
		add a, b
		ld (y_speed_frac), a

		ld a, (y_speed_pixel)
		adc a, 0
		ld (y_speed_pixel), a

		ld hl, (tile_ram_play_area  + row_4 +column_4)
		ld (hl), a
	    ret    
	                                                                 ;save new x position

applyForcesY:
		
		ld a, (y_speed_pixel)	
		cp MAX_Y_SPEED
		jp c, notMax

		ld a, 0
		ld (y_speed_frac), a

		ld a, MAX_Y_SPEED
		ld (y_speed_pixel), a

notMax:
		
		ld c, a

		ld a, (bee_falling)
		cp 1
		jp z, fallingDown


flyingUp:
		
	ld a, (blocked_above)
	cp 1
	jp nz, notBlockedAbove


	ld a, 1
	ld (bee_falling), a

	call bounceBeeY

	ret

notBlockedAbove:


        ld a, (y_speed_frac)
        ld b, a
        ld a, (y_pos_frac)
        add a, b
        ld (y_pos_frac), a

        ld a, (sprite0+spr_y)
        adc a, c
        ld (sprite0+spr_y), a

        ret

fallingDown:
	

	ld a, (blocked_below)
	cp 1
	jp nz, notBlockedBelow


	ld a, 0
	ld (bee_falling), a

	call bounceBeeY
	
	ret

notBlockedBelow:

        ld a, (y_speed_frac)
        ld b, a
        ld a, (y_pos_frac)
        sub b
        ld (y_pos_frac), a

        ld a, (sprite0+spr_y)
        sbc a, c
        ld (sprite0+spr_y), a

 

        ret


bounceBeeY:

	ld a, (y_speed_pixel)
	srl a
	ld (y_speed_pixel), a

	ld a, (y_speed_frac)
	srl a

	ld (y_speed_frac), a

	ret


bounceBeeX:

	ld a, (x_speed_pixel)
	srl a
	ld (x_speed_pixel), a

	ld a, (x_speed_frac)
	srl a
	ld (x_speed_frac), a

	ret


applyForcesX:
		
		ld a, (x_speed_pixel)	
		cp MAX_X_SPEED
		jp c, notMaxX

		ld a, 0
		ld (x_speed_frac), a

		ld a, MAX_X_SPEED
		ld (x_speed_pixel), a

notMaxX:
		
		ld c, a

		ld a, (bee_going_right)
		cp 1
		jp z, goingRight

going_left:
	
	ld a, (blocked_left)
	cp 1
	jp nz, notBlockedLeft


	ld a, 1
	ld (bee_going_right), a

	call bounceBeeX

	ret

notBlockedLeft:

        ld a, (x_speed_frac)
        ld b, a
        ld a, (x_pos_frac)
        add a, b
        ld (x_pos_frac), a

        ld a, (sprite0+spr_x)
        adc a, c
        ld (sprite0+spr_x), a

       


        ret

goingRight:
	
	ld a, (blocked_right)
	cp 1
	jp nz, notBlockedRight


	ld a, 0
	ld (bee_going_right), a

	call bounceBeeX

	ret

notBlockedRight:

        ld a, (x_speed_frac)
        ld b, a
        ld a, (x_pos_frac)
        sub b
        ld (x_pos_frac), a

        ld a, (sprite0+spr_x)
        sbc a, c
        ld (sprite0+spr_x), a

 

        ret


check_wings:

	ld a, (wing_timer)
	cp 0
	jp z, flapWing

	dec a
	ld (wing_timer), a

	ret
	
flapWing:
	
	ld hl, wing_speeds
	ld a, (x_speed_pixel)
	ld b, a
	ld a, (y_speed_pixel)
	add b, a
	cp 0
	jp nz, notZero

	ld c, a

	ld a, (x_speed_frac)
	add a, b
	ld b, a
	ld a, (y_speed_frac)
	add a, b
	cp 0
	jp nz, notZero

	ld a, 8
	jp setWingTime

notZero:	
		
	ld a, c
	ld e, a
	ld a, 0
	ld d, a
	add hl, de
	ld a, (hl)
	;ld (wing)

;	ld a, (wing_time)
setWingTime:

	ld (wing_timer), a

	ld ix, sprite0
	ld a, (wing_frame)
	cp 0
	jp z, makeFour

	ld a, 0
	jp storeFrame

makeFour:

	ld a, 4

storeFrame:

	ld (wing_frame), a
	ld b, a

	ld a, (bee_direction)
	add a, b
	ld b, a

	call random
	cp 24
	jp nc, noBlink

	ld a, 16
	add a, b
	ld b, a

noBlink:
	

	
	ld a, (pollen_frame)
	add a, b
	

	ld (ix+spr_num), a
	
	ret



checkJoystick:

        ld a,(joystick_state)                                                ;get joystick state
        ld b,a                                                                                ;and save in b
        and inp_chk_left                                                        ;examine left
        and a                                                                                ;check for pressed 
        jp nz,.right                                                                ;not held held 0 means pressed

       
.doLeft:
        ld a, 8
        ld (bee_direction), a


      
        ld a, (bee_going_right)
		cp 1
		jp nz, .IncreaseLeftSpeed


.DecreaseRightSpeed:

		ld a, CONTROL_BRAKE
		ld b, a
		ld a, (x_speed_frac)
		sub b
		ld (x_speed_frac), a

		ld a, (x_speed_pixel)
		sbc 0
		ld (x_speed_pixel), a
		jp p, .StillGoingRight

		ld a, 0
		ld (bee_going_right), a

		ld a, 1
		ld (x_speed_frac), a

		xor a
		ld (x_speed_pixel), a

.StillGoingRight:

		ret

.IncreaseLeftSpeed:

		ld a, CONTROL_EFFECT
		ld b, a
		ld a, (x_speed_frac)
		add b
		ld (x_speed_frac), a

		ld a, (x_speed_pixel)
		adc 0
		ld (x_speed_pixel), a

	                             ;no flip y - set to 0 - clear
        ret                                                                                        ;don't bother checker down



.right:                       	
		ld a,b                                                                                ;get state again
        and inp_chk_right                                                        ;examine right
        and a                                                                                ;check if pressed
        jp nz,.upndown                                                                ;it's non zero so isn't pressed


.doRight:

        ld a, 0
        ld (bee_direction), a
                                                                   ;set horizontal tank sprite

        ld  a, (bee_going_right)
		cp 1
		jp z, .IncreaseRightSpeed


.DecreaseLeftSpeed:

		ld a, CONTROL_BRAKE
		ld b, a
		ld a, (x_speed_frac)
		sub b
		ld (x_speed_frac), a

		ld a, (x_speed_pixel)
		sbc 0
		ld (x_speed_pixel), a
		jp p, .StillLefting

		ld a, 1
		ld (bee_going_right), a
		ld (x_speed_frac), a

		xor a
		ld (x_speed_pixel), a



.StillLefting:

		ret

.IncreaseRightSpeed:

		ld a, CONTROL_EFFECT
		ld b, a
		ld a, (x_speed_frac)
		add b
		ld (x_speed_frac), a

		ld a, (x_speed_pixel)
		adc 0
		ld (x_speed_pixel), a

	                             ;no flip y - set to 0 - clear
        ret                                      
      
   


.upndown:                
        ld a,b                                                                                ;get state again
        and inp_chk_up                                                                ;examine up
        and a                                                                                ;check if pressed
        jp nz,.down                                                                        ;it's non zero so isn't pressed


.doUp:
		
		ld a, (bee_falling)
		cp 1
		jp nz, .IncreaseUpSpeed


.DecreaseDownSpeed:

		ld a, CONTROL_EFFECT
		ld b, a
		ld a, (y_speed_frac)
		sub b
		ld (y_speed_frac), a

		ld a, (y_speed_pixel)
		sbc 0
		ld (y_speed_pixel), a
		jp p, .StillFalling

		ld a, 0
		ld (bee_falling), a

		ld a, 1
		ld (y_speed_frac), a

		xor a
		ld (y_speed_pixel), a

.StillFalling:

		ret

.IncreaseUpSpeed:

		ld a, CONTROL_EFFECT
		ld b, a
		ld a, (y_speed_frac)
		add b
		ld (y_speed_frac), a

		ld a, (y_speed_pixel)
		adc 0
		ld (y_speed_pixel), a

	                             ;no flip y - set to 0 - clear
        ret                                                                                        ;don't bother checker down


.down:  ld a,b                                                                                ;get state again
        and inp_chk_down                                                        ;examine down
        and a                                                                                ;check if pressed
        ret nz                                                                                ;it's non zero so isn't pressed so finish


.doDown:
	
		
		ld  a, (bee_falling)
		cp 1
		jp z, .IncreaseDownSpeed


.DecreaseUpSpeed:

		ld a, CONTROL_EFFECT
		ld b, a
		ld a, (y_speed_frac)
		sub b
		ld (y_speed_frac), a

		ld a, (y_speed_pixel)
		sbc 0
		ld (y_speed_pixel), a
		jp p, .StillRising

		ld a, 1
		ld (bee_falling), a
		ld (y_speed_frac), a

		xor a
		ld (y_speed_pixel), a



.StillRising:

		ret

.IncreaseDownSpeed:

		ld a, CONTROL_EFFECT
		ld b, a
		ld a, (y_speed_frac)
		add b
		ld (y_speed_frac), a

		ld a, (y_speed_pixel)
		adc 0
		ld (y_speed_pixel), a

	                             ;no flip y - set to 0 - clear
        ret                                      
      

.exit:
     

        ret

