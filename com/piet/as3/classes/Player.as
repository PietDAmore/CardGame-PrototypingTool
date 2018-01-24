package com.piet.as3.classes {
		
	public class Player {
		
		private var name_var: String;
		private var maximum: Number;
		private var pos_x: Number;
		private var pos_y: Number;
		private var cards: Vector.<Card> = new Vector.<Card>();
		private var cards_on_hand: Number = 0;
		
		public function Player(maximum: Number) {
			
			this.name_var = name_var;
			this.maximum = maximum;
			this.cards_on_hand;
			
		}
		
		public function SetPositions(pos_x: Number, pos_y: Number):void{
			
			this.pos_x = pos_x;
			this.pos_y = pos_y;

		}
		public function GetName():String {
			return this.name_var;
		}
		
		public function SetName(name_v : String):void {
			name_var = name_v;
		}		
		
		public function GetPosX():Number {
			return this.pos_x;
		}
		
		public function GetPosY():Number {
			return this.pos_y;
		}		
		
		public function GetMaximum():Number{
				
			return maximum;
			
		}

		public function GetCards():Vector.<Card>{ // beinhaltet Typ "Card" Elemente
			
			return cards;
			
		}
		
		public function GetCardsOnHand():Number{
				
			return cards_on_hand;
			
		}		
		
		public function AddCard(card: Card):Boolean {
			
			if (cards.length < maximum) {
				
				cards_on_hand += 1; 
				//trace("cards on hand = "+ cards_on_hand); 
				//*** problem ist hier noch das maxium wenn mehr Karten auf den Tisch kommen
				
				cards.push(card);
				return true;
				
			}
			
			return false;
			
		}
		
		public function RemoveCard(card_id: Number) {
			
			// filtert nach der Karte, die die Card Id besitzt
			var index_to_delete: Number;
			
			this.cards.filter(
			
				function (card,index){
						
						if (card.GetId() == card_id) {
							index_to_delete = index;
						}
						
				},this // für Filter nötig
			);
			
			cards_on_hand -= 1;
				
			this.cards.removeAt(index_to_delete);
				
			
			
		}
		
		
	}
	
}
