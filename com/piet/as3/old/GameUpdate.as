// # UPDATE

stage.addEventListener(Event.ENTER_FRAME, Update);

function Update(e): void {

	if (game_update == false) {
		return;
	}

	if (time_framecount >= 24) {
		time_needed += 1;
		time_framecount = 0;
	} else {
		time_framecount++;
	}

}