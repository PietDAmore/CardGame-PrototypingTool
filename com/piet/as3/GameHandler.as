import com.piet.as3.classes.GameController;
import com.piet.as3.classes.Player;
import com.piet.as3.classes.Card;
import com.piet.as3.classes.Deck;

// GameHandler

var round_cards_max: Number = 11;
var round_cards_left: Number = 11;

var player_active: Number = 0;
GameController.GetInstance().Start(game_container);

/*

// - - - - - 
var player1_cards_max: Number = 3;
var player1_cards: Number = 0;

var player2_cards_max: Number = 3;
var player2_cards: Number = 0;

var table_cards_max: Number = 5;
var table_cards: Number = 0;

var cards_on_table: Number = 0;
var cards_offset: Number = 2;
var cards_last_x: Number = stage.width - 250;
var cards_space: Number = 150;

var card_deck_array: Array = [1, 2, 3, 4, 5, 6, 1, 2, 3, 4, 5, 6]
var cards_left: Number = card_deck_array.length;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function SwitchPlayer(): void {

	if (player_active == 0) {
		player_active = 1;
		trace ("Next Player is 1");
		return;
	}

	if (player_active == 2) {
		player_active = 0;
		trace ("Next Player is 2");
		return;
	}
	
	if (player_active == 1) {
		player_active = 2;
		trace ("Next Player is Table");
		return;
	}

}

function GetCard(): void {
	
	// puts a card on the table
	var mc_deck: MovieClip = new Deck();
	game_container.addChild(mc_deck);

	mc_deck.x = cards_last_x - cards_offset;
	cards_last_x = mc_deck.x;

	mc_deck.y = 0;

	// Get Random Card
	var target_frame: Number = randomRange(1, card_deck_array.length);
	mc_deck.gotoAndStop(target_frame);
	trace("target_frame " + target_frame);

	cards_on_table += 1;
	mc_deck.name = "card" + cards_on_table;

	trace("mc_deck.name = " + mc_deck.name)

	mc_deck.addEventListener(MouseEvent.MOUSE_UP, TouchDeck);


	// mc_deck.name = "mc_deck";
	
}

function TouchDeck(e): void {

	if (e.type == MouseEvent.MOUSE_UP) {

		// Turn the card
		if (e.currentTarget.back.visible == true) {

			//remove Back
			e.currentTarget.back.visible = false;

			MoveCard(e);

			// order
			//setChildIndex(e.currentTarget, numChildren - 1); // e.currentTarget.child ORDER? ***

			trace(e.currentTarget.name);


		} else {

			e.currentTarget.removeEventListener(MouseEvent.MOUSE_UP, TouchDeck);

		}

	}

}

function MoveCard(e): void {

	// Round Handler
	if (round_cards_left == 0) {
		
		//round is over
		EndDistribution();
		return;
		
	} else {
		round_cards_left -= 1;
	}
	
	var offset: Number = randomRange(1,10);
	
	if (player_active == 0) {
		
		if (table_cards < table_cards_max -1) {
			e.currentTarget.x += 20;
			table_cards += 1;
			
		} else {
			
			SwitchPlayer();
			table_cards = 0;
			
		}
		
		e.currentTarget.x = -80 + offset;
		e.currentTarget.y = 0;
		
		return;
	}

	if (player_active == 1) {
		

		if (player1_cards < player1_cards_max -1) {				

			player1_cards += 1;
			
		} else {
			
			SwitchPlayer();
			player1_cards = 0;
			
		}
		
		trace("player1_cards " + player1_cards)
		
		e.currentTarget.x = game_container.player1.x + e.currentTarget.width / 2 + offset;
		e.currentTarget.y = game_container.player1.y + e.currentTarget.height / 2;
		
		return;
	}
	
	if (player_active == 2) {
		
		if (player2_cards < player2_cards_max -1) {
				
			player2_cards += 1;
			
		} else {
			
			SwitchPlayer();
			player2_cards = 0;
			
		}
		
		e.currentTarget.x = game_container.player2.x + e.currentTarget.width / 2 + offset;
		e.currentTarget.y = game_container.player2.y + e.currentTarget.height / 2;
		
		return;
	}

	// find card position
	if (player_active == 1) {
		
		trace("p1 x: " + game_container.player1.x);
		mc_deck.x = game_container.player1.x - cards_space;
		mc_deck.y = game_container.player1.y;
		
	} else {
		
		mc_deck.x = game_container.player2.x + cards_space;
		mc_deck.y = game_container.player2.y;
	}

}

function LayoutCards(): void {

	SwitchPlayer();

	game_container.addEventListener(Event.ENTER_FRAME, PlaceCards);

}

function PlaceCards(e): void {
	
	// Check how many cards are left
	if (cards_left > 0) {

		GetCard();
		cards_left -= 1;

	} else {

		game_container.removeEventListener(Event.ENTER_FRAME, PlaceCards);

	}

}

function EndDistribution(): void {
	
	trace("Cards Distribution complete");
	
}


function GetDungeonCards(): void {

	//SuffleCards(DungeonCards);


}

*/