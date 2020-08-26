.text
		.globl _start
__start:		

main:
		add $t2,$t2,1
		
loop:	jal read_float 
		#add.s $f5,$f0,$f4
		
		mfc1  $t0,$f0 #i want to put value to integer register
		beqz $t0,label
		#how to get the sign of the exponent
		sll $t0,$t0,1
		srl	$t0,$t0,31
		andi $t1,$t0,1
	
		beq $t1,$t2,skip #beq only regs as args
		add $t3,$t3,1
skip:	j loop
label:	
		move $a0,$t3
		jal print_int
		
Exit: 		li $v0, 10
			syscall
	# end of main program

#fuctions
read_float: 	li $v0, 6			#Function that reads a float number (result: float in $f0)
				syscall	
				jr $ra
				
print_float:	li $v0, 2
				add.s $f12,$f0,$f4
				syscall
				jr $ra
				
print_int:  	
		li $v0, 1			#Function that prints the integer (REMEMBER: argument $a0=integer)
		syscall
		jr $ra