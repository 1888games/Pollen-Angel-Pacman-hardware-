wasp_update:
		
	;ret

	ld a, (frame_counter)
	and %00000011
	jp nz, noFrameChange

	ld a, (wasp_frame)
	cp 0
	jp z, make4

	xor a
	ld (wasp_frame), a 
	jp noFrameChange

make4:
	
	ld a, 4
	ld (wasp_frame), a

noFrameChange:

	
	ld iy, sprite1
	ld ix, wasp1
	ld b, 4



wasp_loop:

	ld a, (ix+wasp_x)
	cp 0
	jp z, end_Wasp_Loop
	
	ld a, b
	cp 3
	jp nc, wasp_horiz


wasp_vert:

			
	xor a
	ld c, a
	
	ld a, (ix+wasp_direction)
	cp 0
	jp z, wasp_up


wasp_down:
	
	ld a, (ix+wasp_frac)
	add a, (ix+wasp_speed)
	ld (ix+wasp_frac), a

	ld a, (iy + spr_y)
	sbc 0
	ld (iy + spr_y), a

	cp (ix + wasp_target_2)
	jp nz, do_vert_frame

	ld a, 0
	ld (ix+wasp_direction), a

	
	jp do_vert_frame

wasp_up:
		


	ld a, (ix+wasp_frac)
	

	;ld a, (ix+wasp_frac)
	add a, (ix+wasp_speed)
	ld (ix+wasp_frac), a

	ld a, (iy + spr_y)
	adc 0
	ld (iy + spr_y), a

	cp (ix + wasp_target_1)
	jp nz, do_vert_frame

	ld a, 1
	ld (ix+wasp_direction), a


	
	jp do_vert_frame


wasp_horiz:

	ld a, (ix+wasp_direction)
	cp 0
	jp z, wasp_left


wasp_right:
	
	ld a, (ix+wasp_frac)
	add a, (ix+wasp_speed)
	ld (ix+wasp_frac), a

	ld a, (iy + spr_x)
	sbc 0
	ld (iy + spr_x), a

	cp (ix + wasp_target_2)
	jp nz, do_wasp_frame

	ld a, 0
	ld (ix+wasp_direction), a
	
	jp do_wasp_frame

wasp_left:

	ld a, (ix+wasp_frac)
	

	;ld a, (ix+wasp_frac)
	add a, (ix+wasp_speed)
	ld (ix+wasp_frac), a

	ld a, (iy + spr_x)
	adc 0
	ld (iy + spr_x), a

	cp (ix + wasp_target_1)
	jp nz, do_wasp_frame

	ld a, 1
	ld (ix+wasp_direction), a

do_wasp_frame:

	ld a, (ix+wasp_direction)
	sla a
	sla a
	sla a
	ld c, a

do_vert_frame:

	ld a,(wasp_frame)
	add a, c
	add a, (ix+wasp_base_frame)
	ld (iy + spr_num), a
	
end_Wasp_Loop:

	call checkBeeCollision
	
	call nextWasp

	ld hl, time_location - 3
	ld (hl), b

	djnz backToTop



	ret

backToTop:
		
		jp wasp_loop



checkBeeCollision: 



	ld a, (sprite0 + spr_x)
	ld c, a

	ld a, (iy + spr_x)
	cp 0
	ret z

	sub c
	add 8
	cp 16
	ret nc

	ld a, (sprite0 + spr_y)
	ld c, a

	ld a, (iy + spr_y)
	sub c
	add 8
	cp 16
	ret nc




	call lose_set






	ret

wasp_initialise: 
		
	ld a, 0
	ld (wasp_frame), a
		
	ld b, 4
	ld ix, wasp1
	ld iy, sprite1


initialise_loop:

	inc hl
	ld a, (hl)

	ld (ix + wasp_x), a
	ld (iy + spr_x), a

	inc hl
	ld a, (hl)

	ld (ix + wasp_y), a
	ld (iy + spr_y), a
	
	inc hl
	ld a, (hl)

	ld (ix + wasp_target_1), a

	ld a, b
	cp 3
	jp nc, horiz

	ld a, (ix + wasp_y)
	ld (ix + wasp_target_2), a

	jp nowSpeed

horiz:

	ld a, (ix + wasp_x)
	ld (ix + wasp_target_2), a
	

nowSpeed:

	inc hl

	ld a, (hl)
	ld (ix+wasp_speed), a


	ld a, (ix + wasp_target_2)
	cp (ix+wasp_target_1)
	jp c, noSwap

	ld c, a
	ld a, (ix + wasp_target_1)
	ld (ix + wasp_target_2), a
	ld a, c
	ld (ix + wasp_target_1), a

	ld a, 1
	ld (ix + wasp_direction), a

noSwap:

	call nextWasp

	djnz initialise_loop
	

	ret

nextWasp:
	
	ld a, ixl
	add a, WASP_DATA_LENGTH
	ld ixl, a

	ld a, ixh
	adc 0
	ld ixh, a 

	inc iy
	inc iy

	ret


