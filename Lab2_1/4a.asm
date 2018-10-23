	.data
array:	.word	0, 1, 2, 3, 4, 5, 6, 7, 8, 9
kq:	.asciiz	"Ket qua la: "
	.text
	.globl	main
main:
	la	$a0, array
	lw	$t0, 12($a0)
	lw	$t1, 24($a0)
	addu	$t0, $t0, $t1
	la	$a0, kq
	li	$v0, 4
	syscall
	move	$a0, $t0
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall	
