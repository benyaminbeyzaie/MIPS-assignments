.data

.text
main: 					# Main function of the program
	li $v0, 5			# ready to get the user input
	syscall
	move $a0, $v0
	jal recursive_function		# call the function by a0
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	

recursive_function:			# The f function which is definded by the question
	li $t0, 1
	bgt $a0, $t0, recurse		# If the parameter that passed to the dunction is grater than one
					# then go to the recurse.
	bne $a0, $zero, one		# if the argument is not equal to zero then return one (branch to one)
	li $v0, 0			# if argument is zero then return zero
	jr $ra				# jump to the return address

one: 					# this function returns one
	li $v0, 1
	jr $ra

recurse: 
	addi $sp, $sp, -12 		# allocate 3 space in the stack
	sw $ra, 8($sp)			# save the return address in the first place of allocated stack
	sw $a0, 4($sp)			# save the original argument in the second place of allocated stack
	addi $a0, $a0, -1		# a0 <= a0 - 1
	jal recursive_function		# determine f(a0 - 1) by recursion
	addi $t0, $zero, 2		# t0 <= 2
	mul $v0, $t0, $v0		# v0 <= 2f(a-1)
	sw $v0, 0($sp)			# save the 2f(a-1) into the third place of allocated stack
	lw $a0, 4($sp)			# a0 <= original a0
	addi $a0, $a0, -2		# a0 <= a0 - 2
	jal recursive_function		# determine f(a0 - 2) by recresion
	addi $t0, $zero, 3		# t0 <= 3
	mul $v0, $v0 , $t0 		# v0 <= 3f(a-2)
	lw $t0, 0($sp)			# load the 2(a-1) into t0
	add $v0, $t0, $v0		# v0 = 2f(a-1) + 3f(a-2)
	lw $ra, 8($sp)			# load the original return address
	addi $sp, $sp, 12		# deallocate stack
	jr $ra
	
	
	
	
	
	
