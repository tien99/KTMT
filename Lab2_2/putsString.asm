	.data
string:	.asciiz	"Day la chuoi can xuat!"
	.text
	.globl	main
main:
	li	$v0, 11
	la	$t1, string
while:
	lb	$a0, 0($t1)
	beq	$a0, $zero, exit
	syscall
	addi	$t1, $t1, 1
	j	while
exit:
	li	$v0, 10
	syscall
	
