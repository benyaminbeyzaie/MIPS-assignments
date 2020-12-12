.data
	enter_number_label: .asciiz "Enter a number:"
	enter_pow_label: .asciiz "Enter pow:"
	next_line: .asciiz "\n"
.text
	li $v0, 4
	la $a0, enter_number_label
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0					# s0 = x
	
	li $v0, 4
	la $a0, enter_pow_label
	syscall
	
	li $v0, 5
	syscall
	move $s1, $v0					# s1 = n
	
	jal pow
	
	move $a0, $v0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	



# we want to calcualte x ^ n
pow:							# takes s0 as x and s1 as n ===> x ^ n = v0
	addi $sp, $sp, -4					# allocate space
	sw $ra, 0($sp)					# save the return address
	li $t0, 0 					# t0 is a counter
	li $t1, 1					# temp answer will be stored in t0
	jal loop
	lw $ra, 0($sp)					# load the return address to ra
	addi $sp, $sp, 4				# unallocate space
	move $v0, $t1
	jr $ra
	
	
	
loop:
	beq $t0, $s1, end_loop				# if t0 = n end the loop
	mul $t1, $t1, $s0
	addi $t0, $t0, 1
	j loop

end_loop:
	jr $ra
	
	
	
	
	
	
	
	
