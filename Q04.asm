.data

.text
	li $s0, 0				# s0 contain start address for A
	li $t0, 16				# t0 = 16
	li $t1, 0				# t1 is counter
	li $t2 = 2				# t2 = 2
	li $s1, -64				# s1 contain start address for B
	li $sp, -388				# allocate space for array
fill_A:
	beq $t0, $t1, continue
	div $t0, $t2
	mfhi $t3				# t3 = t0 % 2
	beq $t3, $zero, set_zero		# if t3 == 0 then A[i] = 0 else A[i] = 1
	mul $t5, $t1, -4
	add $t5, $s0, $t5 			# t5 is A[i] address
	li $t6, 1
	sw $t6, 0($t5)
	addi $t1, 1				# counter++
	j fill_A
	
set_zero:
	mul $t5, $t1, -4				
	add $t5, $t5, $s0			# t5 is A[i] address
	sw $zero, 0($t5)
	addi $t1, 1				# counter++
	j fill_A
	
continue:
	li $t1, 0				# t1 is counter
	li $t0, 81				# t1 is size of B

fill_B
	beq $t0, $t1, change_arrays
	mul $t5, $t1, -4
	add $t5, $s1, $t5 			# t5 is B[i] address
	li $t6, 0
	sw $t6, 0($t5)
	addi $t1, 1				# counter++
	j fill_B
	
	
change_arrays:
	li $t1, 4				# t1 is 4
	li $t0, 0				# t0 is counter
	li $t2, 1				
	li $t3, 1
	j loop			
loop:
	beq $t0, $t1, end_loop
	sll $t2, $t2, 1				# t2 = 2 ^ i
	add $t4, $t3, $zero			# t4 = t3
	sll $t3, $t3, 1				
	add $t3, $t3, $t4			# t3 = 3 ^ i			
	
	addi $t2, -1				
	add $t6, $s0, $t2			# t6 is address of A[2 ^ i - 1]
	lw $t5, 0($t6)				# t5 = A[2 ^ i - 1]
	addi $t2, 1
	
	addi $t3, -1			
	add $t6, $s0, $t3
	lw $t7, 0($t6)				# t7 = B[3 ^ i - 1]
	add $t3, 1
	
	add $t8, $zero, $t5			# temp = t5
	add $t5, $zero, $t7			# t5 = t7
	add $t7, $zero, $t8			# t7 = temp
	j loop
	
end_loop
	li $v0, 10
	syscall