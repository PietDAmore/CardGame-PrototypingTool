package com.piet.as3.classes {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
		
	public class Card {
		
		private var card_id: Number;		
		private var card_name: String;
		private var card_type: String;
		private var card_number: Number;
		private var card_symbol: String;
		private var card_mc: MovieClip;
		private var card_location: String;
		
		public function Card(card_id: Number, card_name: String, card_type: String, card_number: Number, card_symbol: String) {
			
			this.card_id = card_id;
			this.card_name = card_name;
			this.card_type = card_type;
			this.card_number = card_number;
			this.card_symbol = card_symbol;
			this.card_location = card_location;
			
		}
		
		// Get
		
		public function GetId():Number{
				
			return card_id;
			
		}
		
		public function GetName():String{
				
			return card_name;
			
		}

		public function GetType():String{
				
			return card_type;
			
		}		
		

		public function GetNumber():Number{
				
			return card_number;
			
		}				
		

		public function GetSymbol():String{
				
			return card_symbol;
			
		}
		
		public function getMC(): MovieClip {
				
			return card_mc;
			
		}
		
		public function setMC(mc : MovieClip): void {

			card_mc = mc;
			
		}
		
		public function toString(): String {
				
			return card_name;
			
		}
		
		public function GenerateMC(pos_x:Number, pos_y:Number): MovieClip {
			
			// Create a card movieclip
			var mc_card: MovieClip = new deck_mc();

			var target_frame: Number = this.GetId(); // Karte auslesen
		
			mc_card.back.visible = false;
			mc_card.x = pos_x;
			mc_card.y = pos_y;

			mc_card.gotoAndStop(target_frame);
			this.setMC(mc_card);
			
			mc_card.addEventListener(MouseEvent.MOUSE_DOWN, Card.ClickOnCard);
			
			return mc_card;
			
		}
		
		public function GetLocation(): String {
			
			return card_location;
			
		}

		public function SetLocation(loca:String) {
			
			card_location = loca;
			
		}

		public static function ClickOnCard(e): void {

			var cards_player_var: Number = GameController.GetInstance().cards_played += 1;
			var active :String = GameController.GetInstance().active_player;
			
			var target_x: Number = GameController.GetInstance().playfield_x;			
			var target_y: Number = GameController.GetInstance().playfield_y;
			
			// Find new card positions
			
			e.currentTarget.x = target_x;
			GameController.GetInstance().SetNewTargetX(target_x);			
			
			e.currentTarget.y = target_y;			
			GameController.GetInstance().SwitchPlayer();
			
			// Get this card parameters
			
			//trace("card_numbr = " + this.card_number);
			GameController.GetInstance().CompareCards(4);
			
			
			// Try to find a lesser card
			
			//var selected_card: MovieClip = getMC();
			//GameController.GetInstance().playfield.AddCard();
			
			//trace(active + " has put "+ selected_card + " on the table.");
		}
		
	}
	
}
