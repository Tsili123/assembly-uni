#Author: Odysseas Chatzopoulos
#Program: Tree Recursive Fibonacci

.text
.globl main

main:
    #Print prompt
    la $a0, prompt
    li $v0, 4
    syscall

    #Get number
    li $v0, 5
    syscall
    #Keep it in temporary register
    move $t0, $v0

    #Print number
    move $a0, $v0
    li $v0, 1
    syscall

    #Print new line
    la $a0, endl
    li $v0, 4
    syscall

    #Move argument to $a0 and call function
    move $a0, $t0
    jal fib

    #Print result
    move $a0, $v0
    li $v0, 1
    syscall

    #End of program
    li $v0, 10
    syscall

fib:
    #Base case
    bgt $a0, 1, recurse
    move $v0, $a0
    jr $ra
recurse:
    #Save $ra and $a0 to stack
    addi $sp, $sp, -12
    sw $ra, 0($sp)
    sw $a0, 4($sp)

    #Call fib(n - 1)
    addi $a0, $a0, -1
    jal fib
    #Save result to stack
    sw $v0, 8($sp)

    #Restore $a0 and call fib(n - 2)
    lw $a0, 4($sp)
    addi $a0, $a0, -2
    jal fib
    
    #Restore fib(n - 1) result and add to fib(n - 2)
    lw $t0, 8($sp)
    add $v0, $v0, $t0

    #Restore $ra and $a0 from stack
    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, $sp, 12

    #Return
    jr $ra
    
.data
prompt: .asciiz "Enter a number: "
endl: .asciiz "\n"