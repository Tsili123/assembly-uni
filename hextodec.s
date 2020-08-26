.text
		.globl _start
__start:
	
	li $s6,0
	li $s5,0
	#display message
	li $v0,4
	la $a0,message1
	syscall
	
	# Get string from user and SAVE IT
     li $v0,8 #get string input
     la $a0, input_string #load byte space into address
     li $a1, 50 # allot the byte space for string
     move $t0,$a0 #save string to t0
     syscall
	
	#print the string
    la $a0, input_string #reload byte space to primary address
    move $a0,$t0 # primary address = t0 address (load pointer)
    li $v0,4 # print string
    syscall

	la $s1,input_string
	li $s2,-1
	
loopdigits:
	lbu $t1,0($s1)
	beqz $t1,reset
	addi $s1,$s1,1
	addi $s2,$s2,1 #digit count
	j loopdigits
	
reset:
	#print the string
    la $s1, input_string #reload byte space to primary address

loop:	
	#li $t5,3
	#move $a0,$t5
	#jal print_int

	sub $s2,$s2,1
	lbu $t1,0($s1)

	move $a0,$t1
	jal hextodec
	move $s3,$v0
	
	move $a0,$s2
	jal power16
	move $s4,$v0
	
	mult $s3,$s4
	mflo $s3 #result
	
	add $s5,$s5,$s3 #add to current sum
	
	add $s1,$s1,1
	
	##move $a0,$s5
	##jal print_int
	
	beqz $s2,nextch
	j loop
	
	
nextch:
	move $a0,$s5
	jal print_int

j Exit


power16:
	addi $sp,$sp, -12    # Adjust stack pointer
	sw $t9,8($sp)
	sw $t3,4($sp)
    sw $t4,0($sp)        # Save $t3,$t4 on the stack
	
	li $t3,1
	li $t9,16
	move $t4,$a0
	beqz $t4,next0
	
	loop2:
		mult $t3,$t9
		mflo $t3
		add $t4,$t4,-1
		beqz $t4,next
		j loop2
	next0:
	li $t4,1
	move $v0,$t4
	lw $t9,8($sp)
	lw $t3,4($sp)
	lw $t4,0($sp)
    addi $sp,$sp,12        # Adjust stack pointer
	jr $ra
	next:
	move $v0,$t3
	lw $t9,8($sp)
	lw $t3,4($sp)
	lw $t4,0($sp)
    addi $sp,$sp,12        # Adjust stack pointer
	jr $ra	


hextodec:
	addi $sp,$sp, -16    # Adjust stack pointer
	sw $t9,12($sp)
	sw $t2,8($sp)
	sw $t3,4($sp)
    sw $t4,0($sp)        # Save $t3,$t4 on the stack
	
	move $t9,$a0
	
	li $t2,48
	li $t3,57
	
	
	blt $t9,$t2,outdec
	bgt $t9,$t3,outdec
	
	sub $t4,$t9,$t2
	move $v0,$t4
	
	outall:
	lw $t9,12($sp)
	lw $t2,8($sp)
	lw $t3,4($sp)
	lw $t4,0($sp)
    addi $sp,$sp,16        # Adjust stack pointer
	
	jr $ra


outdec:
	li $t2,65
	li $t3,70
	
	blt $t9,$t2,outall
	bgt $t9,$t3,outall
	
	li $t2,55
	sub $t4,$t9,$t2
	move $v0,$t4

	j outall
	
	

Exit: 		li $v0, 10
			syscall
			# end of main program

pr_endl:
		li $v0, 4
		la $a0, endl
		syscall
		jr $ra

print_int:  	li $v0, 1			#Function that prints the integer (REMEMBER: argument $a0=integer)
				syscall
				jr $ra

.data
endl: .asciiz "\n"
input_string: .space 50
message1: 	.asciiz 	"\nEnter a string:\n"
message2: 	.asciiz 	"your result:\n"
message0: 	.asciiz 	" binary digits\n"
message8: 	.asciiz 	" octal digits\n"
message10: 	.asciiz 	" decimal digits\n"