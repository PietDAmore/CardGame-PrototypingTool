import flash.display.MovieClip;

// PlayerHandler

function createNewPlayer(): void {

	trace("Hero created!");

	var mc_player: MovieClip = new Player();
	addChild(mc_player);
	player = mc_player;

	switchPlayerState("idle");

	player_move_direction = "right";

	// starting point
	mc_player.x = player_start_x;
	mc_player.y = player_start_y;

	double_check_cnt = 0;

	createPlayerSight();

	mc_player.stop();

	mc_player.addEventListener(Event.ENTER_FRAME, playerUpdate);

}


function playerUpdate(e): void {

	if (e.currentTarget.currentFrame == 16) {

		createNewBullet(player.x, player.y, "top");

		e.currentTarget.gotoAndPlay(e.currentTarget.currentFrame + 1);

	}

	if (player_walknorth == true) {

		if (player_action == "shoot") {

			if (e.currentTarget.currentFrame == 20) {

				walkkeys_pushed = false;
				e.currentTarget.gotoAndStop("run_north");

				return;

			}

			if (player_walknorth_shoot == false) {

				player_walknorth_shoot = true;
				e.currentTarget.gotoAndPlay(15);

				return;

			}

		}

		if (player_walknorth_shoot == false) {
			e.currentTarget.gotoAndStop("run_north");
		}

		playerWalkNorth();

		return;

	}

	// roll

	if (player_action == "roll") {

		e.currentTarget.gotoAndStop("roll");
		e.currentTarget.rollAnimation.play();

		checkWallForCover(e.currentTarget);

		if (e.currentTarget.rollAnimation.currentFrame == e.currentTarget.rollAnimation.totalFrames) {
			e.currentTarget.rollAnimation.gotoAndStop(1);

			double_check_pressed = 0;
			double_check_cnt = 0;

			switchPlayerState("idle");

			return;
		}

		if (player_move_direction == "left") {

			if (e.currentTarget.x > screenend_left) {

				checkBlock(e, "left");

				e.currentTarget.x -= player_rollspeed;
				e.currentTarget.scaleX = 1;
			}
		}

		if (player_move_direction == "right") {

			if (e.currentTarget.x < screenend_right) {

				checkBlock(e, "right");

				e.currentTarget.x += player_rollspeed;
				e.currentTarget.scaleX = -1;
			}
		}

	}


	player_roll_check();

	if (player_action == "idle") {

		checkNorthWalk(e);
		checkWallWithPlayer(e.currentTarget, player_move_direction);

		// ******

		if (player_duck == true) {

			if (e.currentTarget.currentFrame > 1) {

				// trace("enter duck stance");
				e.currentTarget.gotoAndStop(1);
			}

		} else {

			// trace("enter idle stance");
			e.currentTarget.gotoAndStop("idle_stand");

		}

	}

	if (player_action == "shoot") {

		// wait while standing
		if (player_stand_delay == 0) {

			if (player_duck == true) {

				e.currentTarget.gotoAndPlay("return_to_idle");

			} else {

				if (player_walknorth == false) {

					e.currentTarget.gotoAndStop("idle_stand");

				}

			}

			player_stand_delay = player_stand_delay_init;


		} else {

			player_stand_delay -= 1;

		}

		// shoot mechanic
		if (anim_shoot == true) {

			if (firstshot == false) {

				// 2nd shot while standing
				e.currentTarget.gotoAndPlay(15);
				anim_shoot = false;
				firstshot = true;

			} else {

				if (player_walknorth_shoot == false) {
					e.currentTarget.gotoAndPlay("shoot");
					anim_shoot = false;
				} else {
					//
					player_stand_delay = 0;
				}

			}

		}

		if (e.currentTarget.currentFrame > 25) {

			switchPlayerState("idle");
			player_action = "idle";
			player_walknorth_shoot = false;

		}

	}

	if (player_action == "shoot_side") {

		// wait while standing
		if (player_stand_delay == 0) {

			if (player_duck == true) {

				e.currentTarget.gotoAndPlay("return_to_idle");

			} else {

				if (player_walknorth == false) {

					e.currentTarget.gotoAndStop("idle_stand");

				}

			}

			player_stand_delay = player_stand_delay_init;


		} else {

			player_stand_delay -= 1;

		}

		// shoot mechanic
		if (anim_shoot == true) {

			e.currentTarget.gotoAndStop("shoot_side");

			if (firstshot == false) {

				// 2nd shot while standing
				e.currentTarget.mc_shoot.gotoAndPlay(4);

				createNewBullet(player.x, player.y, player_move_direction);

				anim_shoot = false;
				firstshot = true;

			} else {

				if (player_walknorth_shoot == false) {
					e.currentTarget.mc_shoot.gotoAndPlay(1);

					createNewBullet(player.x, player.y, player_move_direction);

					anim_shoot = false;

				} else {

					player_stand_delay = 0;
				}

			}

		}

		if (e.currentTarget.mc_shoot.currentFrame > 16) {

			switchPlayerState("idle");
			player_action = "idle";
			player_walknorth_shoot = false;

		}

	}

	if (player_action == "walk") {

		checkNorthWalk(e);
		checkWallForCover(e.currentTarget);
		checkWallWithPlayer(e.currentTarget, "left");

		firstshot = true;

		if (player_duck == true) {

			e.currentTarget.gotoAndStop("duck_walk");
			player_speed_init = 3;

		} else {

			e.currentTarget.gotoAndPlay("run");
			player_speed_init = 5;

		}

		if (player_move_direction == "left") {

			if (e.currentTarget.x > screenend_left) { // screen boundries

				checkBlock(e, "left");

				e.currentTarget.x -= player_speed;
				player_pos_x -= player_speed;
				walkSpeedModifier();

				e.currentTarget.scaleX = 1;
			}

		}

		if (player_move_direction == "right") {

			if (e.currentTarget.x < screenend_right) { // screen boundries

				checkBlock(e, "right");

				e.currentTarget.x += player_speed;
				player_pos_x += player_speed;
				walkSpeedModifier();

				e.currentTarget.scaleX = -1;
			}
		}


	}

}

function checkNorthWalk(e): void {

	for (var i = 0; i < northwalk_array.length; i++) {

		// Touch the Northwalk Arrows
		if (e.currentTarget.collider.hitTestObject(northwalk_array[i])) {

			// let arrow disappear
			northwalk_array[i].gotoAndStop(1);

			if (player_walknorth == false) {

				trace("nortwalk activated");

				player_walknorth = true;
				removeWaypointLeft();

				var mc_arrowAnim = new animNorthArrow();
				addChild(mc_arrowAnim);

				mc_arrowAnim.x = northwalk_array[i].x + mc_arrowAnim.width;
				mc_arrowAnim.y = northwalk_array[i].y + mc_arrowAnim.height;

				mc_arrowAnim.addEventListener(Event.ENTER_FRAME, northArrowAnim);

			}

			e.currentTarget.x = northwalk_array[i].x + 32;

		}
	}

}

function playerWalkNorth(): void {

	var didCollide: Boolean = checkBlockWithPlayer(player, "top");

	if (didCollide) {

		// player stop on wall
		player_walknorth = false;
		switchPlayerState("idle");

	} else {

		if (player.y > 16) {

			player.y -= player_speed_north;

		}

	}

}

// BLOCK

var block_collided;

function checkBlock(e, direction): Boolean {

	return checkBlockWithPlayer(e.currentTarget, direction);

}

function checkBlockWithPlayer(pl, direction): Boolean {

	// Collision with blocks

	var cnt_block = 0;

	for (var i = 0; i < block_array.length; i++) {

		if (pl.collider.hitTestObject(block_array[i].block_right)) {

			// block hit

			if (direction == "left" && cnt_block == 0) {

				trace("checkBlock hit left");

				cnt_block++;

				pl.x = block_array[i].x + block_array[i].width + pl.collider.width / 2;

				return true;
			}
		}

		if (pl.collider.hitTestObject(block_array[i].block_left)) {

			if (direction == "right" && cnt_block == 0) {

				trace("checkBlock hit right");

				cnt_block++;

				pl.x = block_array[i].x - pl.collider.width;

				return true;
			}
		}

		if (pl.collider.hitTestObject(block_array[i].block_down)) {

			// block north
			if (direction == "top" && cnt_block == 0) {

				// trace("block hit north");

				cnt_block++;

				pl.y = block_array[i].y + pl.collider.height + player_speed;

				block_collided = block_array[i];

				return true;
			}
		}

	}

	return false;

}

// WALL

var wall_collided;

function checkWall(e, direction): Boolean {

	return checkWallWithPlayer(e.currentTarget, direction);

}

function checkWallWithPlayer(pl, direction): Boolean {

	// Conctact with walls

	for (var i = 0; i < wallarray.length; i++) {

		if (wallarray[i].door_open == true) {

			if (wallarray[i].door_cnt >= 20) {

				if (wallarray[i].door_cnt == 0) {

					trace("go through level");

					level_nmbr++;
					gotoNextLevel();
				}

				wallarray[i].door_cnt--;
			}

		}

		if (pl.hitTestObject(wallarray[i])) {

			if (wallarray[i].door == true) {

				// door contanct
				trace("touched a door");

				var door_animation: MovieClip = new animDoor();
				tiles_container.addChild(door_animation);

				door_animation.x = wallarray[i].x + wallarray[i].width / 2;
				door_animation.y = wallarray[i].y + wallarray[i].height;
				door_animation.addEventListener(Event.ENTER_FRAME, doorUpdate);
				door_animation.addEventListener(Event.ENTER_FRAME, StopAnimationAtEnd);

				wallarray[i].door = false;
				wallarray[i].door_cnt = 20;
				wallarray[i].door_open = true;

				mc_sound.gotoAndPlay("door");

				player_action = "walk";
				player_move_direction = "top";


			}

			return true;

		}

	}

	return false;

}

function checkCover(e): Boolean {
	return checkWallForCover(e.currentTarget);
}

function checkWallForCover(pl): Boolean {

	// Collision with cover
	var cnt = 0;
	for (var i = 0; i < cover_array.length; i++) {

		if (pl.hitTestObject(cover_array[i].cover)) {

			//trace("cover contact");

			if (player_duck != true) {

				cover_array[i].alpha = 0.5;

			}
			cnt++;
		}
	}
	if (cnt > 0) {
		player_duck = true;
	} else {
		player_duck = false;
	}
	return false;
}

// ENEMY COLLIDE

var enemy_collided;

function checkEnemy(e, direction): Boolean {

	return checkEnemyWithPlayer(e.currentTarget, direction);

}

function checkEnemyWithPlayer(pl, direction): Boolean {

	// Collision with enemies

	var cnt_enemy = 0;

	for (var i = 0; i < enemy_array.length; i++) {

		if (enemy_array[i].alive == false) {

			cnt_enemy = 0;
			return false;
		}

		if (pl.hitTestObject(enemy_array[i].collider)) {

			if (direction == "left" && cnt_enemy == 0) {

				trace("object hits enemy on the left");
				cnt_enemy++;

				pl.x = enemy_array[i].x + enemy_array[i].width + pl.collider.width / 2;

				return true;
			}
		}

		if (pl.hitTestObject(enemy_array[i].collider)) {

			if (direction == "right" && cnt_enemy == 0) {

				trace("object hits enemy on the right");
				cnt_enemy++;

				pl.x = enemy_array[i].x - pl.collider.width;

				return true;
			}
		}
		/*
		if (pl.hitTestObject(enemy_array[i].collider)) {

			if (direction == "top" && cnt_enemy == 0) {

				cnt_enemy++;

				pl.y = enemy_array[i].y + pl.collider.height + player_speed;

				enemy_collided = enemy_array[i];

				return true;
			}
		}
		*/

	}

	return false;

}

// ------------------------


function switchPlayerState(targetState) {

	if (player_action != "shoot") {
		player_action = "idle";
		player_speed = player_speed_init;
		player_walknorth_shoot = false;
	}

}


function shoot(): void {
	
	// enemy is near when shoot button pressed
	if (side_shooting_trigger == true) {
		
		shoot_side();
		return;
	}
	
	player_action = "shoot";
	anim_shoot = true;
	player_stand_delay = player_stand_delay_init;
}

function shoot_side(): void {

	player_action = "shoot_side";
	anim_shoot = true;
	player_stand_delay = player_stand_delay_init;
	
	side_shooting_trigger = false;

}

function walkSpeedModifier(): void {

	if (player_speed < player_speed_max) {
		player_speed += 0.1;
	}

}

function player_roll(): void {

	if (player_action != "roll") {
		player_action = "roll";
	}

}

function player_roll_check(): void {

	if (double_check_pressed > 0) {
		if (double_check_cnt >= 4) {

			double_check_pressed = 0;
			double_check_cnt = 0;

		} else {

			double_check_cnt++

		}
	}

}

function player_roll_input(): void {

	if (double_check_pressed == 2) {

		return;

	}

	if (double_check_pressed == 1) {

		double_check_pressed = 2;

		trace("player_roll()");

		player_roll();

		return;
	}

	if (double_check_pressed == 0) {

		double_check_pressed = 1;
		double_check_cnt = 0;

	}

}

function playerDie(): void {

	trace("You died");

	mc_sound.gotoAndPlay("die");

	restartGame();

}


// SIGHT HANDLER

function createPlayerSight(): void {

	var mc_sight: MovieClip = new Sight();
	addChild(mc_sight);
	mc_sight.width = 256;

	mc_sight.addEventListener(Event.ENTER_FRAME, sightUpdate);

}

function sightUpdate(e): void {

	if (player_walknorth == true) {

		enemy_seen = false;
		side_shooting_trigger = false;
		return;
	}

	if (cheat_sight == false) {
		e.currentTarget.alpha = 0;
	} else {
		e.currentTarget.alpha = 1;
	}

	e.currentTarget.x = player.x;
	e.currentTarget.y = player.y + e.currentTarget.height;

	var cnt_enemy = 0;

	for (var i = 0; i < enemy_array.length; i++) {

		if (enemy_array[i].alive == false) {

			enemy_seen = false;
			cnt_enemy = 0;
			return;
		}

		if (e.currentTarget.hitTestObject(enemy_array[i].collider)) {
			
			// trace("side_shooting_trigger: " + side_shooting_trigger);
			
			if (player.x > enemy_array[i].x) {
				
				player_move_direction = "left";
				player.scaleX = 1;
				
			} else {
				
				player_move_direction = "right";
				player.scaleX = -1;
				
			}

			enemy_seen = true;
			side_shooting_trigger = true;
		}

	}

	if (enemy_seen == false) {

		side_shooting_trigger = false;
		
	}



}