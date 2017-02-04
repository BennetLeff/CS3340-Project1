

def fib(m):
	a = 1
	b = 2
	c = 0
	count = 0
	d = (1<<m) - 1
	e = a * b
	while not(e == 1):
		a = a & d
		b = b & d
		e = a * b
		c = a + b			
		a = b			
		b = c
		count = count + 1

	return count

print fib(3) 


