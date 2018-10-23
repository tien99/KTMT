	.data
Const:	.word	66000
	.text
	.globl	main
main:
	lw	$t0, Const
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, 30
	addi	$t0, $t0, -6000
	addi	$t0, $t0, 25
	ori	$s0, $t0, 0
	li	$v0, 10
	syscall
