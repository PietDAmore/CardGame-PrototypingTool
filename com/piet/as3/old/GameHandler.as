import flash.display.Sprite;

// GameHandler

function startGame(): void {

	mc_startscreen.visible = false;
	mc_sound.gotoAndPlay("start");

	createNewGame();
	createNewPlayer();

	trace("startGame");

}

function createNewGame(): void {

	game_update = true;

	createNewLevel();
	createGuiBar();

	trace("createNewGame");
}

function restartGame(): void {

	//destroyGuiBar();

	while (tiles_container.numChildren > 0) {
		tiles_container.removeChildAt(0);
	}

	while (enemy_container.numChildren > 0) {
		enemy_container.removeChildAt(0);
	}
	
	/*
	if (player != null) {
		player.parent.removeChild(player);
	}
	*/
	
	player.x = player_start_x;
	player.y = player_start_y;
	
	double_check_pressed = 0;
	double_check_cnt = 0;

	game_update == false;

	time_framecount = 0;

	tiles_amount = 0;
	tiles_amount_x = 0;
	tiles_amount_y = 0;
	tiles_build_process = true;

	new_tile_x = tiles_start_x;
	new_tile_y = tiles_start_y;
	
	wallarray.splice(0);
	block_array.splice(0);
	cover_array.splice(0);
	northwalk_array.splice(0);
	enemy_array.splice(0);
	
	player_location = 0;
	player_action = "idle";

	player_speed = player_speed_init;
	player_move_direction = "top";

	player_walknorth = true;

	player_stand_delay = player_stand_delay_init;

	player_duck = false;
	firstshot = false;
	walkkeys_pushed = false;

	anim_shoot = false;

	count_viewBullets = 0;
	viewBulletVar = false;
	waypoint_waiting = false;
	
	destroyGroundPoints();
	//createGuiBar();
	createNewLevel();
	
}

