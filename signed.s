.text						
		.globl __start			
__start:


loop_parse:

		jal read_int
		move $t4,$v0
		beqz $t4,Exit

		
		and $t0,$t4,255
		srl $t4,$t4,8
		and $t1,$t4,255
		srl $t4,$t4,8
		and $t2,$t4,255
		srl $t4,$t4,8
		and $t3,$t4,255

		move $a0,$t0
		jal signext
		move $t5,$v0
		
		move $a0,$t1
		jal signext
		move $t6,$v0
		
		move $a0,$t2
		jal signext
		move $t7,$v0
		
		move $a0,$t3
		jal signext
		move $t8,$v0
		
		
		
		move $a0,$t5
		jal print_int
		jal print_nl
		
		move $a0,$t6
		jal print_int
		jal print_nl
		
		move $a0,$t7
		jal print_int
		jal print_nl
		
		move $a0,$t8
		jal print_int
		jal print_nl
		
		j loop_parse
		
signext:
		#Save $ra and $a0 to stack
		addi $sp, $sp, -8
		sw $t9, 0($sp)
		sw $s4, 4($sp)
		
		li $t9,128

		and $s4,$a0,128
		beq $s4,$t9,extension
		j esc
		

extension:
	or $a0,$a0,0xFFFFFF00
	esc:	move $v0,$a0
	addi $sp, $sp, 8
	lw $t9, 0($sp)
	lw $s4, 4($sp)
	jr $ra


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