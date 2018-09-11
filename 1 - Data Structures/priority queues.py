import random

class Node:
	def __init__(self, cargo=None, priority='L', next=None):
		self.cargo = cargo
		self.priority = priority
		self.next = next
	
	def __str__(self):
		return str(self.cargo) + str(self.priority)

class Queue:
	def __init__(self, head=None):
		self.head = head
	
	def is_empty(self):
		return self.head==None
	
	def enqueue(self, newNode=Node()):
		node = Node(newNode.cargo, newNode.priority)
		if self.head == None:
			self.head = node
		else:
			last = self.head
			while last.next:
				last = last.next
			last.next = node
	
	def dequeue(self):
		if self.head == None: return None
		last = self.head
		if last.priority == 'H' or last.next == None:
			self.head = last.next
			return last
		while last.next:
			if last.next.priority == 'H':
				temp = last.next
				last.next = last.next.next
				return temp
			last = last.next
		
		# this implies no 'H' priorities exist in the linked list
		last = self.head
		self.head = last.next
		return last
		
A = Queue()
for i in range(10):
	rand_node = Node(i, random.choice('HL'))
	print(rand_node)
	A.enqueue(rand_node)

print()

while not A.is_empty():
	print(A.dequeue())
