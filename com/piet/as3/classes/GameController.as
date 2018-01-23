﻿package com.piet.as3.classes {

	import com.piet.as3.classes.Card;
	import flash.display.Sprite;
	import flash.display.MovieClip;

	public class GameController {

		// setup
		private static var instance: GameController;		
		
		private var game_container: MovieClip;
		private var setup: GameRules = new GameRules();
		private var startplayer: Number = 1;
		public var active_player: String = "player1";
		private var player1: Player;
		private var player2: Player;
		private var playfield: Player;
		public var playfield_x: Number = 0;
		public var playfield_y: Number = 0;
		private var deck: Deck;
		
		// stats
		public var cards_played: Number = 0;

		public function GameController() {
			
			// constructor

		}

		public static function GetInstance(): GameController {
			
			// Singleton
			if(GameController.instance == null) {
					GameController.instance = new GameController();
			}
			
			return GameController.instance;
		}
		
		public function Start(game_container: MovieClip) {

			this.game_container = game_container;
			
			// Define player parameters
			this.player1 = new Player(3);
			this.player2 = new Player(3);
			this.playfield = new Player(5);
			
			player1.SetName("player1");
			player2.SetName("player2");
			playfield.SetName("playfield");
			
			this.player1.SetPositions(game_container.player1.x,game_container.player1.y);
			this.player2.SetPositions(game_container.player2.x,game_container.player2.y);
			this.playfield.SetPositions(game_container.playfield.x,game_container.playfield.y);
			playfield_x = game_container.playfield.x;
			playfield_y = game_container.playfield.y;
			
			// Decks zusammenstellen/mischen
			var cards: Vector.<Card> = new Vector.<Card>(); // Objekt (Pool) erstellen im Vergleich zu Array kann man mehr reinpacken als Zahlen und Strings
			// cards2: Vector etc.

			// Kartendeck 1
			cards.push(new Card(1, "Gregor", "Ritter", 8, "Holz"));
			cards.push(new Card(2, "Piet", "Hofnarr", 8, "Wasser"));
			cards.push(new Card(3, "Julia", "Henker", 10, "Feuer"));
			cards.push(new Card(4, "Janin", "Schurke", 5, "Eisen"));
			cards.push(new Card(5, "Penner", "Ritter", 3, "Holz"));
			cards.push(new Card(6, "Arsch", "Hofnarr", 4, "Wasser"));
			cards.push(new Card(7, "Spätzle", "Henker", 2, "Feuer"));
			cards.push(new Card(8, "Schinken", "Schurke", 3, "Eisen"));
			cards.push(new Card(9, "Martin", "Ritter", 9, "Holz"));
			cards.push(new Card(10, "Sascha", "Hofnarr", 7, "Wasser"));
			//cards.push(new Card(11, "Sven", "Henker", 6, "Feuer"));
			
			// Alle Karten dem Deck hinzufügen
			this.deck = new Deck(cards);
			// deck2

			deck.Shuffle();

			// Player einrichten
			// - player punkte

			// Runde initiieren	
			NewRound();

		}

		public function NewRound() {

			// Neue Runde initiieren
			
			
			/// Spieler Reihenfolge festlegen
			var receivers: Vector.<Player> = new Vector.<Player>();

			receivers.push(this.player1);
			receivers.push(this.player2);
			receivers.push(this.playfield);
		
			receivers.forEach(function (receiver, index) {
				
				// take max number of cards and deal
				for (var i: Number = 0; i < receiver.GetMaximum(); i++) {
					
					if (this.deck.GetCards().length != 0) {
						
						trace(receiver.GetName() + " has " + receiver.GetCardsOnHand() + " on hand.");
						
						// pop nimmt die erste Karte
						receiver.AddCard(this.deck.GetCards().pop()); 
						
					}

				}
				
				// Weise Karten zu / Erstelle Karte
				receiver.GetCards().forEach(function (card, index) {
					
					var mc_card: MovieClip = card.GenerateMC(receiver.GetPosX() + index * 160,receiver.GetPosY());
					
					card.SetLocation(active_player);
					SetNewTargetX(mc_card.x);
					
					game_container.addChild(mc_card);
					
				}, this);
				
			}, this);

			/// Karte erzeugen
			if (this.deck.GetCards().length == 0){
				trace("Karte wurde erzeugt.");
			}
				
		}
		
		// Functions
		
		public function CompareCards(strength: Number):void {
			
			var target_cards: Vector.<Player> = this.playfield// new Vector.<Player>(); // kommt hier ein neuer Vector?
			
			// füge Elemente in Vector ein
			target_cards.push(this.playfield);
			
			trace(target_cards.GetName());
			
			/*
			target_cards.forEach(function (target_card, index) {
				
					for (var i: Number = 0; i < target_cards.GetCardsOnHand(); i++) {
						
						if (this.playfield.GetCards().length != 0) {  // was kommt hier rein?
							
							var target_card_number: Number = target_card.GetNumber();
							
							trace("target_card_number = " + target_card_number);
							// Card Number Vergleichen (wenn gespielte Karte Nummer > target_card)
							
							// Karte aus Deck nehmen (active player) .RemoveCard(target_card);
							// Karte auf Tisch packen
							
						}
						
					}	
					
			}, this);
			*/
			
		}
		
		public function SetNewTargetX(mc_x: Number): void {
			
			playfield_x = mc_x + 160;
					
		}

		public function NewTurn() {
			
			// Special rules
			if (active_player == "playfield") {
				// if deck == 0, take all cards and give it to last player
			}
			
			// Turn basics
			

		}

		public function SwitchPlayer():void {

			if (active_player == "player1") {
				
				active_player = "player2";
				
			} else {
				
				active_player = "player1";
				
			}

				
			/* back up table turn
			if (active_player == "player1") {
				
				active_player = "player2";
				
			} else if (active_player == "player2"){

				active_player = "playfield";
				
			} else {
				
				active_player = "player1";
				
			}
			*/
			
		}

		public function EndGame() {

			// trace ("Winner is...");

		}

	}

}