

// ixh = width
// iyl = tile_type
// iyh = colour
// a = x
// b = y
// 

// ixl used in tile lookup

get_next_bytes2:


	ld c, a

	inc hl // y
	ld a, (hl)
	ld b, a

	inc hl
	ld a, (hl)
	ld ixh, a

	ret

draw_map:

	rla
	ld l, a
	ld h, 0
	ld de, level_data
	add hl, de

	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a


draw_tile_type:
	
	ld a, (hl)
	cp -2
	jp z, wasp_initialise

	ld iyl, a  // tile

	inc hl 
	ld a, (hl)
	ld iyh, a  // colour

	inc hl 
	ld a, (hl)
	ld (tile_direction), a  // direction

	inc hl

draw_platforms:
	
	ld a, (hl) // x
	cp -1
	jp nz, continue_platforms

	inc hl
	jp draw_tile_type

continue_platforms:


	call get_next_bytes2

	ld (temp_address), hl
	
	ld a, c

	call calc_tile_location

	ld a, (tile_direction)
	cp 0
	jp nz, vertical_tiles

	call first_loop
	jp draw_platforms

vertical_tiles:
	
	call first_loop_v
	jp draw_platforms


vertical_tile_loop:
	
	ld ixh, b

first_loop_v:

	call draw_map_tile


	ld a, l
	add 1
	ld l, a

	ld a, h
	adc 0
	ld h, a


	ld b, ixh

	djnz vertical_tile_loop

        // a = x
        // b = y
   	ld hl, (temp_address)
    inc hl

    ret




horizontal_tile_loop:
	
	ld ixh, b

first_loop:

	call draw_map_tile


	ld a, l
	sub 32
	ld l, a

	ld a, h
	sbc 0
	ld h, a


	ld b, ixh

	djnz horizontal_tile_loop

        // a = x
        // b = y
   	ld hl, (temp_address)
    inc hl

    ret


draw_map_tile:

	ld a, iyl
	ld (hl), a

	set 2,h       

	ld a, iyh
	ld (hl), a

	res 2, h


	ret