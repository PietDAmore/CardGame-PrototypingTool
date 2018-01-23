// Cheats
var debug: Boolean = false;

// Game
var game_update: Boolean = false;
var battle: Boolean = false;
var game_mode: String = "Singleplayer";
var round: Number = 1;

var game_options: Array = [1, 1]; // round_number, player_number

// Controls
var user_input: Boolean = false;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

ApplicationStart();


function ApplicationStart(): void {

	GameStart();
	
	// - Gui Tasks

}

function GameStart(): void {

	CreateGame();
	
	// - Setup (Wie vielel Spieler, Modus etc.)
	
}

function CreateGame(): void {
	
	// Single-/Multiplayer
	var player_number: Number = game_options[1];
	var game_mode: String = SwitchPlayerAmount();

	// Set up rounds
	var round_number: Number = game_options[0];
	
	trace("Game has started");
	
}

function SwitchPlayerAmount(): String {
	
	// Single- or Multiplayer?
	var players: Number = game_options[1];

	if (players > 1) {

		game_mode = "Multiplayer";

	} else {

		game_mode = "Singleplayer";

	}

	return (game_mode);

}
