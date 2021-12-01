;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _playerOnBUG
	.globl _updateGem
	.globl _respawnFuel
	.globl _bugKilled
	.globl _moveBugs
	.globl _playerGetsFuel
	.globl _updateFire
	.globl _playerSetsFire
	.globl _movePlayer
	.globl _resetGame
	.globl _spriteOnSprite
	.globl _obstruction
	.globl _centeredOnTile
	.globl _performantDelay
	.globl _printf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _wait_vbl_done
	.globl _joypad
	.globl _bug_status
	.globl _bug_d
	.globl _bug_dx
	.globl _bug_y
	.globl _bug_x
	.globl _bug_respawn_location_cnt
	.globl _gems_collected
	.globl _gem_y
	.globl _gem_x
	.globl _gem_y_list
	.globl _gem_x_list
	.globl _fuel_icon_y
	.globl _fuel_icon_x
	.globl _fuel_y
	.globl _fuel_x
	.globl _fire_cnt
	.globl _fire_y
	.globl _fire_x
	.globl _player_max_fuel
	.globl _player_fuel
	.globl _player_d
	.globl _player_dy
	.globl _player_dx
	.globl _player_y
	.globl _player_x
	.globl _game_over
	.globl _ready_to_start
	.globl _anim_cnt
	.globl _gem_rando_cnt
	.globl _bug_rando_cnt
	.globl _A_button_pressed
	.globl _button_pressed
	.globl _game_map
	.globl _bug_tiles
	.globl _centered
	.globl _joydata
	.globl _bug_y_respawn
	.globl _bug_x_respawn
	.globl _fuel_icon_x_respawn
	.globl _fuel_x_respawn
	.globl _fire_max_cnt
	.globl _wall
	.globl _floor
	.globl _rando
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_joydata::
	.ds 1
_centered::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_bug_tiles::
	.ds 400
_game_map::
	.ds 360
_button_pressed::
	.ds 1
_A_button_pressed::
	.ds 1
_bug_rando_cnt::
	.ds 1
_gem_rando_cnt::
	.ds 1
_anim_cnt::
	.ds 1
_ready_to_start::
	.ds 1
_game_over::
	.ds 1
_player_x::
	.ds 1
_player_y::
	.ds 1
_player_dx::
	.ds 1
_player_dy::
	.ds 1
_player_d::
	.ds 1
_player_fuel::
	.ds 1
_player_max_fuel::
	.ds 1
_fire_x::
	.ds 3
_fire_y::
	.ds 3
_fire_cnt::
	.ds 3
_fuel_x::
	.ds 4
_fuel_y::
	.ds 4
_fuel_icon_x::
	.ds 3
_fuel_icon_y::
	.ds 3
_gem_x_list::
	.ds 8
_gem_y_list::
	.ds 8
_gem_x::
	.ds 1
_gem_y::
	.ds 1
_gems_collected::
	.ds 1
_bug_respawn_location_cnt::
	.ds 1
_bug_x::
	.ds 4
_bug_y::
	.ds 4
_bug_dx::
	.ds 4
_bug_d::
	.ds 4
_bug_status::
	.ds 4
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:67: void performantDelay(UINT8 numloops)
;	---------------------------------
; Function performantDelay
; ---------------------------------
_performantDelay::
;main.c:70: for (i = 0; i < numloops; i++)
	ld	c, #0x00
00103$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:72: wait_vbl_done();
	call	_wait_vbl_done
;main.c:70: for (i = 0; i < numloops; i++)
	inc	c
;main.c:74: }
	jr	00103$
_rando:
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
_floor:
	.db #0x00	; 0
_wall:
	.db #0x0a	; 10
_fire_max_cnt:
	.db #0x32	; 50	'2'
_fuel_x_respawn:
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x80	; 128
	.db #0x80	; 128
_fuel_icon_x_respawn:
	.db #0x38	; 56	'8'
	.db #0x40	; 64
	.db #0x48	; 72	'H'
_bug_x_respawn:
	.db #0x10	; 16
	.db #0x98	; 152
	.db #0x10	; 16
	.db #0x98	; 152
_bug_y_respawn:
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
;main.c:76: UBYTE centeredOnTile(UINT8 spriteX, UINT8 spriteY){
;	---------------------------------
; Function centeredOnTile
; ---------------------------------
_centeredOnTile::
;main.c:78: ready = (spriteX%8)+(spriteY%8);
	ldhl	sp,	#2
	ld	a, (hl+)
	and	a, #0x07
	ld	c, a
	ld	a, (hl)
	and	a, #0x07
	add	a, c
;main.c:79: return ready;
	ld	e, a
;main.c:80: }
	ret
;main.c:82: UBYTE obstruction(UINT8 spriteX, UINT8 spriteY, UINT8 spriteD){
;	---------------------------------
; Function obstruction
; ---------------------------------
_obstruction::
	add	sp, #-3
;main.c:85: INT8 dx = 0;
	ld	c, #0x00
;main.c:86: INT8 dy = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;main.c:87: if(spriteD == 0){
	ldhl	sp,	#7
	ld	a, (hl)
	or	a, a
	jr	NZ, 00102$
;main.c:88: dy = -1;	//<- this...
	ldhl	sp,	#0
	ld	(hl), #0xff
00102$:
;main.c:90: if(spriteD == 1){
	ldhl	sp,	#7
	ld	a, (hl)
	dec	a
	jr	NZ, 00104$
;main.c:91: dy = 8;		//<- this...
	ldhl	sp,	#0
	ld	(hl), #0x08
00104$:
;main.c:93: if(spriteD == 2){
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00106$
;main.c:94: dx = -1;	//<- this...
	ld	c, #0xff
00106$:
;main.c:96: if(spriteD == 3){
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00108$
;main.c:97: dx = 8;		//<- this...
	ld	c, #0x08
00108$:
;main.c:99: if(game_map[((spriteX-8+dx)/8)+(((spriteY-16+dy)/8)*20)] == wall){
	ldhl	sp,	#5
	ld	a, (hl)
	ld	b, #0x00
	add	a, #0xf8
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	d, a
	ld	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	rlca
	sbc	a, a
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	add	hl, de
	ld	c, l
	ld	b, h
	bit	7, h
	jr	Z, 00114$
	ld	bc, #0x7
	add	hl,bc
	ld	c, l
	ld	b, h
00114$:
	ldhl	sp,	#1
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	inc	hl
	sra	(hl)
	dec	hl
	rr	(hl)
	ldhl	sp,	#6
	ld	a, (hl)
	ld	c, #0x00
	add	a, #0xf0
	ld	e, a
	ld	a, c
	adc	a, #0xff
	ld	d, a
	ldhl	sp,	#0
	ld	a, (hl)
	ld	c, a
	rlca
	sbc	a, a
	ld	b, a
	ld	a, e
	add	a, c
	ld	c, a
	ld	a, d
	adc	a, b
	ld	b, a
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	bit	7, b
	jr	Z, 00115$
	ld	hl, #0x0007
	add	hl, bc
00115$:
	sra	h
	rr	l
	sra	h
	rr	l
	sra	h
	rr	l
	ld	c, l
	ld	b, h
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#1
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	bc,#_game_map
	add	hl,bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	hl, #_wall
	ld	c, (hl)
	sub	a, c
;main.c:100: return 1;
;main.c:103: return 0;
	ld	e, #0x01
	jr	Z, 00112$
	ld	e, #0x00
00112$:
;main.c:105: }
	add	sp, #3
	ret
;main.c:107: UBYTE spriteOnSprite(UINT8 x_1,UINT8 y_1,UINT8 x_2,UINT8 y_2){
;	---------------------------------
; Function spriteOnSprite
; ---------------------------------
_spriteOnSprite::
	add	sp, #-8
;main.c:108: if(x_1 >= x_2 && y_1 >= y_2 && x_1 <= x_2+7 && y_1 <= y_2+7 || x_2 >= x_1 && y_2 >= y_1 && x_2 <= x_1+7 && y_2 <= y_1+7){
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jr	C, 00110$
	dec	hl
	ld	a, (hl+)
	inc	hl
	sub	a, (hl)
	jr	C, 00110$
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00143$
	bit	7, d
	jr	NZ, 00144$
	cp	a, a
	jr	00144$
00143$:
	bit	7, d
	jr	Z, 00144$
	scf
00144$:
	jr	C, 00110$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00145$
	bit	7, d
	jr	NZ, 00146$
	cp	a, a
	jr	00146$
00145$:
	bit	7, d
	jr	Z, 00146$
	scf
00146$:
	jr	NC, 00101$
00110$:
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	C, 00102$
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	sub	a, (hl)
	jr	C, 00102$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00147$
	bit	7, d
	jr	NZ, 00148$
	cp	a, a
	jr	00148$
00147$:
	bit	7, d
	jr	Z, 00148$
	scf
00148$:
	jr	C, 00102$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00149$
	bit	7, d
	jr	NZ, 00150$
	cp	a, a
	jr	00150$
00149$:
	bit	7, d
	jr	Z, 00150$
	scf
00150$:
	jr	C, 00102$
00101$:
;main.c:109: return 1;
	ld	e, #0x01
	jr	00111$
00102$:
;main.c:112: return 0;
	ld	e, #0x00
00111$:
;main.c:114: }
	add	sp, #8
	ret
;main.c:116: void resetGame(){
;	---------------------------------
; Function resetGame
; ---------------------------------
_resetGame::
	add	sp, #-5
;main.c:118: player_x=80;
	ld	hl, #_player_x
	ld	(hl), #0x50
;main.c:119: player_y=56;
	ld	hl, #_player_y
	ld	(hl), #0x38
;main.c:121: for(UINT8 i = 0; i < 4; i = i + 1){
	ldhl	sp,	#2
	ld	(hl), #0x00
00109$:
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00101$
;main.c:122: bug_x[i] = bug_x_respawn[i];
	ld	de, #_bug_x
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	de, #_bug_x_respawn
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl), a
;main.c:123: bug_y[i] = bug_y_respawn[i];
	ld	a, (hl-)
	dec	hl
	ld	(bc), a
	ld	de, #_bug_y
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	de, #_bug_y_respawn
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(bc), a
;main.c:124: move_sprite(i+1,bug_x[i],bug_y[i]);
	ldhl	sp,	#3
	ld	(hl-), a
	ld	c, (hl)
	inc	c
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_shadow_OAM)
	ld	e, a
	ld	a, h
	adc	a, #>(_shadow_OAM)
	ld	d, a
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	(de), a
	inc	de
;main.c:121: for(UINT8 i = 0; i < 4; i = i + 1){
	ld	a, (hl-)
	dec	hl
	ld	(de), a
	ld	(hl), c
	jr	00109$
00101$:
;main.c:127: for(UINT8 i = 0; i < 4; i = i + 1){
	ldhl	sp,	#0
	ld	(hl), #0x00
00112$:
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00102$
;main.c:128: fuel_x[i] = fuel_x_respawn[i];
	ld	de, #_fuel_x
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
	ld	(hl-), a
	dec	hl
	ld	de, #_fuel_x_respawn
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	b, a
	ldhl	sp,	#1
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), b
;main.c:129: move_sprite(i+8,fuel_x[i],fuel_y[i]);
	ld	de, #_fuel_y
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#0
	ld	c, (hl)
	ld	a, c
	add	a, #0x08
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ldhl	sp,	#4
	ld	a, (hl)
	ld	(de), a
	inc	de
	ld	a, b
	ld	(de), a
;main.c:127: for(UINT8 i = 0; i < 4; i = i + 1){
	ld	a, c
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
	jr	00112$
00102$:
;main.c:132: gem_rando_cnt += 1;
	ld	hl, #_gem_rando_cnt
	inc	(hl)
	ld	a, (hl)
;main.c:133: if(gem_rando_cnt > 7){
	ld	a, #0x07
	sub	a, (hl)
	jr	NC, 00104$
;main.c:134: gem_rando_cnt = 0;
	ld	(hl), #0x00
00104$:
;main.c:136: gem_x = gem_x_list[gem_rando_cnt];
	ld	a, #<(_gem_x_list)
	ld	hl, #_gem_rando_cnt
	add	a, (hl)
	ld	c, a
	ld	a, #>(_gem_x_list)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	(#_gem_x),a
;main.c:137: gem_y = gem_y_list[gem_rando_cnt];
	ld	a, #<(_gem_y_list)
	ld	hl, #_gem_rando_cnt
	add	a, (hl)
	ld	c, a
	ld	a, #>(_gem_y_list)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ld	hl, #_gem_y
	ld	(hl), a
;main.c:138: move_sprite(12,gem_x,gem_y);
	ld	c, (hl)
	ld	hl, #_gem_x
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 48)
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:138: move_sprite(12,gem_x,gem_y);
;main.c:139: }
	add	sp, #5
	ret
;main.c:141: void movePlayer(){
;	---------------------------------
; Function movePlayer
; ---------------------------------
_movePlayer::
;main.c:142: centered = centeredOnTile(player_x,player_y);
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_centeredOnTile
	pop	hl
	ld	hl, #_centered
	ld	(hl), e
;main.c:143: joydata = joypad();
	call	_joypad
	ld	hl, #_joydata
	ld	(hl), e
;main.c:144: if(centered == 0){
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00102$
;main.c:145: button_pressed = 0;
	ld	hl, #_button_pressed
	ld	(hl), #0x00
00102$:
;main.c:147: if(joydata & J_LEFT && centered == 0 && button_pressed == 0){
	ld	a, (#_joydata)
	bit	1, a
	jr	Z, 00106$
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00106$
	ld	a, (#_button_pressed)
	or	a, a
	jr	NZ, 00106$
;main.c:148: player_d = 2;
	ld	hl, #_player_d
	ld	(hl), #0x02
;main.c:149: if(obstruction(player_x,player_y,player_d) == 0){
	ld	a, #0x02
	push	af
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	NZ, 00106$
;main.c:150: player_x -= player_dx;	//important nudge to make player not centered
	ld	a, (#_player_x)
	ld	hl, #_player_dx
	sub	a, (hl)
	ld	(#_player_x),a
;main.c:151: button_pressed = 1;
	ld	hl, #_button_pressed
	ld	(hl), #0x01
00106$:
;main.c:155: if(joydata & J_RIGHT && centered == 0 && button_pressed == 0){
	ld	a, (#_joydata)
	rrca
	jr	NC, 00112$
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00112$
	ld	a, (#_button_pressed)
	or	a, a
	jr	NZ, 00112$
;main.c:156: player_d = 3;
	ld	hl, #_player_d
	ld	(hl), #0x03
;main.c:157: if(obstruction(player_x,player_y,player_d) == 0){
	ld	a, #0x03
	push	af
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	NZ, 00112$
;main.c:158: player_x += player_dx;
	ld	a, (#_player_x)
	ld	hl, #_player_dx
	add	a, (hl)
	ld	(#_player_x),a
;main.c:159: button_pressed = 1;
	ld	hl, #_button_pressed
	ld	(hl), #0x01
00112$:
;main.c:163: if(joydata & J_UP && centered == 0 && button_pressed == 0){
	ld	a, (#_joydata)
	bit	2, a
	jr	Z, 00118$
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00118$
	ld	a, (#_button_pressed)
	or	a, a
	jr	NZ, 00118$
;main.c:164: player_d = 0;
	ld	hl, #_player_d
	ld	(hl), #0x00
;main.c:165: if(obstruction(player_x,player_y,player_d) == 0){
	xor	a, a
	push	af
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	NZ, 00118$
;main.c:166: player_y -= player_dy;
	ld	a, (#_player_y)
	ld	hl, #_player_dy
	sub	a, (hl)
	ld	(#_player_y),a
;main.c:167: button_pressed = 1;
	ld	hl, #_button_pressed
	ld	(hl), #0x01
00118$:
;main.c:171: if(joydata & J_DOWN && centered == 0 && button_pressed == 0){
	ld	a, (#_joydata)
	bit	3, a
	jr	Z, 00124$
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00124$
	ld	a, (#_button_pressed)
	or	a, a
	jr	NZ, 00124$
;main.c:172: player_d = 1;
	ld	hl, #_player_d
	ld	(hl), #0x01
;main.c:173: if(obstruction(player_x,player_y,player_d) == 0){
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	NZ, 00124$
;main.c:174: player_y += player_dy;
	ld	a, (#_player_y)
	ld	hl, #_player_dy
	add	a, (hl)
	ld	(#_player_y),a
;main.c:175: button_pressed = 1;
	ld	hl, #_button_pressed
	ld	(hl), #0x01
00124$:
;main.c:179: if(obstruction(player_x,player_y,player_d) == 0 && centered != 0){
	ld	a, (#_player_d)
	ld	h, a
	ld	a, (#_player_y)
	ld	l, a
	push	hl
	ld	a, (#_player_x)
	push	af
	inc	sp
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	NZ, 00133$
	ld	a, (#_centered)
	or	a, a
	jr	Z, 00133$
;main.c:180: switch(player_d){
	ld	a, (#_player_d)
	or	a, a
	jr	Z, 00127$
	ld	a, (#_player_d)
	dec	a
	jr	Z, 00128$
	ld	a, (#_player_d)
	sub	a, #0x02
	jr	Z, 00129$
	ld	a, (#_player_d)
	sub	a, #0x03
	jr	Z, 00130$
	jr	00133$
;main.c:181: case 0:
00127$:
;main.c:182: player_y -= player_dy;
	ld	a, (#_player_y)
	ld	hl, #_player_dy
	sub	a, (hl)
	ld	(#_player_y),a
;main.c:183: break;
	jr	00133$
;main.c:184: case 1:
00128$:
;main.c:185: player_y += player_dy;
	ld	a, (#_player_y)
	ld	hl, #_player_dy
	add	a, (hl)
	ld	(#_player_y),a
;main.c:186: break;
	jr	00133$
;main.c:187: case 2:
00129$:
;main.c:188: player_x -= player_dx;
	ld	a, (#_player_x)
	ld	hl, #_player_dx
	sub	a, (hl)
	ld	(#_player_x),a
;main.c:189: break;
	jr	00133$
;main.c:190: case 3:
00130$:
;main.c:191: player_x += player_dx;
	ld	a, (#_player_x)
	ld	hl, #_player_dx
	add	a, (hl)
	ld	(#_player_x),a
;main.c:192: }
00133$:
;main.c:194: move_sprite(0,player_x,player_y);
	ld	hl, #_player_y
	ld	b, (hl)
	ld	hl, #_player_x
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:194: move_sprite(0,player_x,player_y);
;main.c:195: }
	ret
;main.c:197: void playerSetsFire(){
;	---------------------------------
; Function playerSetsFire
; ---------------------------------
_playerSetsFire::
	dec	sp
	dec	sp
;main.c:202: joydata = joypad();
	call	_joypad
	ld	hl, #_joydata
	ld	(hl), e
;main.c:204: if(joydata | J_A && A_button_pressed == 1){
	ld	a, (hl)
	or	a, #0x10
	jr	Z, 00102$
	ld	a, (#_A_button_pressed)
	dec	a
	jr	NZ, 00102$
;main.c:205: A_button_pressed = 0;
	ld	hl, #_A_button_pressed
	ld	(hl), #0x00
00102$:
;main.c:207: if(joydata & J_A && A_button_pressed == 0){
	ld	a, (#_joydata)
	bit	4, a
	jp	Z,00123$
	ld	hl, #_A_button_pressed
	ld	a, (hl)
	or	a, a
	jp	NZ, 00123$
;main.c:208: A_button_pressed = 1;
	ld	(hl), #0x01
;main.c:209: UBYTE fire_placed = 0;
	ld	c, #0x00
;main.c:211: UBYTE player_on_fire = 0;
	ldhl	sp,	#0
;main.c:212: for(UINT8 i = 0; i < 3; i = i + 1){
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00118$:
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, #0x03
	jr	NC, 00106$
;main.c:213: if(spriteOnSprite(player_x,player_y,fire_x[i],fire_y[i]) == 1){
	ld	de, #_fire_y
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
	ld	de, #_fire_x
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	push	bc
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_spriteOnSprite
	add	sp, #4
	pop	bc
	dec	e
	jr	NZ, 00119$
;main.c:214: player_on_fire = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
00119$:
;main.c:212: for(UINT8 i = 0; i < 3; i = i + 1){
	ldhl	sp,	#1
	inc	(hl)
	ld	a, (hl)
	jr	00118$
00106$:
;main.c:217: for(UINT8 i = 0; i < 3; i = i + 1){
	ld	b, #0x00
00121$:
	ld	a, b
	sub	a, #0x03
	jr	NC, 00123$
;main.c:218: if(player_on_fire == 0 && fire_cnt[i] == fire_max_cnt && fire_placed == 0){
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	NZ, 00122$
	ld	a, #<(_fire_cnt)
	add	a, b
	ld	e, a
	ld	a, #>(_fire_cnt)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	hl, #_fire_max_cnt
	ld	e, (hl)
	sub	a,e
	jr	NZ, 00122$
	or	a,c
	jr	NZ, 00122$
;main.c:219: fire_placed =1;
	ld	c, #0x01
;main.c:220: fire_x[i] = player_x;
	ld	a, #<(_fire_x)
	add	a, b
	ld	e, a
	ld	a, #>(_fire_x)
	adc	a, #0x00
	ld	d, a
	ld	a, (#_player_x)
	ld	(de), a
;main.c:221: fire_y[i] = player_y;
	ld	a, #<(_fire_y)
	add	a, b
	ld	e, a
	ld	a, #>(_fire_y)
	adc	a, #0x00
	ld	d, a
	ld	a, (#_player_y)
	ld	(de), a
;main.c:222: set_sprite_tile(5+i,8);
	ld	a, b
	add	a, #0x05
	ld	d, a
	ld	e, d
;c:/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	pop	de
	ld	(hl), #0x08
;main.c:223: move_sprite(5+i,fire_x[i],fire_y[i]);
	ld	hl, #_player_y
	ld	e, (hl)
	ld	a, (#_player_x)
	ldhl	sp,	#1
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, d
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
;main.c:223: move_sprite(5+i,fire_x[i],fire_y[i]);
00122$:
;main.c:217: for(UINT8 i = 0; i < 3; i = i + 1){
	inc	b
	jr	00121$
00123$:
;main.c:227: } 
	inc	sp
	inc	sp
	ret
;main.c:229: void updateFire(){
;	---------------------------------
; Function updateFire
; ---------------------------------
_updateFire::
	dec	sp
	dec	sp
;main.c:230: for(UINT8 i = 0; i < 3; i = i + 1){
	ld	c, #0x00
00110$:
	ld	a, c
	sub	a, #0x03
	jr	NC, 00112$
;main.c:231: if(fire_x[i] > 0){
	ld	de, #_fire_x
	ld	l, c
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	b, a
;main.c:232: if(fire_cnt[i] != 0){
	ld	a, #<(_fire_cnt)
	add	a, c
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #>(_fire_cnt)
	adc	a, #0x00
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
;main.c:231: if(fire_x[i] > 0){
	ld	a, b
	or	a, a
	jr	Z, 00104$
;main.c:232: if(fire_cnt[i] != 0){
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
;main.c:233: fire_cnt[i] -= 1;
	dec	a
	ld	(hl), a
00104$:
;main.c:236: if(fire_cnt[i] <= 0){
	ld	a, (hl)
	or	a, a
	jr	NZ, 00111$
;main.c:237: fire_x[i] = 0;
	pop	hl
	push	hl
	ld	(hl), #0x00
;main.c:238: move_sprite(5+i,fire_x[i],fire_y[i]);
	ld	hl, #_fire_y
	ld	b, #0x00
	add	hl, bc
	ld	b, (hl)
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, c
	add	a, #0x05
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	e, l
	ld	d, h
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
;main.c:238: move_sprite(5+i,fire_x[i],fire_y[i]);
00111$:
;main.c:230: for(UINT8 i = 0; i < 3; i = i + 1){
	inc	c
	jr	00110$
00112$:
;main.c:241: }
	inc	sp
	inc	sp
	ret
;main.c:243: void playerGetsFuel(){
;	---------------------------------
; Function playerGetsFuel
; ---------------------------------
_playerGetsFuel::
	add	sp, #-7
;main.c:249: for(UINT8 i = 0; i < 4; i = i + 1){
	ldhl	sp,	#2
	ld	(hl), #0x00
00110$:
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00112$
;main.c:250: if(spriteOnSprite(player_x,player_y,fuel_x[i],fuel_y[i]) == 1){
	ld	de, #_fuel_y
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	b, a
	ld	de, #_fuel_x
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	push	af
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_spriteOnSprite
	add	sp, #4
	dec	e
	jp	NZ,00111$
;main.c:251: fuel_x[i] = 0;
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;main.c:252: move_sprite(i+8,fuel_x[i],fuel_y[i]);
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#5
	ld	a, c
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, #0x02
00141$:
	ldhl	sp,	#0
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00141$
	pop	de
	push	de
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(de), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ldhl	sp,	#4
;main.c:253: for(UINT8 j = 0; j < 3; j = j + 1){
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	ld	(hl), #0x00
00107$:
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x03
	jr	NC, 00111$
;main.c:254: fire_cnt[j] = 50;
	ld	de, #_fire_cnt
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x32
;main.c:253: for(UINT8 j = 0; j < 3; j = j + 1){
	ldhl	sp,	#6
	inc	(hl)
	jr	00107$
00111$:
;main.c:249: for(UINT8 i = 0; i < 4; i = i + 1){
	ldhl	sp,	#2
	inc	(hl)
	ld	a, (hl)
	jp	00110$
00112$:
;main.c:258: }
	add	sp, #7
	ret
;main.c:260: void moveBugs(){
;	---------------------------------
; Function moveBugs
; ---------------------------------
_moveBugs::
	add	sp, #-7
;main.c:261: for(UINT8 i = 0; i < 4; i = i + 1){
	ldhl	sp,	#2
	ld	(hl), #0x00
00141$:
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	ld	a, #0x00
	rla
	ld	c, a
	or	a, a
	jp	Z, 00143$
;main.c:262: bug_rando_cnt +=1;
	ld	hl, #_bug_rando_cnt
	inc	(hl)
	ld	a, (hl)
;main.c:263: if(bug_rando_cnt>10){
	ld	a, #0x0a
	sub	a, (hl)
	jr	NC, 00102$
;main.c:264: bug_rando_cnt=0;
	ld	(hl), #0x00
00102$:
;main.c:266: centered = centeredOnTile(bug_x[i],bug_y[i]);
	ld	de, #_bug_y
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	b, a
	ld	de, #_bug_x
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	push	bc
	inc	sp
	push	af
	inc	sp
	call	_centeredOnTile
	pop	hl
	pop	bc
	ld	hl, #_centered
	ld	(hl), e
;main.c:267: if(centered == 0 && bug_rando_cnt < 7){	//nudge in direction. "bug_rando_cnt < 7" makes it where the bugs don't all move at the same pace.
	ld	a, (hl)
	or	a, a
	jp	NZ, 00129$
	ld	a, (#_bug_rando_cnt)
	sub	a, #0x07
	jp	NC, 00129$
;main.c:269: if(i < 4){	
	ld	a, c
	or	a, a
	jp	Z, 00129$
;main.c:270: if(player_x > bug_x[i]){
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
;main.c:271: bug_d[i] = 3;	//right
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	de, #_bug_d
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
;main.c:270: if(player_x > bug_x[i]){
	ld	a, c
	ld	hl, #_player_x
	sub	a, (hl)
	jr	NC, 00107$
;main.c:271: bug_d[i] = 3;	//right
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x03
;main.c:272: if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	b, a
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00103$
	ld	a, (#_bug_rando_cnt)
	or	a, a
	jr	NZ, 00107$
00103$:
;main.c:273: bug_x[i] += bug_dx[i];
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	de, #_bug_dx
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, c
	ld	c, a
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;main.c:274: centered = 1;
	ld	hl, #_centered
	ld	(hl), #0x01
00107$:
;main.c:277: if(player_x < bug_x[i] && centered == 0){
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	a, (#_player_x)
	sub	a, c
	jr	NC, 00112$
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00112$
;main.c:278: bug_d[i] = 2;	//left
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x02
;main.c:279: if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	b, a
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00108$
	ld	a, (#_bug_rando_cnt)
	or	a, a
	jr	NZ, 00112$
00108$:
;main.c:280: bug_x[i] -= bug_dx[i];
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	c, a
	ld	de, #_bug_dx
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, b
	ld	c, a
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;main.c:281: centered = 1;
	ld	hl, #_centered
	ld	(hl), #0x01
00112$:
;main.c:284: if(player_y > bug_y[i] && centered == 0){
	pop	de
	push	de
	ld	a, (de)
	ld	hl, #_player_y
	sub	a, (hl)
	jr	NC, 00118$
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00118$
;main.c:285: bug_d[i] = 1;	//down
	ld	de, #_bug_d
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	(hl), #0x01
;main.c:286: if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
	ld	a, (bc)
	ld	b, a
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00114$
	ld	a, (#_bug_rando_cnt)
	or	a, a
	jr	NZ, 00118$
00114$:
;main.c:287: bug_y[i] += bug_dx[i];
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	de, #_bug_dx
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, c
	ld	c, a
	pop	hl
	push	hl
	ld	(hl), c
;main.c:288: centered = 1;
	ld	hl, #_centered
	ld	(hl), #0x01
00118$:
;main.c:291: if(player_y < bug_y[i] && centered == 0){
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	a, (#_player_y)
	sub	a, c
	jr	NC, 00129$
	ld	a, (#_centered)
	or	a, a
	jr	NZ, 00129$
;main.c:292: bug_d[i] = 0;	//up
	ld	de, #_bug_d
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;main.c:293: if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
	ld	a, (bc)
	ld	b, a
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	inc	sp
	ld	h, c
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_obstruction
	add	sp, #3
	ld	a, e
	or	a, a
	jr	Z, 00120$
	ld	a, (#_bug_rando_cnt)
	or	a, a
	jr	NZ, 00129$
00120$:
;main.c:294: bug_y[i] -= bug_dx[i];
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	de, #_bug_dx
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, b
	ld	c, a
	pop	hl
	push	hl
	ld	(hl), c
;main.c:295: centered = 1;
	ld	hl, #_centered
	ld	(hl), #0x01
00129$:
;main.c:300: if(centered != 0){ //&& obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0){
	ld	a, (#_centered)
	or	a, a
	jp	Z, 00137$
;main.c:301: switch(bug_d[i]){
	ld	de, #_bug_d
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00131$
	cp	a, #0x01
	jr	Z, 00132$
;main.c:266: centered = centeredOnTile(bug_x[i],bug_y[i]);
	ldhl	sp,#3
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	af
	ld	a, (de)
	ld	c, a
	pop	af
;main.c:301: switch(bug_d[i]){
	cp	a, #0x02
	jr	Z, 00133$
	sub	a, #0x03
	jr	Z, 00134$
	jr	00137$
;main.c:302: case 0:
00131$:
;main.c:303: bug_y[i] -= bug_dx[i];
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	de, #_bug_dx
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	a, c
	sub	a, e
	ld	c, a
	pop	hl
	push	hl
	ld	(hl), c
;main.c:304: break;
	jr	00137$
;main.c:305: case 1:
00132$:
;main.c:306: bug_y[i] += bug_dx[i];
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	ld	de, #_bug_dx
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, c
	ld	c, a
	pop	hl
	push	hl
	ld	(hl), c
;main.c:307: break;
	jr	00137$
;main.c:308: case 2:
00133$:
;main.c:309: bug_x[i] -= bug_dx[i];
	ld	de, #_bug_dx
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
	ld	a, c
	sub	a, b
	ld	c, a
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;main.c:310: break;
	jr	00137$
;main.c:311: case 3:
00134$:
;main.c:312: bug_x[i] += bug_dx[i];
	ld	de, #_bug_dx
	ldhl	sp,	#2
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, c
	ld	c, a
	ldhl	sp,	#3
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), c
;main.c:313: }
00137$:
;main.c:319: move_sprite(i+1,bug_x[i],bug_y[i]);
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#2
	ld	c, (hl)
	inc	c
	ld	b, c
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ldhl	sp,	#5
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:261: for(UINT8 i = 0; i < 4; i = i + 1){
	ldhl	sp,	#2
	ld	(hl), c
	jp	00141$
00143$:
;main.c:321: }
	add	sp, #7
	ret
;main.c:323: void bugKilled(){
;	---------------------------------
; Function bugKilled
; ---------------------------------
_bugKilled::
	add	sp, #-11
;main.c:327: for(UINT8 i = 0; i < 3; i = i + 1){
	ldhl	sp,	#0
	ld	(hl), #0x00
00128$:
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x03
	jp	NC, 00130$
;main.c:328: for(UINT8 j = 0; j < 4; j = j + 1){
	inc	hl
	xor	a, a
	ld	(hl-), a
	ld	de, #_fire_y
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	de, #_fire_x
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
00125$:
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00129$
;main.c:330: bug_respawn_location_cnt +=1;
	ld	hl, #_bug_respawn_location_cnt
	inc	(hl)
	ld	a, (hl)
;main.c:332: if(player_x >= 80 && player_y >= 64 && bug_respawn_location_cnt == 3){
	ld	a, (#_player_x)
	sub	a, #0x50
	ld	a, #0x00
	rla
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_player_y)
	sub	a, #0x40
	ld	a, #0x00
	rla
	ld	c, a
	ldhl	sp,	#10
	bit	0, (hl)
	jr	NZ, 00102$
	bit	0, c
	jr	NZ, 00102$
	ld	a, (#_bug_respawn_location_cnt)
	sub	a, #0x03
	jr	NZ, 00102$
;main.c:333: bug_respawn_location_cnt +=1;
	ld	hl, #_bug_respawn_location_cnt
	inc	(hl)
	ld	a, (hl)
00102$:
;main.c:335: if(player_x < 80 && player_y >= 64 && bug_respawn_location_cnt == 2){
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	Z, 00106$
	bit	0, c
	jr	NZ, 00106$
	ld	a, (#_bug_respawn_location_cnt)
	sub	a, #0x02
	jr	NZ, 00106$
;main.c:336: bug_respawn_location_cnt +=1;
	ld	hl, #_bug_respawn_location_cnt
	inc	(hl)
	ld	a, (hl)
00106$:
;main.c:338: if(player_x >= 80 && player_y < 64 && bug_respawn_location_cnt == 1){
	ldhl	sp,	#10
	bit	0, (hl)
	jr	NZ, 00110$
	ld	a, c
	or	a, a
	jr	Z, 00110$
	ld	a, (#_bug_respawn_location_cnt)
	dec	a
	jr	NZ, 00110$
;main.c:339: bug_respawn_location_cnt +=1;
	ld	hl, #_bug_respawn_location_cnt
	inc	(hl)
	ld	a, (hl)
00110$:
;main.c:341: if(player_x < 80 && player_y < 64 && bug_respawn_location_cnt == 0){
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	Z, 00114$
	ld	a, c
	or	a, a
	jr	Z, 00114$
	ld	hl, #_bug_respawn_location_cnt
	ld	a, (hl)
	or	a, a
	jr	NZ, 00114$
;main.c:342: bug_respawn_location_cnt +=1;
	inc	(hl)
	ld	a, (hl)
00114$:
;main.c:345: if(bug_respawn_location_cnt > 3){
	ld	a, #0x03
	ld	hl, #_bug_respawn_location_cnt
	sub	a, (hl)
	jr	NC, 00118$
;main.c:346: bug_respawn_location_cnt = 0;
	ld	(hl), #0x00
00118$:
;main.c:349: if(spriteOnSprite(bug_x[j],bug_y[j],fire_x[i],fire_y[i]) == 1){
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	de, #_bug_y
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#8
	ld	(hl), a
	ld	de, #_bug_x
	ldhl	sp,	#1
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	push	bc
	ldhl	sp,	#8
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ldhl	sp,	#10
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ldhl	sp,	#12
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_spriteOnSprite
	add	sp, #4
	pop	bc
	dec	e
	jr	NZ, 00120$
;main.c:350: bug_x[j] = bug_x_respawn[bug_respawn_location_cnt];
	ld	a, #<(_bug_x_respawn)
	ld	hl, #_bug_respawn_location_cnt
	add	a, (hl)
	ld	e, a
	ld	a, #>(_bug_x_respawn)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ldhl	sp,	#9
	push	af
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	pop	af
	ld	(hl), a
;main.c:351: bug_y[j] = bug_y_respawn[bug_respawn_location_cnt];
	ld	a, #<(_bug_y_respawn)
	ld	hl, #_bug_respawn_location_cnt
	add	a, (hl)
	ld	e, a
	ld	a, #>(_bug_y_respawn)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	(bc), a
00120$:
;main.c:353: move_sprite(j+1,bug_x[j],bug_y[j]);
	ld	a, (bc)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#1
	ld	c, (hl)
	inc	c
	ld	b, c
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ldhl	sp,	#8
	ld	a, (hl+)
	inc	hl
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:328: for(UINT8 j = 0; j < 4; j = j + 1){
	ldhl	sp,	#1
	ld	(hl), c
	jp	00125$
00129$:
;main.c:327: for(UINT8 i = 0; i < 3; i = i + 1){
	ldhl	sp,	#0
	inc	(hl)
	ld	a, (hl)
	jp	00128$
00130$:
;main.c:356: }
	add	sp, #11
	ret
;main.c:358: void respawnFuel(){
;	---------------------------------
; Function respawnFuel
; ---------------------------------
_respawnFuel::
	dec	sp
	dec	sp
;main.c:364: for(UINT8 i = 0; i < 4; i = i + 1){
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00106$
;main.c:365: fuel_x[i] = fuel_x_respawn[i];
	ld	hl, #_fuel_x
	ld	b, #0x00
	add	hl, bc
	ld	a, #<(_fuel_x_respawn)
	add	a, c
	ld	e, a
	ld	a, #>(_fuel_x_respawn)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ld	e, a
	ld	(hl), e
;main.c:366: move_sprite(i+8,fuel_x[i],fuel_y[i]);
	ld	hl, #_fuel_y
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#1
	ld	(hl), e
	ld	a, c
	add	a, #0x08
	ld	b, a
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;main.c:364: for(UINT8 i = 0; i < 4; i = i + 1){
	inc	c
	jr	00104$
00106$:
;main.c:368: }
	inc	sp
	inc	sp
	ret
;main.c:370: void updateGem(){
;	---------------------------------
; Function updateGem
; ---------------------------------
_updateGem::
;main.c:373: gem_rando_cnt += 1;
	ld	hl, #_gem_rando_cnt
	inc	(hl)
	ld	a, (hl)
;main.c:374: if(gem_rando_cnt > 7){
	ld	a, #0x07
	sub	a, (hl)
	jr	NC, 00102$
;main.c:375: gem_rando_cnt = 0;
	ld	(hl), #0x00
00102$:
;main.c:377: gem_rando_cnt = 7;
	ld	hl, #_gem_rando_cnt
	ld	(hl), #0x07
;main.c:378: if(spriteOnSprite(player_x,player_y,gem_x,gem_y) == 1){
	ld	a, (#_gem_y)
	ld	h, a
	ld	a, (#_gem_x)
	ld	l, a
	push	hl
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_spriteOnSprite
	add	sp, #4
	dec	e
	ret	NZ
;main.c:379: if(gems_collected < 255){	//I doubt anyone would do this.
	ld	hl, #_gems_collected
	ld	a, (hl)
	sub	a, #0xff
	jr	NC, 00104$
;main.c:380: gems_collected += 1;
	inc	(hl)
	ld	a, (hl)
00104$:
;main.c:382: gem_x = gem_x_list[gem_rando_cnt];
	ld	bc, #_gem_x_list+0
	ld	a, c
	ld	hl, #_gem_rando_cnt
	add	a, (hl)
	ld	c, a
	jr	NC, 00127$
	inc	b
00127$:
	ld	a, (bc)
	ld	(#_gem_x),a
;main.c:383: gem_y = gem_y_list[gem_rando_cnt];
	ld	bc, #_gem_y_list+0
	ld	a, c
	ld	hl, #_gem_rando_cnt
	add	a, (hl)
	ld	c, a
	jr	NC, 00128$
	inc	b
00128$:
	ld	a, (bc)
	ld	hl, #_gem_y
	ld	(hl), a
;main.c:384: move_sprite(12,gem_x,gem_y);
	ld	b, (hl)
	ld	hl, #_gem_x
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 48)
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	(hl), b
	inc	hl
	ld	(hl), c
;main.c:386: respawnFuel();
;main.c:388: }
	jp	_respawnFuel
;main.c:390: void playerOnBUG(){
;	---------------------------------
; Function playerOnBUG
; ---------------------------------
_playerOnBUG::
;main.c:391: for(UINT8 i = 0; i < 4; i = i + 1){
	ld	c, #0x00
00110$:
	ld	a, c
	sub	a, #0x04
	ret	NC
;main.c:392: if(spriteOnSprite(player_x,player_y,bug_x[i],bug_y[i]) == 1){
	ld	hl, #_bug_y
	ld	b, #0x00
	add	hl, bc
	ld	d, (hl)
	ld	hl, #_bug_x
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	push	bc
	push	de
	inc	sp
	push	af
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_spriteOnSprite
	add	sp, #4
	pop	bc
	dec	e
	jr	NZ, 00111$
;main.c:393: game_over = 1;
	ld	hl, #_game_over
	ld	(hl), #0x01
;main.c:395: while(game_over == 1){
00103$:
	ld	a, (#_game_over)
	dec	a
	jr	NZ, 00111$
;main.c:396: joydata = joypad();
	call	_joypad
	ld	hl, #_joydata
	ld	(hl), e
;main.c:397: if(joydata & J_START){
	ld	a, (hl)
	rlca
	jr	NC, 00102$
;main.c:398: game_over = 0;
	ld	hl, #_game_over
	ld	(hl), #0x00
00102$:
;main.c:400: resetGame();	//This bug was left on purpose.
	push	bc
	call	_resetGame
	pop	bc
	jr	00103$
00111$:
;main.c:391: for(UINT8 i = 0; i < 4; i = i + 1){
	inc	c
;main.c:404: }
	jr	00110$
;main.c:406: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
	dec	sp
;main.c:407: printf("\n Welcome to:\n GB Bugs\n\n This was made\n for the 2021\n GitHub Game Off\n\n Made by: The Dood \n\n It's not a good\n game. XD\n\n *Press start!*\n Also press start\n if you die.");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;main.c:408: while(ready_to_start == 0){
00103$:
	ld	a, (#_ready_to_start)
	or	a, a
	jr	NZ, 00105$
;main.c:409: joydata = joypad();
	call	_joypad
	ld	hl, #_joydata
	ld	(hl), e
;main.c:411: if(joydata & J_START){
	ld	a, (hl)
	rlca
	jr	NC, 00103$
;main.c:412: ready_to_start = 1;
	ld	hl, #_ready_to_start
	ld	(hl), #0x01
	jr	00103$
00105$:
;main.c:416: set_bkg_data(0,25,bug_tiles);
	ld	bc, #_bug_tiles+0
	push	bc
	ld	hl, #0x1900
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:417: set_bkg_tiles(0,0,20,18,game_map);
	ld	de, #_game_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:419: set_sprite_data(0,31,bug_tiles);
	push	bc
	ld	hl, #0x1f00
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x06
;main.c:421: move_sprite(0,player_x,player_y);
	ld	hl, #_player_y
	ld	b, (hl)
	ld	hl, #_player_x
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:423: for(UINT8 i = 0; i < 4; i = i + 1){
	ld	c, #0x00
00124$:
;main.c:424: set_sprite_tile(i+1,4);
	ld	a,c
	cp	a,#0x04
	jr	NC, 00106$
	inc	a
	ldhl	sp,	#1
	ld	(hl), a
;c:/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x04
;main.c:425: move_sprite(i+1,bug_x[i],bug_y[i]);
	ld	hl, #_bug_y
	ld	b, #0x00
	add	hl, bc
	ld	d, (hl)
	ld	hl, #_bug_x
	ld	b, #0x00
	add	hl, bc
	ld	e, (hl)
	ldhl	sp,	#1
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, d
	ld	(hl+), a
	ld	(hl), e
;main.c:423: for(UINT8 i = 0; i < 4; i = i + 1){
	ldhl	sp,	#1
	ld	c, (hl)
	jr	00124$
00106$:
;main.c:428: for(UINT8 i = 0; i < 4; i = i + 1){
	ld	c, #0x00
00127$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00107$
;main.c:429: set_sprite_tile(i+8,12);
	ldhl	sp,	#0
	ld	(hl), c
	ld	a, (hl)
	add	a, #0x08
	ld	e, a
	ld	b, e
;c:/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	ld	a, #<(_shadow_OAM)
	add	a, l
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #>(_shadow_OAM)
	adc	a, h
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	(hl), #0x0c
;main.c:430: move_sprite(i+8,fuel_x[i],fuel_y[i]);
	ld	hl, #_fuel_y
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ld	hl, #_fuel_x
	ld	b, #0x00
	add	hl, bc
	ld	c, (hl)
	ld	b, e
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	ld	l, b
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ldhl	sp,	#1
;main.c:428: for(UINT8 i = 0; i < 4; i = i + 1){
	ld	a, (hl-)
	ld	(de), a
	inc	de
	ld	a, c
	ld	(de), a
	ld	c, (hl)
	inc	c
	jr	00127$
00107$:
;c:/gbdk/include/gb/gb.h:1314: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 50)
	ld	(hl), #0x0b
;main.c:434: move_sprite(12,gem_x,gem_y);
	ld	hl, #_gem_y
	ld	c, (hl)
	ld	hl, #_gem_x
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1387: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 48)
;c:/gbdk/include/gb/gb.h:1388: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:440: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:441: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:443: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:446: while(1){
00113$:
;main.c:447: anim_cnt += 1;
	ld	hl, #_anim_cnt
	inc	(hl)
	ld	a, (hl)
;main.c:448: if(anim_cnt > 15){
	ld	a, #0x0f
	sub	a, (hl)
	jr	NC, 00109$
;main.c:449: anim_cnt = 0;
	ld	(hl), #0x00
00109$:
;main.c:451: movePlayer();
	call	_movePlayer
;main.c:452: playerSetsFire();
	call	_playerSetsFire
;main.c:453: updateFire();
	call	_updateFire
;main.c:454: playerGetsFuel();
	call	_playerGetsFuel
;main.c:455: moveBugs();
	call	_moveBugs
;main.c:456: bugKilled();
	call	_bugKilled
;main.c:457: updateGem();
	call	_updateGem
;main.c:458: playerOnBUG();
	call	_playerOnBUG
;main.c:459: UBYTE thing = spriteOnSprite(player_x,player_y,bug_x[0],bug_y[0]);
	ld	a, (#_bug_y + 0)
	ld	hl, #_bug_x
	ld	b, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	ld	a, (#_player_y)
	ld	h, a
	ld	a, (#_player_x)
	ld	l, a
	push	hl
	call	_spriteOnSprite
	add	sp, #4
;main.c:460: if(game_over == 1){
	ld	a, (#_game_over)
	dec	a
	jr	NZ, 00111$
;main.c:461: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;main.c:462: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;main.c:463: DISPLAY_OFF;
	call	_display_off
;main.c:464: printf("waka waka");
	ld	de, #___str_1
	push	de
	call	_printf
	pop	hl
00111$:
;main.c:467: performantDelay(7);
	ld	a, #0x07
	push	af
	inc	sp
	call	_performantDelay
	inc	sp
	jr	00113$
;main.c:469: }
	inc	sp
	inc	sp
	ret
___str_0:
	.db 0x0a
	.ascii " Welcome to:"
	.db 0x0a
	.ascii " GB Bugs"
	.db 0x0a
	.db 0x0a
	.ascii " This was made"
	.db 0x0a
	.ascii " for the 2021"
	.db 0x0a
	.ascii " GitHub Game Off"
	.db 0x0a
	.db 0x0a
	.ascii " Made by: The Dood "
	.db 0x0a
	.db 0x0a
	.ascii " It's not a good"
	.db 0x0a
	.ascii " game. XD"
	.db 0x0a
	.db 0x0a
	.ascii " *Press start!*"
	.db 0x0a
	.ascii " Also press start"
	.db 0x0a
	.ascii " if you die."
	.db 0x00
___str_1:
	.ascii "waka waka"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__bug_tiles:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x24	; 36
	.db #0xbd	; 189
	.db #0x00	; 0
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x42	; 66	'B'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0xc9	; 201
	.db #0x10	; 16
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x10	; 16
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0xc9	; 201
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x93	; 147
	.db #0x08	; 8
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x08	; 8
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x93	; 147
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xbc	; 188
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3d	; 61
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xbc	; 188
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x48	; 72	'H'
	.db #0x48	; 72	'H'
	.db #0x1a	; 26
	.db #0x1a	; 26
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x7e	; 126
	.db #0x4e	; 78	'N'
	.db #0x7e	; 126
	.db #0x46	; 70	'F'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x20	; 32
	.db #0x00	; 0
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x58	; 88	'X'
	.db #0x00	; 0
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x72	; 114	'r'
	.db #0x0c	; 12
	.db #0x62	; 98	'b'
	.db #0x1c	; 28
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0xbd	; 189
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x24	; 36
	.db #0x2c	; 44
	.db #0x42	; 66	'B'
	.db #0x4e	; 78	'N'
	.db #0x81	; 129
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0xff	; 255
	.db #0x4e	; 78	'N'
	.db #0x7e	; 126
	.db #0x2c	; 44
	.db #0x3c	; 60
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x9e	; 158
	.db #0x9e	; 158
	.db #0x9e	; 158
	.db #0x92	; 146
	.db #0x1e	; 30
	.db #0x16	; 22
	.db #0x1e	; 30
	.db #0x12	; 18
	.db #0x1e	; 30
	.db #0x16	; 22
	.db #0x1e	; 30
	.db #0x16	; 22
	.db #0x1e	; 30
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x3e	; 62
	.db #0x3e	; 62
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x7c	; 124
	.db #0x7c	; 124
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x62	; 98	'b'
	.db #0x34	; 52	'4'
	.db #0x34	; 52	'4'
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0x18	; 24
__xinit__game_map:
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x11	; 17
	.db #0x15	; 21
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x12	; 18
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
	.db #0x0a	; 10
__xinit__button_pressed:
	.db #0x00	; 0
__xinit__A_button_pressed:
	.db #0x00	; 0
__xinit__bug_rando_cnt:
	.db #0x00	; 0
__xinit__gem_rando_cnt:
	.db #0x00	; 0
__xinit__anim_cnt:
	.db #0x00	; 0
__xinit__ready_to_start:
	.db #0x00	; 0
__xinit__game_over:
	.db #0x00	; 0
__xinit__player_x:
	.db #0x50	; 80	'P'
__xinit__player_y:
	.db #0x38	; 56	'8'
__xinit__player_dx:
	.db #0x02	; 2
__xinit__player_dy:
	.db #0x02	; 2
__xinit__player_d:
	.db #0x00	; 0
__xinit__player_fuel:
	.db #0x03	; 3
__xinit__player_max_fuel:
	.db #0x03	; 3
__xinit__fire_x:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__fire_y:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__fire_cnt:
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
__xinit__fuel_x:
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x80	; 128
	.db #0x80	; 128
__xinit__fuel_y:
	.db #0x28	; 40
	.db #0x60	; 96
	.db #0x28	; 40
	.db #0x60	; 96
__xinit__fuel_icon_x:
	.db #0x38	; 56	'8'
	.db #0x40	; 64
	.db #0x48	; 72	'H'
__xinit__fuel_icon_y:
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0x88	; 136
__xinit__gem_x_list:
	.db #0x40	; 64
	.db #0x98	; 152
	.db #0x18	; 24
	.db #0x58	; 88	'X'
	.db #0x50	; 80	'P'
	.db #0x90	; 144
	.db #0x10	; 16
	.db #0x68	; 104	'h'
__xinit__gem_y_list:
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x38	; 56	'8'
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
__xinit__gem_x:
	.db #0x10	; 16
__xinit__gem_y:
	.db #0x20	; 32
__xinit__gems_collected:
	.db #0x00	; 0
__xinit__bug_respawn_location_cnt:
	.db #0x00	; 0
__xinit__bug_x:
	.db #0x10	; 16
	.db #0x98	; 152
	.db #0x10	; 16
	.db #0x98	; 152
__xinit__bug_y:
	.db #0x18	; 24
	.db #0x18	; 24
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
__xinit__bug_dx:
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
__xinit__bug_d:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__bug_status:
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.area _CABS (ABS)
