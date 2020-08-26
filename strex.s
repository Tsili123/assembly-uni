.text
		.globl _start
__start:		
	
	
loop1:

	#display message
	li $v0,4
	la $a0,message1
	syscall

	# Get string from user and SAVE IT
     li $v0,8 #get string input
     la $a0, input_string #load byte space into address
     li $a1, 21 # allot the byte space for string
     move $t0,$a0 #save string to t0
     syscall
	 
	#print the string
    la $a0, input_string #reload byte space to primary address
    move $a0,$t0 # primary address = t0 address (load pointer)
    li $v0,4 # print string
    syscall
	
	#display message
	li $v0,4
	la $a0,message2
	syscall
	
	jal read_int#k amount
	move $t1,$v0
	la $s1,input_string
	beqz $t1,Exit
	
	add $t2,$t1,$s1
	li $t3,42
	
loop:
	sb $t3,0($t2) #store char * to string
	add $t2,$t2,1 #increase pointer
	lb $t5,0($t2) #get next char from string and compare
	beqz $t5,nextch # check if we reached end
	j loop
	
nextch:	#display message
	li $v0,4
	la $a0,message3
	syscall
	
	#print the string
    la $a0, input_string #reload byte space to primary address
    move $a0,$t0 # primary address = t0 address (load pointer)
    li $v0,4 # print string
    syscall

j loop1


Exit: 		li $v0, 10
			syscall
			# end of main program
	
#read integer
read_int:
		li $v0,5
		syscall
		jr $ra
	 
.data
input_string: .space 21
message1: 	.asciiz 	"\nEnter a string:\n"
message2: 	.asciiz 	"\nEnter k value:\n"
message3: 	.asciiz 	"your final string:\n"