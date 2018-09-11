# 1) quicksort partitions the array into 2 halves
# 2) one half has all elements smaller than the pivot
# 3) the other half has all elements larger than the pivot
# 4) the steps are repeated until all of it is partitioned in sorted order
# 5) then the arrays are conctatenated

def quicksort(arr):
	if len(arr) <= 1: return arr								# return array if its length is less than or equal to one
	pivot = arr[0]													# set pivot to equal arr[0], the first element of the arry
	a1 = quicksort([x for x in arr[1:] if x <= pivot])	# quicksort the array that consists of all the elements of the array less than or equal the pivot
	a2 = quicksort([x for x in arr[1:] if x > pivot])	# quicksort the array that consists of all the elements of the array greater than the pivot
	return a1 + [arr[0]] + a2								# return the concatenation of the sorted smaller array, the pivot, and the sorted larger array
