.text
		.globl _start
__start:	

	# Get string from user and SAVE IT
     li $v0,8 #get string input
     la $a0, input_string #load byte space into address
     li $a1, 10 # allot the byte space for string
     move $t0,$a0 #save string to t0
     syscall

	#print the string
    la $a0, input_string #reload byte space to primary address
    move $a0,$t0 # primary address = t0 address (load pointer)
    li $v0,4 # print string
    syscall
	
	li $t2,48
	li $t5,8
	li $t6,-1
	la $s1,input_string 
loop:	lb $t1,0($s1)
		sub $t1,$t1,$t2
		move $a0,$t5
		jal power10
		mult $t1,$v0
		mflo $t7
		add $t8,$t8,$t7
		addi $t5,$t5,-1
		addi $s1,$s1,1
		beq $t5,$t6,label
		j loop
label:

	#print the string
    la $a0, message2 #reload byte space to primary address
    li $v0,4 # print string
    syscall
	
	move $a0,$t8 # primary address = t0 address (load pointer)
    li $v0,1 # print int
    syscall
	
	move $a0,$t8
	jal decoct
		
	move $a0,$v0 # primary address = t0 address (load pointer)
    li $v0,1 # print int
    syscall
	
	
Exit: 		li $v0, 10
			syscall
	# end of main program
	
#read integer
read_int:
		li $v0,5
		syscall
		jr $ra
		
power10:
	addi $sp,$sp, -12    # Adjust stack pointer
	sw $t9,8($sp)
	sw $t3,4($sp)
    sw $t4,0($sp)        # Save $t3,$t4 on the stack
	
	li $t3,1
	li $t9,10
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
	li $t6,0
	li $t9,0
	loop3: #low piliko high upoloipo
		div $t3,$t4
		mflo $t3
		mfhi $t9
		move $a0,$t8
		jal power10
		mult $v0,$t9
		mflo $t7
		add  $t6,$t6,$t7
		addi $t8,$t8,1
		beqz $t3,label3
	j loop3
	
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
	
.data
input_string: .space 10
message1: 	.asciiz 	"Enter a string:\n"
message2: 	.asciiz 	"your final string:\n"