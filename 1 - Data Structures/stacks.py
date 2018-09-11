class Stack:
	def __init__(self):
		self.items = []
	
	def push(self, item):
		self.items.append(item)
	
	def pop(self):
		return self.items.pop()
	
	def is_empty(self):
		return self.items==[]

def main():
	s = Stack()
	s.push(1)
	s.push(2)
	s.push(3)
	
	while not s.is_empty():
		print s.pop()

main()
