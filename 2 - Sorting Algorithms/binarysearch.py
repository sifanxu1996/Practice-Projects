def search(a, k):
	if len(a) == 1: return a[0]
	pivot = a[0]
	a1 = [x for x in a[1:] if x <= pivot]					# a1 contains all elements < a[0]
	if len(a1) == k:												# if len(a1) == len(a)//2, return a[0]
		return a[0]
	elif len(a1) > k:												# elif len(a1) > len(a)//2, return search(a1, len(a)//2)
		return search(a1, k)
	else:																# else len(a1) < len(a)//2, return search(a2, len(a)//2 - len(a1) - 1)
		a2 = [x for x in a[1:] if x > pivot]
		return search(a2, k - len(a1) - 1)

def median(a):
	return search(A, len(a)//2)

A = [1, 3, 4, 7, 9, 8, 2, 5, 6]
B = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print(median(A))
