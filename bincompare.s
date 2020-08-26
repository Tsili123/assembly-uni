.text
		.globl _start
__start:


nextit:	
	    #display message
		li $v0,4
		la $a0,message1
		syscall
		
		jal read_int
		move $t0,$v0
		
		#display message
		li $v0,4
		la $a0,message2
		syscall
		
		jal read_int
		move $t1,$v0
		
		li $t2,0 #counter
		
		li $t4,15
		bgt $t1,$t4,error
		li $t4,7
		bgt $t1,$t4,d4
		li $t4,3
		bgt $t1,$t4,d3
		li $t4,1
		bgt $t1,$t4,d2
		li $t5,1
		j loop1
		
d4: 	li $t5,4
		j loop1
d3: 	li $t5,3
		j loop1
d2: 	li $t5,2
		j loop1
		
loop1:
	beqz $t0,next2
	li $t7,32
	move $a0,$t5
	jal print_int
	xor  $t3,$t1,$t0
	sub  $t6,$t7,$t5
	sll  $t3,$t3,$t6
	srl $t0,$t0,1
	beqz $t3,count
	j loop1

count:
	addi $t2,$t2,1
	j loop1
	
error:
		#display message
		li $v0,4
		la $a0,message4
		syscall
		
j nextit

next2: 
		#display message
		li $v0,4
		la $a0,message3
		syscall
		
		move $a0,$t2
		jal print_int

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
				
.data
input_string: .space 21
message1: 	.asciiz 	"\nEnter p number:\n"
message2: 	.asciiz 	"\nEnter k value:\n"
message3: 	.asciiz 	"\nresult:\n"
message4: 	.asciiz 	"\nwrong k:\n"