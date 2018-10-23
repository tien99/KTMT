	.data
nhap:	.asciiz	"Nhap n: "
loi:	.asciiz	"Gia tri nhap vao khong hop le!"
xuat:	.asciiz "F(n) = "
	.text
	.globl	main
main:
	la	$a0, nhap
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	move	$s0, $v0
	bltz	$s0, error
	la	$a0, xuat
	li	$v0, 4
	syscall
	ble	$s0, 1, out_01
	addi	$t0, $zero, 2
	li	$t1, 0
	li	$t2, 1
	add	$t3, $t1, $t2
loop:	bge	$t0, $s0, out
	move	$t1, $t2
	move	$t2, $t3
	add	$t3, $t1, $t2
	addi	$t0, $t0, 1
	j	loop
error:
	la	$a0, loi
	li	$v0, 4
	syscall
	j	exit
out_01:	move	$a0, $s0
	li	$v0, 1
	syscall
	j	exit
out:	move	$a0, $t3
	li	$v0, 1
	syscall
exit:	li	$v0, 10
	syscall