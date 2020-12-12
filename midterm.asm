.data

enter_length_of_first_label: 	.asciiz "Enter length of vector: "
enter_each_label_first:  	.asciiz "Enter first vector each element one by one: "
enter_each_label_second:  	.asciiz "Enter second vector each element one by one: "
error_label: 			.asciiz "Input is not valid! "
ans_label:			.asciiz "A.B is: "

.text
	addi $v0, $zero, 4					# ready to print string
	la   $a0, enter_length_of_first_label			# pass enter_length_of_first_label as an argument
	syscall							# print!
	
	addi $v0, $zero, 5					# ready to get a number
	syscall							# get number
	add  $s0, $v0, $zero					# s0 is length of vector
	
	ble  $s0, $zero, exit					# if n <= 0 then exit and print error
	
	add  $s1, $zero, $gp					# s1 is address of A
	mul  $t0, $s0, 4					# space for A (each element takes 4 bytes)
	add  $gp, $gp, $t0					# allocate space using global pointer 
	
	add  $s2, $gp, $zero					# s2 is address of B
	add  $gp, $gp, $t0					# allocate space for B
	
	addi $v0, $zero, 4					# ready to print string
	la   $a0, enter_each_label_first			# pass enter_each_label_first as argument
	syscall							# print
	
	add  $t1, $zero, $zero					# t1 is counter for length of vector one
	
loop_one:
	beq  $t1, $t0, end_loop_one				# if i == n then go to end_loop
	addi $v0, $zero, 5					# get A[i] from user 
	syscall
	add  $t2, $t1, $s1					# t2 is place of A[i]
	sw   $v0, 0($t2)					# save A[i]
	addi $t1, $t1, 4					# t1 = t1 + 4
	j    loop_one

end_loop_one:
	addi $v0, $zero, 4					# ready to print string
	la   $a0, enter_each_label_second			# pass enter_each_label_second as argument
	syscall
	add  $t1, $zero, $zero	 				# t1 is counter for length of vector two
	
loop_two:
	beq  $t1, $t0, end_loop_two				# if i == n then go to end_loop
	addi $v0, $zero, 5					# get A[i] from user 
	syscall
	add  $t2, $t1, $s2					# t2 is place of B[i]
	sw   $v0, 0($t2)					# save A[i]
	addi $t1, $t1, 4					# t1 = t1 + 4
	j    loop_two
	
end_loop_two:
	add  $a0, $zero, $t0					# pass t0 which is n as argument0
	add  $a1, $zero, $s1					# pass s1 which is A address as argument1
	add  $a2, $zero, $s2					# pass s2 which is B address as argument2
	jal  function
	
	add  $t2, $zero, $v0					# t2 is A.B
	
	addi $v0, $zero, 4					# ready to print string
	la   $a0, ans_label					# pass ans_label as argument
	syscall							# print
		
	addi $v0, $zero, 1					# ready to print number
	add  $a0, $zero, $t2					# pass t2 which is answer as argument
	syscall 						# pritn
		
	li   $v0, 10						# ready to exit
	syscall							# exit
	
	####### end of the program! #######

#################################################
# this function takes a0 as length of vectors   #
# takes a1 as address of first vector           #
# takes a2 as address of second vector          #
# retunr A.B as answer in v0			 #
#################################################
function:
	addi $t1, $zero, 0					# t1 is counter for length of vector
	addi $v0, $zero, 0					# v0 is A.B

loop_three:
	beq  $t1, $a0, end_loop_three				# if i == n then go to end_loop
	add  $t2, $t1, $a1					# t2 is address of A[i]
	lw   $t3, 0($t2)					# t3 is A[i]
	
	add  $t2, $t1, $a2					# t2 is address of B[i]
	lw   $t4, 0($t2)					# t4 is B[i]
	
	mul  $t4, $t4, $t3					# t4 = A[i] * B[i]
	
	add  $v0, $v0, $t4					# ans = ans + t4
	addi $t1, $t1, 4					# t1 = t1 + 4
	j    loop_three

end_loop_three:
	jr   $ra						# end of function and return 
	
	
exit:
	addi $v0, $zero, 4					# ready to print string
	la   $a0, error_label					# pass error_label as argument
	syscall							# print
	
	addi $v0, $zero, 10					# ready to exit
	syscall							# exit
	
	
	
	
	
	
