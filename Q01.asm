.data
	plus: .asciiz "+"
	space: .asciiz " "
   	enter_n_label: .asciiz "Enter n: "
   	next_line: .asciiz "\n"
.text
	li $v0, 4					# print enter n label
	la $a0, enter_n_label
	syscall
	
	
	li $v0, 5					# get n from user
	syscall
	move $t0, $v0 					# t0 contains n
	
	# Print first n lines
	# In each iteration the loop print one line
	add $t1, $zero, $zero				# t1 is counter
first_loop:
	beq $t0, $t1, continue_to_second_loop 		# Branch to second loop if t1 == n
	add $t2, $zero, $zero 				# t2 = 0

# this function prints spaces for first n lines!
print_space_loop_first: 
	beq $t2, $t1, continue 				# if t1 == t2 go to continue
        li $v0, 4 					# ready for print 
        la $a0, space 					# pass space
        syscall 					# this syscall prints space
        addi $t2, $t2, 1 				# t2++
        j print_space_loop_first
                	
continue:
        add $t2, $zero, $zero 				# t2 = 0
        add $t3, $zero, $t0 				# t3 = n
        addi $t4, $zero, 2 				# t4 = 2
        mul $t3, $t4, $t3 				# t3 = 2 * n
        mul $t5, $t1, $t4 				# t5 = 2 * i
        sub $t5, $t3, $t5 				# t5 = 2n - 2i
        subi $t5, $t5, 1 				# t5 = 2n - 2i - 1
               
print_plus_loop: 
	beq $t2, $t5, first_loop_end 			# while t2 != t5
        li $v0, 4 					# ready for print 
        la $a0, plus 					# pass space
        syscall 					# this syscall prints space
        addi $t2, $t2, 1 				# t2++
        j print_plus_loop
               
                	
first_loop_end:
        li $v0, 4 					# ready for print
        la $a0, next_line 				# pass next line
        syscall 					# this syscall prints next line
	addi $t1, $t1, 1
	j first_loop
		
continue_to_second_loop:
	add $t1, $zero, $zero 				# t1 is counter i
	subi $t0, $t0, 1 				# t0 = n - 1
	j second_loop
		
second_loop:
	beq $t1, $t0, exit 				# while t1 != n - 1
	add $t2, $zero, $zero 				# t2 = 0
	sub $t6, $t0, $t1
	subi $t6, $t6, 1
	
print_space_second:
	beq $t2, $t6, continue_two 			# while t2 != t6
	li $v0, 4 					# ready for print 
	la $a0, space 					# pass space
        syscall 					# this syscall prints space
	addi $t2, $t2, 1 				# t2++
	j print_space_second
			
			
continue_two:
	addi $t3, $zero, 2 				# t3 = 2
	mul $t5, $t3, $t1 				# t5 = 2t1
	addi $t5, $t5, 3 				# t5 = 2t1 + 3
	add $t2, $zero, $zero 				# t2 = 0
	j print_plus_second
		
print_plus_second:
	beq $t2, $t5, second_loop_end
	li $v0, 4 					# ready for print 
        la $a0, plus 					# pass space
        syscall 					# this syscall prints space
        addi $t2, $t2, 1 				# t2++
        j print_plus_second
			
			
second_loop_end:
	li $v0, 4 					# ready for print
        la $a0, next_line 				# pass next line
        syscall 					# this syscall prints next line
	addi $t1, $t1, 1
	j second_loop
		
		
		
exit:
	li $v0, 10
	syscall
			

	
	
	
