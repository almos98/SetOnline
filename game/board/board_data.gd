extends Node

onready var deck := Deck.new();
onready var selected: Array;
var matched: int = 0;

class Deck:
	var deck_: Array;
	
	func _init():
		for color in Enum.CardColor.values():
			for number in Enum.CardNumber.values():
				for shape in Enum.CardShape.values():
					for texture in Enum.CardTexture.values():
						deck_.push_back([color,number,shape,texture]);
	
		shuffle();
	
	func shuffle() -> void:
		randomize();
		for _i in 3:
			deck_.shuffle();
	
	func deal_cards(n: int) -> Array:
		var cards: Array = [];
		for _i in range(min(n, deck_.size())):
			cards.push_back((deck_.pop_back()));
		
		return cards;

func _ready():
	var dealt_cards: Array = deck.deal_cards(12);
	for card in $Cards.get_children():
		if !card.active:
			continue;
		card.connect("selected", self, "card_selected", [card]);
		card.set_attributes(dealt_cards.pop_back());
	
func card_selected(card):
	var i := selected.find(card);
	if i != -1:
		selected.remove(i);
		return;
	
	selected.push_back(card);
	if selected.size() == 3:
		if is_match(selected):
			var new_cards: Array = deck.deal_cards(3);
			for card in selected:
				card.set_properties(new_cards.pop_back());
			
			matched += 1;
			clear_selection();

func clear_selection() -> void:
	for card in selected:
		card.toggle_selection();
	selected.clear()

func is_match(cards: Array) -> bool:
	var matching := true;
	for attrib in ["color", "shape", "number", "texture"]:
		matching = matching and (
			(
				cards[0].get(attrib) == cards[1].get(attrib) and
				cards[0].get(attrib) == cards[2].get(attrib) and
				cards[1].get(attrib) == cards[2].get(attrib)
			)
			or
			(
				cards[0].get(attrib) != cards[1].get(attrib) and
				cards[0].get(attrib) != cards[2].get(attrib) and
				cards[1].get(attrib) != cards[2].get(attrib)
			)
		);
	
	return matching;
