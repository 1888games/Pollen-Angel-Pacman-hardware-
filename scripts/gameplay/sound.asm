



SFX_died:

	ld a, 15
	ld (freq1), a

	ret


SFX_suck:
	ld a, (freq2)
	cp 16
	ret nz

	ld a, 1
	ld (freq2), a

	ret


