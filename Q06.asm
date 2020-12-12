.data
	zero_float: .float 0.0
	one_float: .float 1.0

.text
main:						# main of the program
	lwc1 $f4, zero_float			# f4 is 0.0
	lwc1 $f6, one_float			# f6 is 1.0
	lwc1 $f8, one_float			# f8 is 1.0
	la $v0, 6				# read user float
	syscall
	add.s $f12, $f4, $f0 			# f12 = x
	
	
	la $v0, 5				
	syscall
	move $t0, $v0				# t0 is n
	li $t1, 1				# t1 is counter
	
	beq $t0, $t1, print_one
	
loop: 	
	beq $t1, $t0, end_loop			# if t1 == t0 go to end
	
	mul.s $f6, $f6, $f12 			# f6 = f6 * x
	add.s $f8, $f6, $f8			# f8 = 1 + x + x^2 + x^3 + ...
	addi $t1, $t1, 1
	j loop
	
end_loop:
	add.s $f12, $f8, $f4
	la $v0, 2
	syscall
	
	la $v0, 10
	syscall
	
print_one:
	la, $v0, 2
	lwc1 $f12, one_float
	syscall
	
	la $v0, 10
	syscall 
