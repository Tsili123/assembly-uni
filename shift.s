.text
		.globl _start
__start:		

main:
	jal read_int
	move $a0,$v0
	jal print_int
	move $t0,$a0#number
	
	jal read_int
	move $a0,$v0
	jal print_int
	move $t1,$a0#shift amount
	
loop:
		andi $t3,$t0,1
		sll $t3,$t3,31
		srl $t0,$t0,1 #dont miss most significant bit ,put the instruction before the or
		or $t0,$t3,$t0
		sub $t1,$t1,1
		beqz $t1,next
		j loop	
next:
		move $a0,$t0
		jal print_int
		
Exit: 		li $v0, 10
			syscall
	# end of main program
	
#functions

#read integer
read_int:
		li $v0,5
		syscall
		jr $ra

print_int:  	
		li $v0, 1			#Function that prints the integer (REMEMBER: argument $a0=integer)
		syscall
		jr $ra
		
	
.data