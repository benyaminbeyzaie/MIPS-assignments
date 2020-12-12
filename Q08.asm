.data
	enter_a_label: .asciiz "Enter a: "
	enter_b_label: .asciiz "Enter b: "
	enter_c_label: .asciiz "Enter c: "
	enter_x_label: .asciiz "Enter x: "
	
.text
	# print label
	li $v0, 4
	la $a0, enter_a_label
	syscall

	# get the nubmer
	li $v0, 5
	syscall
	move $s0, $v0					# s0 = a
	
	# print label
	li $v0, 4
	la $a0, enter_b_label
	syscall

	# get the nubmer
	li $v0, 5
	syscall
	move $s1, $v0					# s1 = b
	
	# print label
	li $v0, 4
	la $a0, enter_c_label
	syscall

	# get the nubmer
	li $v0, 5
	syscall
	move $s2, $v0					# s2 = a
	
	# print label
	li $v0, 4
	la $a0, enter_x_label
	syscall

	# get the nubmer
	li $v0, 5
	syscall
	move $s3, $v0					# s3 = x
	
	jal function					# call the function
	move $a0, $t0					# move the value of function to a0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
	
function:						# take s0, s1, s2, s3 as parameters
	mul $t0, $s3, $s3				# t0 = x ^ 2
	mul $t0, $t0, $s0				# t0 = a * x ^ 2
	mul $t1, $s1, $s3				# t1 = b * x
	add $t0, $t0, $t1				# t0 = a * x ^ 2 + b * x
	add $t0, $t0, $s2				# t0 = a * x ^ 2 + b * x + c
	jr $ra
	
	
	
	
	
	
	
	
	