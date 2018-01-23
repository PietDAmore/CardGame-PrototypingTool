// # INPUT

var walkkeys_pushed: Boolean = false;

mc_startscreen.addEventListener(MouseEvent.MOUSE_DOWN, startPressed);

function startPressed(e): void {

	if (e.type == MouseEvent.MOUSE_DOWN) {

		startGame();

	}

}



btn_a.addEventListener(MouseEvent.MOUSE_DOWN, clickA);

function clickA(e): void {

	if (e.type == MouseEvent.MOUSE_DOWN) {

		pressA();
	}

}

btn_a.addEventListener(MouseEvent.MOUSE_UP, clickArelease);

function clickArelease(e): void {

	if (e.type == MouseEvent.MOUSE_UP) {

		releaseA();
	}

}


btn_left.addEventListener(MouseEvent.MOUSE_DOWN, clickLeft);

function clickLeft(e): void {

	pressLeft();

}

btn_left.addEventListener(MouseEvent.MOUSE_UP, clickLeftRelease);

function clickLeftRelease(e): void {

	releaseLeft();

}


btn_right.addEventListener(MouseEvent.MOUSE_DOWN, clickRight);

function clickRight(e): void {

	pressRight();

}

btn_right.addEventListener(MouseEvent.MOUSE_UP, clickRightRelease);

function clickRightRelease(e): void {

	releaseRight();

}

btn_r.addEventListener(MouseEvent.MOUSE_DOWN, clickR);

function clickR(e): void {

	pressR();

}

btn_r.addEventListener(MouseEvent.MOUSE_UP, clickRRelease);

function clickRRelease(e): void {

	releaseR();

}


btn_quit.addEventListener(MouseEvent.CLICK, Quit);

function Quit(e): void {

	quitApp();

}

btn_quit.addEventListener(MouseEvent.CLICK, Quit);

btn_restart.addEventListener(MouseEvent.CLICK, restartClick);

function restartClick(e): void {

	restart();

}

function restart(): void {
	restartGame();
}

stage.addEventListener(KeyboardEvent.KEY_DOWN, reportKeyDown);
stage.addEventListener(KeyboardEvent.KEY_UP, reportKeyUp);

function reportKeyDown(event: KeyboardEvent): void {

	// trace("Key pressed: " + String.fromCharCode(event.charCode) + " (character code: " + event.charCode + ")");

	if (event.charCode == 32 ||  event.charCode == Keyboard.SPACE) {

		pressA();
	}

	if (event.charCode == 97 ||  event.charCode == Keyboard.A) {

		pressLeft();
	}

	if (event.charCode == 115 ||  event.charCode == Keyboard.S) {

		pressRight();
	}

	if (event.charCode == 13) { // Return

		pressR();
	}

}

function reportKeyUp(event: KeyboardEvent): void {

	// trace("Key pressed: " + String.fromCharCode(event.charCode) + " (character code: " + event.charCode + ")");

	if (event.charCode == 97 ||  event.charCode == Keyboard.A) {

		releaseLeft();
	}

	if (event.charCode == 115 ||  event.charCode == Keyboard.S) {

		releaseRight();
	}

	if (event.charCode == 32 ||  event.charCode == Keyboard.SPACE) {

		releaseA();
	}

	if (event.charCode == 114) { // R

		restart();
	}

	if (event.charCode == 13) { // Return

		releaseR();
	}

	if (event.charCode == 27) {

		quitApp();

	}

}

function pressA(): void {

	if (game_update == false) {

		startGame();
		return;

	}

	if (walkkeys_pushed == false) {

		walkkeys_pushed = true;

		if (player_walknorth == true) {

			//trace("shoot while player_walknorth");
			anim_shoot = false;
			firstshot = true;
			shoot();

			return;

		}

		if (player_stand_delay > 15 && firstshot == true) {

			firstshot = false;
			shoot();

		} else {

			firstshot = true;
			shoot();

		}

		btn_a.gotoAndStop(2);
	}

	if (walkkeys_pushed == true && player_action == "walk") {
		
		player_roll();
		
	}

}

function releaseA(): void {

	walkkeys_pushed = false;
	player_walknorth_shoot = false;
	btn_a.gotoAndStop(1);

}

function pressLeft(): void {

	if (walkkeys_pushed == false || player_walknorth == false) {
		walkkeys_pushed = true;
		player_action = "walk";
		player_move_direction = "left";

		btn_left.gotoAndStop(2);
	}

}

function pressRight(): void {

	if (walkkeys_pushed == false || player_walknorth == false) {
		walkkeys_pushed = true;
		player_action = "walk";
		player_move_direction = "right";

		btn_right.gotoAndStop(2);
	}
}

function releaseLeft(): void {

	walkkeys_pushed = false;

	if (double_check_pressed < 2) {
		switchPlayerState("idle");
	}

	// trace("double_check_pressed = " + double_check_pressed);
	player_roll_input();

	btn_left.gotoAndStop(1);

}


function releaseRight(): void {

	walkkeys_pushed = false;

	if (double_check_pressed < 2) {
		switchPlayerState("idle");
	}

	// trace("double_check_pressed = " + double_check_pressed);
	player_roll_input();

	btn_right.gotoAndStop(1);

}

function pressR(): void {

	// player_roll();

	btn_r.gotoAndStop(2);
}

function releaseR(): void {

	if (cheat_invisible == false) {
		cheat_invisible = true;
		cheat_sight = true;
		trace("Cheats: on");
		btn_r.alpha = 0.5;
	} else {
		cheat_invisible = false;
		cheat_sight = false;
		trace("Cheats: off");
		btn_r.alpha = 1;
	}

	reload();

	btn_r.gotoAndStop(1);
}

function reload(): void {
	trace("reload");
}

function quitApp(): void {
	NativeApplication.nativeApplication.exit();
}

/// ------------------------------------------------------------------------------
// Waypoints
function createGroundPoints(): void {

	for (var i = 0; i < ground_array.length; i++) {

		ground_array[i].addEventListener(MouseEvent.MOUSE_DOWN, createWaypoint);

	}

}

function destroyGroundPoints(): void {

	for (var i = 0; i < ground_array.length; i++) {

		waypoint_waiting = false;
		ground_array[i].removeEventListener(MouseEvent.MOUSE_DOWN, createWaypoint);

	}

}

function removeWaypointLeft(): void  {

	for (var i = 0; i < ground_array.length; i++) {

		ground_array[i].stop();
		ground_array[i].removeEventListener(Event.ENTER_FRAME, waypointArrowUpdate);

		waypoint_waiting = false;

	}

}

function createWaypoint(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, createWaypoint);
		return;
	}

	//	if (e.currentTarget.y > player.y) { // only in the same row as player

	waypoint_waiting = true;

	var mc_waypoint = new waypoint();
	tiles_container.addChild(mc_waypoint);

	mc_waypoint.x = e.currentTarget.x + mc_waypoint.width + 20;
	mc_waypoint.y = e.currentTarget.y + mc_waypoint.height + 24;

	mc_waypoint.addEventListener(Event.ENTER_FRAME, waypointArrowUpdate);
	//	}

}
/// ------------------------------------------------------------------------------