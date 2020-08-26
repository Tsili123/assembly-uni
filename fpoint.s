.text
		.globl _start
__start:		

main:
	
	lwc1 $f0,zeroAsFloat
	add	$t1,0
	add $t2,8
	add $t4,127
	
	
	#display message
	li $v0,4
	la $a0,message
	syscall
	
	jal read_float
	jal print_float
	
	mfc1  $t0,$f0
	
	sll $t0,$t0,1
	srl	$t0,$t0,24
	sub $t0,$t0,$t4
	
loop:
		andi $t3,$t0,1
		beq	 $t3,1,count
loop1:	srl	$t0,$t0,1
		sub $t2,$t2,1
		beqz $t2,next
		j loop

next:
		jal print_endl
		
		#display message
		li $v0,4
		la $a0,message2
		syscall
		
		la $a0,0($t1)
		jal print_int
		
Exit: 		li $v0, 10
			syscall
	# end of main program
	
	
#Fuctions
count: 
		add $t1,$t1,1
		j loop1
	
read_float: 	li $v0, 6			#Function that reads a float number (result: float in $f0)
				syscall	
				jr $ra
				
print_float:	li $v0, 2
				add.s $f12,$f0,$f4
				syscall
				jr $ra
				
print_int:  	li $v0, 1			#Function that prints the integer (REMEMBER: argument $a0=integer)
				syscall
				jr $ra
# Print \n
print_endl:		li	$v0,4		# print_string syscall code = 4
				la	$a0, endl
				syscall
				jr $ra

	.data
message: 	.asciiz 	"Enter a float number:"
message2: 	.asciiz 	"\nThe number of aces is:"
endl:		.asciiz     "\n"
zeroAsFloat:	.float	0.0
