.data
	variance_label: .asciiz "variance: "
	average_label: .asciiz "average: "
	enter_n_label: .asciiz "Enter n: "
	enter_numbers_label: .asciiz "Enter numbers one by one: "
	next_line: .asciiz "\n"

.text
main: 						# main functioin of the program
	li $v0, 4
	la $a0, enter_n_label
	syscall
	li $v0, 5
	syscall
	move $t0, $v0				# t0 = n
	li $t1, 0				# t1 is counter for getting n numbers
	li $t8, 0 				# t8 contins sum of number[i]
	li $t7, 0				# t7 contains sum of number[i] ^ 2
	
	li $v0, 4
	la $a0, enter_numbers_label
	syscall
	

first_loop:
	beq $t1, $t0, first_end_loop 		# if t1 == n go to the end
	li $v0, 5				# ready to get number from user
	syscall 
	add $t8, $v0, $t8			# t8 += number[i]
	mul $t2, $v0, $v0			
	add $t7, $t2, $t7			# t7 += number[i] ^ 2
	addi $t1, $t1, 1
	j first_loop
	
first_end_loop:
	
	li $v0, 4				# print average label
	la $a0, average_label
	syscall
	
	div $t8, $t8, $t0			# now t8 = E(X)
	li $v0, 1				# ready for print
	move $a0, $t8				# print t8
	syscall
	
	li $v0, 4
	la $a0, next_line			#print next line
	syscall
	
	li $v0, 4
	la $a0, variance_label			#print variance label
	syscall
	
	div $t7, $t7, $t0			# now t7 = E(X^2)
	mul $t8, $t8, $t8			# now t8 = E(x)^2
	sub $t7, $t7, $t8			# now t7 = Var(X)
	
	li $v0, 1
	move $a0, $t7				# print t7
	syscall
	
	li $v0, 10
	syscall
	

	
