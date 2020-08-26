.text
.globl __start

__start:

main:
	#display message
		li $v0,4
		la $a0,message1
	syscall
		
	jal read_int
	move $t0,$v0
	beqz $t0,Exit
	
	move $a0,$t0
	jal decoct
	move $a0,$v0
	
	#jal print_endl
	jal print_int

	j main
	
Exit: 		li $v0, 10
			syscall
			# end of main program


decoct:
	addi $sp,$sp,-24       # Adjust stack pointer
	sw $t9,20($sp)
	sw $t8,16($sp)
	sw $t7,12($sp)
	sw $t6,8($sp)
	sw $t3,4($sp)
	sw $t4,0($sp)
	sw $ra,24($sp)
	
	move $t3,$a0
	li $t4,8
	li $t8,0
	li $t6,-1
	loop3: #low piliko high upoloipo
		div $t3,$t4
		mflo $t3
		mfhi $t9
		bgt $t9,$t6,label
		label2:
		beqz $t3,label3
	j loop3
	
	label:
		move $t6,$t9
	j label2
	
	label3:
	move $v0,$t6
	
	lw $ra,24($sp)
	lw $t9,20($sp)
	lw $t8,16($sp)
	lw $t7,12($sp)
	lw $t6,8($sp)
	lw $t3,4($sp)
	lw $t4,0($sp)
    addi $sp,$sp,24       # Adjust stack pointer
jr $ra


#read integer
read_int:
		li $v0,5
		syscall
		jr $ra
print_int:  	li $v0, 1			#Function that prints the integer (REMEMBER: argument $a0=integer)
				syscall
				jr $ra

.data
input_string: .space 21
message1: 	.asciiz 	"\nEnter decimal number:\n"
message2: 	.asciiz 	"\nEnter k value:\n"
message3: 	.asciiz 	"\nresult:\n"
message4: 	.asciiz 	"\nwrong k:\n"