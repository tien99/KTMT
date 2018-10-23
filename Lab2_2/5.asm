	.data
found:	.asciiz	"Tim thay ky tu tai vi tri: "
chrArr:	.asciiz	"Computer Architecture CSE-HCMUT"
chr:	.word	'e'
pos:	.word	0
	.text
	.globl	main
main:
	la	$a0, found
	li	$v0, 4
	syscall
	la	$a0, chrArr
	addi	$t1, $zero, 0
	lw	$t2, chr
while:
	add	$a1, $a0, $t1
	lb	$t0, 0($a1)
	beq	$t0, $t2, done
	beq	$t0, $zero, null
	addi	$t1, $t1, 1
	j	while
null:
	li	$t1, -1
done:
	move	$a0, $t1
	li	$v0, 1
	syscall
exit:
	li	$v0, 10
	syscall
