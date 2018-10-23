	.data
a:	.word	0
b:	.word	0
c:	.word	0
nhap_a:	.asciiz	"Nhap a: "
nhap_b:	.asciiz	"Nhap b: "
nhap_c:	.asciiz	"Nhap c: "
xuat_a:	.asciiz	"Ket qua a = "
	.text
	.globl	main
main:
	la	$a0, nhap_a
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, a
	la	$a0, nhap_b
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, b
	la	$a0, nhap_c
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, c
	lw	$s0, a
	lw	$s1, b
	lw	$s2, c
	blt	$s0, -5, false
	bgt	$s0, 5, false
	add	$s0, $s1, $s2
	j	exit
false:	sub	$s0, $s1, $s2
exit:	sw	$s0, a
	la	$a0, xuat_a
	li	$v0, 4
	syscall
	lw	$a0, a
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall