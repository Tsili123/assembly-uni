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

loop:	
	srl $t1,$t0,28
	j CHECKTYPE
	CONT:	sll $t0,$t0,4
			beqz $t0,Exit
	j loop

	
Exit: 		li $v0, 10
			syscall
			# end of main program
			

CHECKTYPE:
	li $s0,0
	li $s1,1
	li $s2,2
	li $s3,3
	li $s4,4
	li $s5,5
	li $s6,6
	li $s7,7
	li $t2,8
	li $t3,9
	li $t4,10
	li $t5,11
	li $t6,12
	li $t7,13
	li $t8,14
	li $t9,15
	
	
	beq $t1,$s0, PRINT_0
	beq $t1,$s1, PRINT_1
	beq $t1,$s2, PRINT_2
	beq $t1,$s3, PRINT_3
	beq $t1,$s4, PRINT_4
	beq $t1,$s5, PRINT_5
	beq $t1,$s6, PRINT_6
	beq $t1,$s7, PRINT_7
	beq $t1,$t2, PRINT_8
	beq $t1,$t3, PRINT_9
	beq $t1,$t4, PRINT_10
	beq $t1,$t5, PRINT_11
	beq $t1,$t6, PRINT_12
	beq $t1,$t7, PRINT_13
	beq $t1,$t8, PRINT_14
	beq $t1,$t9, PRINT_15

PRINT_0:
	la $a0,zero
	jal print_string
	j CONT

PRINT_1:
	la $a0,one
	jal print_string
	j CONT


PRINT_2:
	la $a0,two
	jal print_string
	j CONT 


PRINT_3:
	la $a0,three
	jal print_string
	j CONT

PRINT_4:
	la $a0,four
	jal print_string
	j CONT

PRINT_5:
	la $a0,five
	jal print_string
	j CONT

PRINT_6:
	la $a0,six
	jal print_string
	j CONT

PRINT_7:
	la $a0,seven 
	jal print_string
	j CONT
	
PRINT_8:
	la $a0,eight 
	jal print_string
	j CONT
	
PRINT_9:
	la $a0,nine 
	jal print_string
	j CONT
	
PRINT_10:
	la $a0,ten
	jal print_string
	j CONT
	
PRINT_11:
	la $a0,eleven
	jal print_string
	j CONT
	
PRINT_12:
	la $a0,twelve
	jal print_string
	j CONT
	
PRINT_13:
	la $a0,thirteen
	jal print_string
	j CONT
	
PRINT_14:
	la $a0,fourteen
	jal print_string
	j CONT
	
PRINT_15:
	la $a0,fifteen
	jal print_string
	j CONT

#read integer
read_int:
		li $v0,5
		syscall
		jr $ra
print_int:  	li $v0, 1			#Function that prints the integer (REMEMBER: argument $a0=integer)
				syscall
				jr $ra

print_string:
	li $v0, 4			# print a0 (address of string)
	syscall
jr $ra

	
.data
input_string: .space 21
message1: 	.asciiz 	"\nEnter decimal number:\n"
message2: 	.asciiz 	"\nEnter k value:\n"
message3: 	.asciiz 	"\nresult:\n"
message4: 	.asciiz 	"\nwrong k:\n"
zero: .asciiz "0"
one: .asciiz "1"
two: .asciiz "2"
three: .asciiz "3"
four: .asciiz "4"
five: .asciiz "5"
six: .asciiz "6"
seven: .asciiz "7"
eight: .asciiz "8"
nine: .asciiz "9"
ten: .asciiz "A"
eleven: .asciiz "B"
twelve: .asciiz "C"
thirteen: .asciiz "D"
fourteen: .asciiz "E"
fifteen: .asciiz "F"