class Node:
	def __init__(self, data=None, next=None):
		self.data = data
		self.next = next

class CircularLL:
	def __init__(self):
		self.head = None
	
	def push(self, data):
		node = Node(data)
		temp = self.head
		
		node.next = self.head
		if self.head:
			while(temp.next != self.head):
				temp = temp.next
			temp.next = node
		else:
			node.next = node
		self.head = node
		
	def removeFromEnd(self):
		if(self.head == None):
			temp1 = self.head
			temp2 = None
			if(temp1.next == self.head):
				val = self.head.data
				self.head = None
				return val
			while(temp1.next != self.head):
				temp2 = temp1
				temp1 = temp1.next
			temp2.next = self.head
			return temp1
	
	def traverse(self):
		temp = self.head
		if(self.head):
			while True:
				print("%d" % (temp.data))
				temp = temp.next
				if(temp == self.head): break;
	
	

A = CircularLL()
for i in range(10):
	A.push(i)

A.traverse()
