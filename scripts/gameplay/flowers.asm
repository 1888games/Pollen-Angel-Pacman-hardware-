GROW_FREQUENCY: equ 4
WILT_FREQUENCY:	equ 244
FLOWER_FREQUENCY: equ 60
TIME_LIMIT: equ $90



check_wilt:



	call random
	cp 150
	jp z, wilt_me

	cp WILT_FREQUENCY
	jp c, nextFlower


wilt_me:

	ld iyl, (tile_flower_wilt)
	ld iyh, (palette_orange_green_orange)
	call draw_map_tile


	jp nextFlower



check_shrink:

	ld a, blank_tile
	ld (hl), a

	inc hl

	ld a, (hl)
	cp tile_stem
	jp nz, done_shrinking

	
	ld iyl, (tile_stem_wilt)
	ld iyh, (palette_orange_green_orange)
	call draw_map_tile


	jp nextFlower

check_wilt_stem:	

	ld a, blank_tile
	ld (hl), a

	inc hl

	ld iyl, (tile_stem_wilt)
	ld iyh, (palette_orange_green_orange)
	call draw_map_tile


	jp nextFlower

done_shrinking:

	ld a, 0
	ld (de), a

	dec de
	ld (de), a

	inc de

	ld a, (flowers_grown)
	dec a
	ld (flowers_grown), a

	jp nextFlower


grow_flowers:
	
	ld de, flower_positions
	ld b, MAX_FLOWERS

flowerLoop:
	
	ld a, b
	ld (temp_byte), a

	ld a, (de)
	cp 0
	jp z, nextFlower

 	ld h, a

 	inc de
 	ld a, (de)
 	ld l, a


	call random
	cp GROW_FREQUENCY
	jp nc, nextFlower


	ld b, 5

goUpStem:

	ld a, (hl)

	cp tile_stem_wilt
	jp z, check_shrink

	cp tile_flower_wilt
	jp z, check_wilt_stem

	cp tile_flower_eaten
	jp z, check_wilt_stem

	cp tile_flower
	jp z, check_wilt

	cp tile_stem
	jp z, next_tile_up

	cp blank_tile
	jp nz, reachedBarrier

	jp newStem

next_tile_up:

	dec hl

	djnz goUpStem
	
	inc hl

	jp drawFlower

newStem:

	call random
	cp FLOWER_FREQUENCY
	jp c, drawFlower

	ld iyl, (tile_stem)
	ld iyh, (stem_colour)
	call draw_map_tile

	jp nextFlower

reachedBarrier:
	
	inc hl

drawFlower:
	
	call get_random_colour

	ld iyh, a
	ld iyl, (tile_flower)
	
	call draw_map_tile

	ret

nextFlower:	

	inc de

	ld a, (temp_byte)
	ld b, a
	djnz flowerLoop

	ret







flower_update:
	
	ld a, (flowers_grown)
	cp 16
	jp z, grow_flowers

positionsLeft:

	ld a, (new_flower_timer)
	cp 0
	jp z, get_new_flower

	dec a
	ld (new_flower_timer), a

	jp grow_flowers

get_new_flower:

	ld a, (current_level)
	and %00000011
	rla
	ld l, a
	ld h, 0
	ld de, level_data
	add hl, de

	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a

	inc hl
	inc hl

try_this_platform:

	inc hl

	ld a, (hl) // x
	cp -1
	ret z

continue_new_flower:


	call get_next_bytes2

	ld (temp_address), hl	
	ld a, c

	call calc_tile_location

	dec hl
	jp skipFirst

nextTileLoop:
	
	ld ixh, b

skipFirst:
	
	ld a, (hl)
	cp blank_tile
	jp nz, nextTile
	
	call random
	and %00011111
	jp nz, nextTile


	ld iyl, (tile_stem)
	ld iyh, (stem_colour)
	call draw_map_tile

	ld a, (new_flower_time)
	ld (new_flower_timer), a

	jp add_flower

nextTile:
	
	ld a, l
	sub 32
	ld l, a

	ld a, h
	sbc 0
	ld h, a

	ld b, ixh
	
	djnz nextTileLoop


	ld hl, (temp_address)

	jp try_this_platform





add_flower:
	
	ld (temp_address), hl
	
	ld hl, flower_positions
	ld b, MAX_FLOWERS

getIdLoop:

	ld a, (hl)
	cp 0
	jp nz, tryNextPosition

foundID:
		

	ld a, (flowers_grown)
	inc a
	ld (flowers_grown), a

	ld de, (temp_address)

	ld (hl), d

	inc hl
	ld (hl), e

	;ld a, 4
	;l;d (de), a


	ret

tryNextPosition:
	
	inc hl
	inc hl

	djnz getIdLoop


	ret
