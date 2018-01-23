// LevelAssets

function bloodUpdate(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, bloodUpdate);
		return;
	}

	var blood_distance = randomRange(1,8);
	

}

function doorUpdate(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, doorUpdate);
		return;
	}

	if (e.currentTarget.currentFrame == e.currentTarget.totalFrames) {

		level_nmbr++;
		gotoNextLevel();

		e.currentTarget.removeEventListener(Event.ENTER_FRAME, doorUpdate);
	}

	player.y -= player_speed;
	player.x = e.currentTarget.x;
}

function northArrowAnim(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, northArrowAnim);
		return;
	}

	if (e.currentTarget.currentFrame == e.currentTarget.totalFrames) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, northArrowAnim);
		e.currentTarget.stop();
		e.currentTarget.parent.removeChild(e.currentTarget);
	}
}

function waypointArrowUpdate(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, waypointArrowUpdate);
		return;
	}

	if (e.currentTarget.currentFrame == e.currentTarget.totalFrames) {

		player_action = "walk";

		if (player.x < e.currentTarget.x) {
			player_move_direction = "right"
		}

		if (player.x > e.currentTarget.x) {
			player_move_direction = "left"
		}

		e.currentTarget.stop();

	}
	if (waypoint_waiting == false) {
		// e.currentTarget.parent.player.collider

		player_action = "idle";

		e.currentTarget.removeEventListener(Event.ENTER_FRAME, waypointArrowUpdate);
		e.currentTarget.parent.removeChild(e.currentTarget);

		return;
	}

	if (e.currentTarget.hitTestObject(player)) {
		// e.currentTarget.parent.player.collider

		player_action = "idle";
		player.x = e.currentTarget.x;

		e.currentTarget.removeEventListener(Event.ENTER_FRAME, waypointArrowUpdate);
		e.currentTarget.parent.removeChild(e.currentTarget);
	}

}