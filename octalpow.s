.text
		.globl _start
__start:


main:	

loop:	jal read_int
		move $t0,$v0
		beqz $t0,nextch
		
		move $a0,$t0
		jal decoct
		move $a0,$v0
		jal print_int
		jal getnum
		move $a0,$v0
		jal print_endl
		j loop

nextch:

Exit: 		li $v0, 10
			syscall
			# end of main program
	
#read integer
read_int:
		li $v0,5
		syscall
		jr $ra
print_int:
	 li $v0,1 # print int
    syscall
	jr $ra
	
print_endl:
	la $a0, endl
	li $v0,4
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
	addi $sp,$sp,-28       # Adjust stack pointer
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
    addi $sp,$sp,28       # Adjust stack pointer
	jr $ra
	
print_pow:
	addi $sp,$sp,-12       # Adjust stack pointer
	sw $t9,8($sp)
	sw $t8,4($sp)
	sw $ra,0($sp)
	
	move $t8,$a0
	move $t9,$a1
	
	move $a0,$t8
	jal print_int
	
	la $a0, str1
	li $v0,4
	syscall
	
	move $a0,$t9
	jal print_int
	
	beqz $t9,out
	la $a0, str2
	li $v0,4
	syscall
out:	
	lw $t9,8($sp)
	lw $t8,4($sp)
	lw $ra,0($sp)
    addi $sp,$sp,12
	jr $ra
	
	
getnum:
	addi $sp,$sp,-24
	sw $ra,20($sp)
	sw $t5,16($sp)
	sw $t4,12($sp)
	sw $t3,8($sp)
	sw $t2,4($sp)
	sw $t1,0($sp)
	
	
	li $t2,10
	move $t1,$a0
	move $t4,$t1
	li $t5,0
	countdigits:
		div $t4,$t2
		mflo $t4
		addi $t5,$t5,1
		beqz $t4,printnumoct
	j countdigits

printnumoct:	


	la $a0, str0
	li $v0,4
	syscall
	
	#move $a0,$t5
	#jal print_int

	printloopoct:
		addi $t5,$t5,-1
		move $a0,$t5
		jal power10
		move $t2,$v0
		div $t1,$t2
		mflo $t2
		mfhi $t1
		
		move $a0,$t2
		move $a1,$t5
		jal print_pow
		beqz $t1,nx
	j printloopoct
	
nx:
	move $v0,$t5
	
	lw $ra,20($sp)
	lw $t5,16($sp)
	lw $t4,12($sp)
	lw $t3,8($sp)
	lw $t2,4($sp)
	lw $t1,0($sp)
    addi $sp,$sp,24       # Adjust stack pointer
	
	jr $ra 
	
	
.data
endl: .asciiz "\n"
str0: .asciiz "power-sum="
str1: .asciiz "*8^"
str2: .asciiz "+"