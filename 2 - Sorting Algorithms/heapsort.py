# the heapsort function constructs a heap from a binary tree
# it extracts the largest element of the array after each heapify
# then it heapifies again, and extracts the next largest element
# this continues until it is done

def max_heapify(arr, n, i):
	largest = i
	l = 2*i + 1														# left	on binary tree
	r = 2*i + 2														# right on binary tree
	
	if l < n and arr[l] > arr[largest]:						# either l < n or l <= n-1 would work, since arr[n] would result in out of range
		largest = l
	if r < n and arr[r] > arr[largest]:
		largest = r
	if i != largest:													# if a parent is larger than its left/right child
		arr[i], arr[largest] = arr[largest], arr[i]			# swap the parent, child nodes
		max_heapify(arr, n, largest)						# repeat the heapify function for the parent-turned-child

# note that the min_heapify function is the same as the max heapify function
# except with the inequality signs reversed

def min_heapify(arr, n, i):
	smallest = i
	l = 2*i + 1
	r = 2*i + 2
	
	if l < n and arr[l] < arr[smallest]:
		smallest = l
	if r < n and arr[r] < arr[smallest]:
		smallest = r
	if i != smallest:
		arr[i], arr[smallest] = arr[smallest], arr[i]
		min_heapify(arr, n, smallest)

def build_heap(arr, n):
	for i in range((n//2)-1, -1, -1):						# start at n//2 -1, because that's the 2nd bottomost layer of the heap (with children)
		max_heapify(arr, n, i)

def heapsort(arr):
	n = len(arr)
	build_heap(arr, n)
	
	for i in range(n-1, 0, -1):								# from range n-1 to 0, because arr[n] would be out of range
		arr[i], arr[0] = arr[0], arr[i]							# swap arr[0] with arr[i], where arr[0] is the largest element of the heap
		max_heapify(arr, i, 0)								# max_heapify the heap, so that arr[0] is once again the largest element of the heap
	
	return arr

A = [1, 3, 4, 7, 9, 8, 2, 5, 6, -1, -2, 3]
print(heapsort(A))
