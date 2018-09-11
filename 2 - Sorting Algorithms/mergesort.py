# 1) merge sort breaks down the arrays into arrays composed of a single element
# 2) then it compares elements in pairs of arrays, and append the smaller ones to a new array
# 3) it repeats step 2 until only one sorted array remains

def mergesort(arr):
	if len(arr) <= 1: return arr								# return array if its length is less than or equal to one
	middle = len(arr)//2										# set middle to equal the length of the array integer-divided by 2
	a = mergesort(arr[:middle])								# a is equal to the mergesort of the array, from index 0 to index middle
	b = mergesort(arr[middle:])								# b is equal to the mergesort of the array, from index middle to index -1
	return merge(a, b)										# return the merge of the two arrays

def merge(a, b):
	c = []															# create an empty array, c
	while a and b:												# while there exists elements in both array a and array b
		c += [min(a[0], b[0])]									# append the smaller element of the arrays at index 0
		if c[-1] == a[0]:											# if the most recently appended element is equal to a[0]
			a = a[1:]												# move array forward 1 index
		else:															# else the most recently appended element is equal to b[0]
			b = b[1:]												# move array forward 1 index
	return c + a + b											# return the concatenation of the sorted smallest array c, and the arrays a, b (one of which is empty)
