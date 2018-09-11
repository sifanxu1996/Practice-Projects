class Card:
	def __init__(self, suit, rank):
		self.suit = suit
		self.rank = rank
	
	def __str__(self):
		return ("%s of %s" %(self.rank, self.suit))

class CardDeck:
	def __init__(self):
		self.deck = []
		for suit in ['clubs', 'diamonds', 'hearts', 'spades']:
			for rank in ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']:
				self.deck += [Card(suit, rank)]
	
	def shuffle(self):
		for i in range(100):
			a, b = random.randrange(len(self.deck)), random.randrange(len(self.deck))
			self.deck[a], self.deck[b] = self.deck[b], self.deck[a]
	
	def deal(self):
		return self.cards.pop()

class CardHand:
	def __init__(self, hand):
		self.hand = hand
	
	def get_card(self, card):
		print(card)
		self.deck += [card]
	
	def full_house(self):
		ranks = []
		for i in range(5):
			ranks += [self.hand[i].rank]
		B = list(set(ranks))
		return ranks.count(B[0])*ranks.count(B[1]) == 6
	
	def flush(self):
		return self.hand[0].suit == self.hand[1].suit == self.hand[2].suit == self.hand[3].suit == self.hand[4].suit
	
	def pair(self):
		ranks = []
		for i in range(5):
			ranks += [self.hand[i].rank]
		B = set(ranks)
		return len(B) == 4
