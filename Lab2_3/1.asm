	.data
input:	.asciiz	"Nhap iNum: "
output:	.asciiz	"Ket qua la: "
	.text
	.globl	main
main:
	la	$a0, input
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$a0, $v0
	jal	sum
	or	$s0, $v0, $zero
	la	$a0, output
	li	$v0, 4
	syscall
	or	$a0, $s0, $zero
	li	$v0, 1
	syscall
	j	exit
sum:
	li	$t0, 0
	li	$t1, 0
for:
	add	$t1, $t1, $t0
	addi	$t0, $t0, 1
	blt	$t0, $a0, for
	or	$v0, $t1, $zero
	jr	$ra
exit:
	li	$v0, 10
	syscall
