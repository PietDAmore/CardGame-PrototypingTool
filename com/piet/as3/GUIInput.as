// # GUI INPUT


game_container.btn.addEventListener(MouseEvent.MOUSE_DOWN, button_press);

function button_press(e): void {

	if (e.type == MouseEvent.MOUSE_DOWN) {
		
		if (e.currentTarget.currentFrame > 1) {
			
			return;
			
		}

		ButtonClick(e);

		//game_container.btn.removeEventListener(MouseEvent.MOUSE_DOWN, button_press);
		
		
	}

}


game_container.btn.addEventListener(MouseEvent.MOUSE_UP, button_release);

function button_release(e): void {

	
	if (e.type == MouseEvent.MOUSE_UP) {

		ButtonRelease(e);
		
		//game_container.btn.removeEventListener(MouseEvent.MOUSE_UP, button_release);
		
	}

}


function ButtonClick(e): void {
	
	// deck.Shuffle();
	
	//LayoutCards();
	
	//e.currentTarget.txt.text = "Button";
	e.currentTarget.gotoAndPlay(2);

}

function ButtonRelease(e): void {
	
	// 
}
