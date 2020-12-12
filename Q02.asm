.data
theString: .space 128
theWord: .space 32
inputStringLabel: .asciiz "Enter a String: "
inputACharLabel: .asciiz "Enter a char: "
inputAWordLabed: .asciiz "Enter a word: " 
matchedCharLabel: .asciiz "Matched chars: "
matchedWordsLabe: .asciiz "Matched words: "
nextLine: .asciiz "\n"

.text
main:
	li $v0, 4
	la $a0, inputStringLabel
	syscall
	
	li $v0, 8					# ready to read a String
	la $a0, theString				# buffer
	li $a1, 128					# the size of the String
	syscall
	
	
	li $v0, 4
	la $a0, inputACharLabel
	syscall
	
	li $v0, 12					# get a charachter from user
	syscall
	move $s0, $v0					# store the char to s0
	
	li $v0, 4
	la $a0, inputAWordLabed
	syscall
	
	li $v0, 8
	la $a0, theWord
	li $a1, 32
	syscall
	
	li $t0, 0					# t0 is counter
	la $s1, theString				# s1 is the string address
	la $s2, theWord					# s2 is the address of word
	li $s3, 0					# counter for mathed characters!
	li $s4, 0					# counter fo matched words.
	
loop_one:
	add $t1, $s1, $t0				# t1 = string[i]
	lbu  $t2, ($t1)					# load the char i into t2
	beq $t2, $zero, exit_first_loop			# if we reached end of the string exit the loop
	beq $t2, $s0, char_matched			# if we found a mathed char jump to char math
	addi $t0, $t0, 1
	j loop_one
	
	
	
char_matched:
	addi $s3, $s3, 1				# match counter++
	addi $t0, $t0, 1				# i++
	j loop_one
	
exit_first_loop:
	j start_second_loop
	
start_second_loop:
	li $t0, 0					# t0 is counter for length of main string
	li $t1, 0					# t1 will be used as address of a char in main string
	

second_loop:
	add $t1, $s1, $t0				# address of i's char in main string stored in t1
	lbu  $t2, 0($t1)					# t2 contain the main string[i]
	beq $t2, $zero, exit_second_loop		# end of main string
	lbu  $t3, 0($s2)					# t3 contain the first char of word
	beq $t3, $t2, first_char_matched		# if first char of word is equal to string[i] then go check other chars
	addi $t0, $t0, 1
	j second_loop

first_char_matched:
	li $t5, 0					# t5 is counter for length of word

char_match_loop:
	add $t4, $s2, $t5				# address of char 
	lbu  $t6, 0($t4)					# t6 = word[i]
	beq $t6, $zero, increment_i_and_back		# if we reached end of the word go to the main loop and add a mathed word
	add $t7, $t1, $t5				# t7 is address of char in main string 
	lbu  $t8, 0($t7)					# t8 is char in main string
	beq $t8, $zero, increment_i_without
	bne $t8, $t6, increment_i_without		# if a char dose not math back to main loop
	addi $t5, $t5, 1
	j char_match_loop
	
increment_i_without:
	addi $t0, $t0, 1
	j second_loop
	

increment_i_and_back:
	addi $s4, $s4, 1
	addi $t0, $t0, 1
	j second_loop
	
	
exit_second_loop:
	la $a0, matchedCharLabel
	li $v0, 4
	syscall 
	 
	move $a0, $s3					# print matched chars!
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, nextLine
	syscall
	
	la $a0, matchedWordsLabe
	li $v0, 4
	syscall 
	 
	move $a0, $s4					# print matched words!
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	

	
	
	
