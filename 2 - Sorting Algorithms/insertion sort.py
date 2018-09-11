def insertion_sort(arr):
	for i in range(1, len(arr)):
		value = arr[i]
		j = i
		
		while j > 0 and arr[j-1] > value:					# while j > 0 and arr[j-1] > arr[i]
			arr[j] = arr[j-1]										# arr[j] is set to arr[j-1]
			j += -1													# increment j by -1
		
		arr[j] = value												# arr[j] is set to arr[i]
	return arr

A = [54, 26, 93, 17, 77, 31, 44, 55, 20, 4, 19, 84, -51, -14]
print(insertion_sort(A))
