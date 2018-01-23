import flash.display.MovieClip;

// GameTools

function randomRange(minNum: Number, maxNum: Number): Number {
	return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
}


function StopAnimationAtEnd(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, RemoveThisAtEnd);
		return;
	}

	if (e.currentTarget.currentFrame == e.currentTarget.totalFrames) {
		e.currentTarget.gotoAndStop(e.currentTarget.totalFrames);
		e.currentTarget.stop();
	}
}

function RemoveThisAtEnd(e): void {

	if (e.currentTarget.parent == null) {
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, RemoveThisAtEnd);
		return;
	}

	if (e.currentTarget.currentFrame == e.currentTarget.totalFrames) {

		e.currentTarget.stop();
		e.currentTarget.removeEventListener(Event.ENTER_FRAME, RemoveThisAtEnd);
		e.currentTarget.parent.removeChild(e.currentTarget);

	}
}