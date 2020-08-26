###################################################
# #
# text segment # September 2017
# #
###################################################
 .text
 .globl __start
__start:

loop:	
	la $a0, giveInt
	jal printStr
	
	li $v0, 5
	syscall
	
	move $t9, $v0
	
	move $a0, $v0
	jal printInt	
	
	jal printEndl
	
	beqz $t9, end
	move $s1, $t9
	li $t0, 10
	li $t2, 0
	
	loop2:
		div $s1, $t0
		mfhi $t1
		mflo $s1
		sb $t1, spaces($t2)
		addi $t2, 1
		bnez $s1, loop2	
	
	print:
		addi $t2, $t2, -1
		
		lb $a0, spaces($t2)
		jal printInt
			
		la $a0, star
		jal printStr
	
		la $a0, dinami
		jal printStr
		
		
		move $a0, $t2
		jal printInt
		
		bnez $t2, addsymbol
			
		jal printEndl
		
	j loop
	
addsymbol:
	la $a0, addsym
	jal printStr
	j print
	
end:
	li $v0, 10
	syscall
	
#################################################
# #
# Functions #
# #
#################################################
printInt:
			li $v0, 1
			syscall
			jr $ra	
printStr:
			li $v0, 4		
			syscall
			jr $ra
	
printEndl:  la $a0, endl
			li $v0, 4		
			syscall
			jr $ra
			
#################################################
# #
# data segment #
# #
#################################################
.data
spaces:	.asciiz "                                " #32+\0
star:	.asciiz "*"
dinami:	.asciiz "10^"
addsym:	.asciiz "+"
giveInt: .asciiz "Give integer:"
endl:	.asciiz "\n"
#################################################
# #
# End of File #
# #
#################################################
