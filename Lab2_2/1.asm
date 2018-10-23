	.data
a:	.word	0
i:	.asciiz	"Input a: "
t:	.asciiz	"Computer Architecture is so easy!"
f:	.asciiz	"you are right!"
	.text
	.globl	main
main:
	la	$a0, i
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	bgez	$v0, true
	la	$a0, f
	j	exit
true:	la	$a0, t
exit:	li	$v0, 4
	syscall
	li	$v0, 10
	syscall