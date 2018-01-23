package com.piet.as3.classes {
	
	import com.piet.as3.classes.Card;
	
	public class Deck {
		
		private var cards: Vector.<Card>;
		
		public function Deck(cards: Vector.<Card>) {
			
			this.cards = cards;
			
		}

		public function GetCards(): Vector.<Card>{
				
			return cards;
			
		}		
		
		public function Shuffle():void{
			
			var shuffeled_cards: Vector.<Card> = new Vector.<Card>(); // das neue Deck
			
			while (this.cards.length != 0) {
				
				var random_card_index: Number = randomRange(0, this.cards.length);
				
				var random_card: Card = this.cards[random_card_index]; // aus dem Array rausziehen
				
				this.cards.removeAt(random_card_index); //aus dem Array löschen
				
				shuffeled_cards.push(random_card);
					
			}
			
			this.cards = shuffeled_cards;
			
			trace("shuffeled_cards " + shuffeled_cards.toString());
			
		}
		
		private function randomRange(minNum: Number, maxNum: Number): Number {
			return (Math.floor(Math.random() * (maxNum - minNum)) + minNum);
		}
		
		
	}
	
}
