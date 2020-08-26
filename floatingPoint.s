.text
.globl __start
__start:
	
li $t0, 0
la $a0, b0
l.s $f1, ($a0)

j loop

exit:
li $v0, 10
syscall

loop:
	la $a0, giveFloat
	jal pr_str

	li $v0, 6
	syscall
	
	mov.s $f12, $f0
	
	jal pr_float
	jal pr_endl
	
	c.eq.s $f0, $f1 #check if number is zero
	bc1t exit
	
	mov.s $f2, $f0
	
	cvt.w.s $f2, $f2
	mfc1 $t1, $f2 #sto t1 einai o float pou kaname integer	
	mtc1 $t1, $f3 #sto f3 einai o integer (t1) pou kaname float
	cvt.s.w $f3, $f3
	c.eq.s $f0, $f3
	
	bc1t y
	
	n:
	la $a0, no
	
	li $v0,4
	syscall
	
	j loop
	
	y:
	la $a0, yes
	li $v0,4
	syscall

j loop

pr_str:
		li $v0, 4
		syscall
		jr $ra

pr_endl:
		li $v0, 4
		la $a0, endl
		syscall
		jr $ra

pr_int:
		li $v0, 1
		syscall
		jr $ra

pr_float:
		li $v0, 2
		syscall
		jr $ra


.data
endl: .asciiz "\n"
b0: .float 0.0
yes: .asciiz "yes, it is integer\n"
no: .asciiz "no, it is NOT integer\n"
giveFloat: .asciiz "Give float: "
	
	#cvt.s.w $f2, $f2	
	#c.eq.s $f0, $f2

