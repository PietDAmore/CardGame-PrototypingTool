// Interface Handler

function createGuiBar(): void {

	addChild(mc_guiBar);

	mc_guiBar.x = 400;
	mc_guiBar.y = 16;

	// var i:uint = mc_guiBar.getChildIndex(tiles_container);
	//mc_guiBar.parent.setChildIndex(mc_guiBar);
	//mc_guiBar.numberChildren -1;

	mc_guiBar.addEventListener(Event.ENTER_FRAME, guiBarUpdate);
}

function destroyGuiBar(): void {

	while (mc_guiBar.numChildren > 0) {
		mc_guiBar.removeChildAt(0);
	}

	mc_guiBar.removeEventListener(Event.ENTER_FRAME, guiBarUpdate);
}

function guiBarUpdate(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, guiBarUpdate);
		return;
	}

	mc_guiBar.time_txt.text = "" + time_needed;
	mc_guiBar.level_txt.text = "" + level_nmbr;

}