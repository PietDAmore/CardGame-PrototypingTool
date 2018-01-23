// CardHandler

var letters:Array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
var shuffledLetters:Array = new Array(letters.length);
 
var randomPos:Number = 0;
for (var i:int = 0; i < shuffledLetters.length; i++)
{
    randomPos = int(Math.random() * letters.length);
    shuffledLetters[i] = letters.splice(randomPos, 1)[0];   //since splice() returns an Array, we have to specify that we want the first (only) element
}













/*
maxcards = 52;
var suits:Array=[“hearts”,“clubs”,“spades”,“diamonds”];

//card-players may balk at this order
var values:Array=[“Ace”,“2”,“3”,“4”,“5”,“6”,“7”,“8”,“9”,“10”,“jack”,“queen”,“king”];

//I’m working on the base of a standard deck of cards with 4 suits of 13 cards each.
//if you want jokers too, add them on the end, and special-case them
//the number representation of a card is the face value index plus (the suit index * 13)

trace (“here is the deck of cards”);
var card:Array = new Array();

// first build a list of cards
for (i=0;i<maxcards;i++){
  card[i]=i;
  read_card(card[i]);
}

//now mix the cards
for (i=0;i<maxcards-1;i++){
  j=Math.floor(Math.random()*(maxcards-1-i))+i+1;
  var tmp:Number=card[i]; card[i]=card[j];
  card[j]=tmp; read_card(card[i]);
}

//and list them
trace ("");
trace (“here are the cards, shuffled”);
for (i=0;i<maxcards;i++){
  read_card(card[i]);
}

//so lets deal some hands.
//I’m going to be lazy and just take each one off the end of the deck.
//since doing it alternately adds nothing useful.

trace ("");
trace (“here are the hands, in card-number values”);

var players:Number=4;
var handsize:Number=7;

//cards in a hand

var hands:Array=new Array;

for (i=0;i<players;i++){

  hands[i] = new Array;

  trace ("");
  trace ("player "+i);

  for (j=0;j<handsize;j++){
    hands[i][j]=card.pop();
  }

  trace(hands[i]);

}

function read_card(cardnum){

  var val:String=values[cardnum%13];
  var suit:String=suits[(cardnum-cardnum%13)/13];

  trace("no. “cardnum” suit=“suit” value=" + val);
  //report to terminal. you could put them into a string or something


}
*/