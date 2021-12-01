#include <gb/gb.h>
#include <stdio.h> 
#include <stdint.h> 
#include "bug_tiles.c"
#include "game_map.c"
//I am not a pro. I am new GBDK and C. My time was very limited, so this is what I could muster while having fun while making it.

//#include "window_map.c"
UINT8 joydata;
UINT8 centered;	//used to tell if a sprite is centered
UINT8 button_pressed = 0;
UINT8 A_button_pressed = 0;
UINT8 const rando[] = {0,1,2,3,4,5,6,7,8,9,10};	//
UINT8 bug_rando_cnt = 0;	//reset at n>10
UINT8 gem_rando_cnt = 0;	//reset at n>10
UINT8 anim_cnt = 0;	//reset at n>15
UBYTE ready_to_start = 0;
UBYTE game_over = 0;
//playable map is 1-18,1-12
const unsigned char floor = 0;
const unsigned char wall = 10;

//player init
UINT8 player_x=80;
UINT8 player_y=56;
UINT8 player_dx=2;
UINT8 player_dy=2;		//yeah, I don't need this now, but I have an idea for this later.
UINT8 player_d=0;
UINT8 player_fuel=3;
UINT8 player_max_fuel=3;

//fire
UINT8 fire_x[] = {0,0,0};
UINT8 fire_y[] = {0,0,0};
UINT8 const fire_max_cnt = 50;
UINT8 fire_cnt[] = {50,50,50};


//objects to collect
	//fuel
UINT8 const fuel_x_respawn[] = {40,40,128,128};
UINT8 fuel_x[] = {40,40,128,128};
UINT8 fuel_y[] = {40,96,40,96};
//fuel icon
UINT8 const fuel_icon_x_respawn[] = {56,64,72};
UINT8 fuel_icon_x[] = {56,64,72};
UINT8 fuel_icon_y[] = {136,136,136};


	//gem
UINT8 gem_x_list[] = {64,152,24,88,80,144,16,104};
UINT8 gem_y_list[] = {24,24,56,56,80,80,112,112};
UINT8 gem_x = 16;
UINT8 gem_y = 24+8;
UINT8 gems_collected = 0;

//bug init
UINT8 const bug_x_respawn[] = {16,152,16,152};
UINT8 const bug_y_respawn[] = {24,24,112,112};
UINT8 bug_respawn_location_cnt = 0; //0 to 3
UINT8 bug_x[] = {16,152,16,152};
UINT8 bug_y[] = {24,24,112,112};
UINT8 bug_dx[] = {1,1,1,1};	//
UINT8 bug_d[] = {0,0,0,0};
UINT8 bug_status[] = {1,1,1,1}; //dead=0, alive=1

void performantDelay(UINT8 numloops)
{
    UINT8 i;
    for (i = 0; i < numloops; i++)
    {
        wait_vbl_done();
    }
}

UBYTE centeredOnTile(UINT8 spriteX, UINT8 spriteY){
	UINT8 ready;
	ready = (spriteX%8)+(spriteY%8);
	return ready;
}

UBYTE obstruction(UINT8 spriteX, UINT8 spriteY, UINT8 spriteD){
	//spriteD 0,1,2,3 -> u,d,l,r
	//collision origin of sprite is top left corner, so that's why:
	INT8 dx = 0;
	INT8 dy = 0;
	if(spriteD == 0){
		dy = -1;	//<- this...
	}
	if(spriteD == 1){
		dy = 8;		//<- this...
	}
	if(spriteD == 2){
		dx = -1;	//<- this...
	}
	if(spriteD == 3){
		dx = 8;		//<- this...
	}
	if(game_map[((spriteX-8+dx)/8)+(((spriteY-16+dy)/8)*20)] == wall){
		return 1;
	}
	else{
		return 0;
	}
}

UBYTE spriteOnSprite(UINT8 x_1,UINT8 y_1,UINT8 x_2,UINT8 y_2){
	if(x_1 >= x_2 && y_1 >= y_2 && x_1 <= x_2+7 && y_1 <= y_2+7 || x_2 >= x_1 && y_2 >= y_1 && x_2 <= x_1+7 && y_2 <= y_1+7){
		return 1;
	}
	else{
		return 0;
	}
}

void resetGame(){
	//player
	player_x=80;
	player_y=56;
	//bugs
	for(UINT8 i = 0; i < 4; i = i + 1){
		bug_x[i] = bug_x_respawn[i];
		bug_y[i] = bug_y_respawn[i];
		move_sprite(i+1,bug_x[i],bug_y[i]);
	}
	//fuel
	for(UINT8 i = 0; i < 4; i = i + 1){
		fuel_x[i] = fuel_x_respawn[i];
		move_sprite(i+8,fuel_x[i],fuel_y[i]);
	}
	//gems
	gem_rando_cnt += 1;
	if(gem_rando_cnt > 7){
		gem_rando_cnt = 0;
	}
	gem_x = gem_x_list[gem_rando_cnt];
	gem_y = gem_y_list[gem_rando_cnt];
	move_sprite(12,gem_x,gem_y);
}

void movePlayer(){
	centered = centeredOnTile(player_x,player_y);
	joydata = joypad();
	if(centered == 0){
		button_pressed = 0;
	}
    if(joydata & J_LEFT && centered == 0 && button_pressed == 0){
		player_d = 2;
		if(obstruction(player_x,player_y,player_d) == 0){
			player_x -= player_dx;	//important nudge to make player not centered
			button_pressed = 1;
			//move_sprite(0,player_x,player_y);
		}
	}
	if(joydata & J_RIGHT && centered == 0 && button_pressed == 0){
		player_d = 3;
		if(obstruction(player_x,player_y,player_d) == 0){
			player_x += player_dx;
			button_pressed = 1;
			//move_sprite(0,player_x,player_y);
		}
	}
	if(joydata & J_UP && centered == 0 && button_pressed == 0){
		player_d = 0;
		if(obstruction(player_x,player_y,player_d) == 0){
			player_y -= player_dy;
			button_pressed = 1;
			//move_sprite(0,player_x,player_y);
		}
	}
	if(joydata & J_DOWN && centered == 0 && button_pressed == 0){
		player_d = 1;
		if(obstruction(player_x,player_y,player_d) == 0){
			player_y += player_dy;
			button_pressed = 1;
			//move_sprite(0,player_x,player_y);
		}
	}
	if(obstruction(player_x,player_y,player_d) == 0 && centered != 0){
		switch(player_d){
			case 0:
			player_y -= player_dy;
			break;
			case 1:
			player_y += player_dy;
			break;
			case 2:
			player_x -= player_dx;
			break;
			case 3:
			player_x += player_dx;
		}
	}
	move_sprite(0,player_x,player_y);
}

void playerSetsFire(){
	/* UINT8 fire_x[] = {0,0,0};
	UINT8 fire_y[] = {0,0,0};
	UINT8 const fire_max_cnt = 50;
	UINT8 fire_cnt[] = {50,0,0}; */
	joydata = joypad();
	//J_A
	if(joydata | J_A && A_button_pressed == 1){
		A_button_pressed = 0;
	}
	if(joydata & J_A && A_button_pressed == 0){
		A_button_pressed = 1;
		UBYTE fire_placed = 0;
		//check if player is touching fire
		UBYTE player_on_fire = 0;
		for(UINT8 i = 0; i < 3; i = i + 1){
			if(spriteOnSprite(player_x,player_y,fire_x[i],fire_y[i]) == 1){
				player_on_fire = 1;
			}
		}
		for(UINT8 i = 0; i < 3; i = i + 1){
			if(player_on_fire == 0 && fire_cnt[i] == fire_max_cnt && fire_placed == 0){
				fire_placed =1;
				fire_x[i] = player_x;
				fire_y[i] = player_y;
				set_sprite_tile(5+i,8);
				move_sprite(5+i,fire_x[i],fire_y[i]);
			}
		}
	}
} 

void updateFire(){
	for(UINT8 i = 0; i < 3; i = i + 1){
		if(fire_x[i] > 0){
			if(fire_cnt[i] != 0){
				fire_cnt[i] -= 1;
			}
		}
		if(fire_cnt[i] <= 0){
				fire_x[i] = 0;
				move_sprite(5+i,fire_x[i],fire_y[i]);
			}
	}
}

void playerGetsFuel(){
/* //objects to collect
	//fuel
UINT8 const fuel_x_respawn[] = {56,56,144,144};
UINT8 fuel_x[] = {40,40,128,128};
UINT8 fuel_y[] = {40,96,40,96};UINT8 fuel_full[] = {12,12,12,12};	//set to 0 when empty */
	for(UINT8 i = 0; i < 4; i = i + 1){
		if(spriteOnSprite(player_x,player_y,fuel_x[i],fuel_y[i]) == 1){
			fuel_x[i] = 0;
			move_sprite(i+8,fuel_x[i],fuel_y[i]);
			for(UINT8 j = 0; j < 3; j = j + 1){
				fire_cnt[j] = 50;
			}
		}
	}
}

void moveBugs(){
	for(UINT8 i = 0; i < 4; i = i + 1){
		bug_rando_cnt +=1;
		if(bug_rando_cnt>10){
			bug_rando_cnt=0;
		}
		centered = centeredOnTile(bug_x[i],bug_y[i]);
		if(centered == 0 && bug_rando_cnt < 7){	//nudge in direction. "bug_rando_cnt < 7" makes it where the bugs don't all move at the same pace.
			//chasers set d
			if(i < 4){	
				if(player_x > bug_x[i]){
					bug_d[i] = 3;	//right
					if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
						bug_x[i] += bug_dx[i];
						centered = 1;
					}
				}
				if(player_x < bug_x[i] && centered == 0){
					bug_d[i] = 2;	//left
					if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
						bug_x[i] -= bug_dx[i];
						centered = 1;
					}
				}
				if(player_y > bug_y[i] && centered == 0){
					bug_d[i] = 1;	//down
					if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
						bug_y[i] += bug_dx[i];
						centered = 1;
					}
				}
				if(player_y < bug_y[i] && centered == 0){
					bug_d[i] = 0;	//up
					if(obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0 || bug_rando_cnt == 0){
						bug_y[i] -= bug_dx[i];
						centered = 1;
					}
				}
			}
		}
		if(centered != 0){ //&& obstruction(bug_x[i],bug_y[i],bug_d[i]) == 0){
			switch(bug_d[i]){
				case 0:
				bug_y[i] -= bug_dx[i];
				break;
				case 1:
				bug_y[i] += bug_dx[i];
				break;
				case 2:
				bug_x[i] -= bug_dx[i];
				break;
				case 3:
				bug_x[i] += bug_dx[i];
			}
		}
		
		//rando-walk

		//move all bug sprites
		move_sprite(i+1,bug_x[i],bug_y[i]);
	}
}

void bugKilled(){
/* UINT8 const bug_x_respawn[] = {16,152,16,152};
UINT8 const bug_y_respawn[] = {24,24,112,112};
UINT8 bug_respawn_location_cnt = 0; //0 to 3 */
	for(UINT8 i = 0; i < 3; i = i + 1){
		for(UINT8 j = 0; j < 4; j = j + 1){
			//
			bug_respawn_location_cnt +=1;
			//
			if(player_x >= 80 && player_y >= 64 && bug_respawn_location_cnt == 3){
				bug_respawn_location_cnt +=1;
			}
			if(player_x < 80 && player_y >= 64 && bug_respawn_location_cnt == 2){
				bug_respawn_location_cnt +=1;
			}
			if(player_x >= 80 && player_y < 64 && bug_respawn_location_cnt == 1){
				bug_respawn_location_cnt +=1;
			}
			if(player_x < 80 && player_y < 64 && bug_respawn_location_cnt == 0){
				bug_respawn_location_cnt +=1;
			}
			//
			if(bug_respawn_location_cnt > 3){
				bug_respawn_location_cnt = 0;
			}
			//
			if(spriteOnSprite(bug_x[j],bug_y[j],fire_x[i],fire_y[i]) == 1){
				bug_x[j] = bug_x_respawn[bug_respawn_location_cnt];
				bug_y[j] = bug_y_respawn[bug_respawn_location_cnt];
			}
			move_sprite(j+1,bug_x[j],bug_y[j]);
		}
	}
}

void respawnFuel(){
/* //objects to collect
	//fuel
UINT8 const fuel_x_respawn[] = ;
UINT8 fuel_x[] = {40,40,128,128};
UINT8 fuel_y[] = {40,96,40,96}; */
	for(UINT8 i = 0; i < 4; i = i + 1){
		fuel_x[i] = fuel_x_respawn[i];
		move_sprite(i+8,fuel_x[i],fuel_y[i]);
	}
}

void updateGem(){
//UINT8 gem_x_list[] = {72,160,32,96,168,152,24,112};
//UINT8 gem_y_list[] = {32,32,64,64,88,88,120,120};
	gem_rando_cnt += 1;
	if(gem_rando_cnt > 7){
		gem_rando_cnt = 0;
	}
	gem_rando_cnt = 7;
	if(spriteOnSprite(player_x,player_y,gem_x,gem_y) == 1){
		if(gems_collected < 255){	//I doubt anyone would do this.
			gems_collected += 1;
		}
		gem_x = gem_x_list[gem_rando_cnt];
		gem_y = gem_y_list[gem_rando_cnt];
		move_sprite(12,gem_x,gem_y);
		//respawn all fuel tanks
		respawnFuel();
	}
}

void playerOnBUG(){
	for(UINT8 i = 0; i < 4; i = i + 1){
		if(spriteOnSprite(player_x,player_y,bug_x[i],bug_y[i]) == 1){
			game_over = 1;
			/////
			while(game_over == 1){
				joydata = joypad();
				if(joydata & J_START){
					game_over = 0;
				}
				resetGame();	//This bug was left on purpose.
			}
		}
	}
}

void main(){
	printf("\n Welcome to:\n GB Bugs\n\n This was made\n for the 2021\n GitHub Game Off\n\n Made by: The Dood \n\n It's not a good\n game. XD\n\n *Press start!*\n Also press start\n if you die.");
	while(ready_to_start == 0){
	joydata = joypad();
	
	if(joydata & J_START){
	ready_to_start = 1;
	}
}
	
	set_bkg_data(0,25,bug_tiles);
	set_bkg_tiles(0,0,20,18,game_map);
	
	set_sprite_data(0,31,bug_tiles);
	set_sprite_tile(0,6);	//player sprite
	move_sprite(0,player_x,player_y);
	
	for(UINT8 i = 0; i < 4; i = i + 1){
		set_sprite_tile(i+1,4);
		move_sprite(i+1,bug_x[i],bug_y[i]);
	}
	
	for(UINT8 i = 0; i < 4; i = i + 1){
		set_sprite_tile(i+8,12);
		move_sprite(i+8,fuel_x[i],fuel_y[i]);
	}
	
	set_sprite_tile(12,11);
	move_sprite(12,gem_x,gem_y);
	
	
	//set_win_tiles(0,0,20,4,window_map);
	//move_win(7,120);
	
	SHOW_SPRITES;
	SHOW_BKG;
	//SHOW_WIN;
	DISPLAY_ON;
	
	
	while(1){
		anim_cnt += 1;
		if(anim_cnt > 15){
				anim_cnt = 0;
		}
		movePlayer();
		playerSetsFire();
		updateFire();
		playerGetsFuel();
		moveBugs();
		bugKilled();
		updateGem();
		playerOnBUG();
		UBYTE thing = spriteOnSprite(player_x,player_y,bug_x[0],bug_y[0]);
		if(game_over == 1){
			HIDE_SPRITES;
			HIDE_BKG;
			DISPLAY_OFF;
			printf("waka waka");
		}
	
        performantDelay(7);
    }
}

