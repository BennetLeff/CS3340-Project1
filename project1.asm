.data
	prompt:    .asciiz "Enter an integer between 2 and 18: "
	newline:   .asciiz "\n"

.text
main:
	# Prompt user for input
	li $v0, 4		# prepare for print syscall
	la $a0, prompt		# load prompt address in arg register
	syscall			# print prompt
	
	# Get user input
	li $v0, 5 		# prepare to read input integer
	syscall
	
	# Store the input in $t0
	move $t0, $v0		 # this equals m in the fib program
	
	###### FIB Program #######
	# a = 1
	# b = 2
	# c = 0
	# count = 1
	# d = 1
	# d = d << m
	# d = d - 1
	# e = 0
	# while not(e == 1):
	# 	a = a & d
	# 	b = b & d
	#	e = a * b
	# 	c = a + b			
	# 	a = b			
	# 	b = c
	# 	count = count + 1
	# return count
	
	addi $t1, $zero, 1	# a = 1
	addi $t2, $zero, 2	# b = 2
	addi $t3, $zero, 0  	# c = 0
	addi $t4, $zero, 0	# count = 0
	addi $t5, $zero, 1	# set d to 1
	sllv $t5, $t5,   $t0    # d = d << m (d = 1 * 2^m)
	addi $t5, $t5,   -1	# 1's compliment of d
	addi $t6, $zero, 0      # e = 0
	addi $t7, $zero, 1	# holds 1 so we can do a branch in loop if e == 1
	
loop:
   	beq  $t6, $t7, end 	# exit loop if e == 1
   	and  $t1, $t1, $t5	# a = a & d
   	and  $t2, $t2, $t5	# b = b & d
	mult $t1, $t2   	# sets mflo/mfhi to a*b
   	mflo $t6		# e = a*b
   	add  $t3, $t2, $t1  	# c = b + a
   	move $t1, $t2 		# a = b
   	add  $t2, $zero, $t3	# b = c
   	addi $t4, $t4, 1 	# count = count + 1
   	
   	# li   $v0, 1			# print the number
   	# move $a0, $t3
   	# syscall
   	
   	j    loop
	
	###############################
end: 		
	# Print a from fib loop to console
	li   $v0, 1
	move $a0, $t4
	syscall
