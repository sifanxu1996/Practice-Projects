def bubble (a):
	for i in range (1, len(a)):
		for j in range (len(a-i)):
			if a[j] > a[j+1]: a[j], a[j+1] = a[j+1], a[j]
			print(i, j, a)
		print()
	return A

def mysort(a):
	# make an array
	# find smallest in array a
	# store value in array b
	# shorten array a by that value
	
	b = []
	for i in range (0, len(a)):
		smallest = a[0]
		for j in range (0, len(a)):
			if a[j] <= smallest:
				smallest = a[j]
				index = j
			elif smallest == a[0]:
				index = 0
		b.append(smallest)
		a.remove(a[index])
		#print(i, j, b)
	print
	return b

def main():
	x = [199, 88, 323, 33, 9, 1, -33, 45, 384, 293, 93, 3, 13, 83, 22, 174, -33, -1466]
	print(mysort(x))

main()
