.text						
	.globl __start			
__start:

	li $t0,0 #1st byte leftmost
	li $t1,0 #2st byte xx
	li $t2,0 #3rd byte xx
	li $t3,0 #4th byte xx

	li $t6,4

	li $s0,1 #1st byte leftmost
	li $s1,2 #2st byte xx
	li $s2,3 #3rd byte xx
	li $s3,4 #4th byte xx

loop_parse:

		jal read_int
		move $t4,$v0
		beqz $t4,Exit
		
		inner_l:		
			beq $t6,$s3,first_b
			beq $t6,$s2,second_b
			beq $t6,$s1,third_b
			beq $t6,$s0,fourth_b
			
			first_b:	or $t0,$t4,256
			j next2
			second_b:	or $t1,$t4,256
			j next2
			third_b:	or $t2,$t4,256
			j next2
			fourth_b:	and $t3,$t4,255
			j next2
			
			next2: srl $t4,$t4,8
			add $t6,$t6,-1
			beqz $t6,cv
		j inner_l
		
	cv:	#j convert
		
		
		out:
		move $a0,$t0
		jal print_int
		jal print_nl
		
		move $a0,$t1
		jal print_int
		jal print_nl
		
		move $a0,$t2
		jal print_int
		jal print_nl
		
		move $a0,$t3
		jal print_int
		jal print_nl
		
	j loop_parse

convert:
	#perform sign extension
	li $s5,128
	li $s6,1
	
	srl $s0,$t0,7
	and $s2,$s6,$s0
	beq $s2,$s6,lb1
	
	lb1: #or $t0,$t0,0xFFFF
	
	
	
	
	#move $t7,$t0
	# lb1:
	# and $t8,$t1,$s5
	# beq $t8,$zero,lb2
	# lb $t8,0($t1)
	
	# lb2:
	# and $t9,$t2,$s5
	# beq $t9,$zero,lb2
	# lb $t9,0($t2)
	
	# lb3:
	# and $s7,$t3,$s5
	# beq $s7,$zero,next3
	# lb $s7,0($t3)
	
	#next3:
	j out


compare:
	#find sum
	li $t7,0
	add $t7,$t7,$t0
	add $t7,$t7,$t1
	add $t7,$t7,$t2
	add $t7,$t7,$t3
	
	
	#find max
	li $s4,0
	loop_max:
	
	j loop_max





Exit: 		li $v0, 10
			syscall
			# end of main program

#read integer
read_int:
		li $v0,5
		syscall
		jr $ra
print_int:  	li $v0, 1			#Function that prints the integer (REMEMBER: argument $a0=integer)
				syscall
				jr $ra
print_nl:
	la $a0,newline
	li $v0,4
	syscall
	jr $ra

.data
newline : .asciiz "\n"