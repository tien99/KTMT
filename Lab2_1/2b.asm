	.data
Const:	.word	66000
	.text
	.globl	main
main:
	lw	$t0, Const
	li	$t1, 30
	sll	$t2, $t1, 3
	sll	$t1, $t1, 1
	add	$t1, $t1, $t2
	add	$t0, $t0, $t1
	addi	$t0, $t0, -6000
	addi	$t0, $t0, 25
	ori	$s0, $t0, 0
	li	$v0, 10
	syscall
