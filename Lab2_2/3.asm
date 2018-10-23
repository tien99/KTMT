	.data
in:	.word	0
a:	.word	0
b:	.word	0
c:	.word	0
in_in:	.asciiz	"Nhap input: "
in_b:	.asciiz	"Nhap b: "
in_c:	.asciiz	"Nhap c: "
err:	.asciiz	"Gia tri nhap vao khong hop le!"
out_a:	.asciiz "Gia tri cua a la: "
	.text
	.globl	main
main:
	la	$a0, in_in
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, in
	la	$a0, in_b
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, b
	la	$a0, in_c
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, c
	lw	$s0, in
	lw	$s1, b
	lw	$s2, c
	beq	$s0, 0, case_1
	beq	$s0, 1, case_2
	beq	$s0, 2, case_3
	beq	$s0, 3, case_4
error:	la	$a0, err
	li	$v0, 4
	syscall
	j	exit
case_1:
	add	$s3, $s1, $s2
	j	out
case_2:
	sub	$s3, $s1, $s2
	j	out
case_3:
	add	$t0, $s1, $zero
	li	$s3, 0
loop:	beqz	$t0, out
	add	$s3, $s3, $s2
	addi	$t0, $t0, -1
	j	loop
case_4:
	beqz	$s2, error
	addi	$s3, $zero, 0
	addi	$t0, $s2, 0
loop2:	bgt	$t0, $s1, out
	add	$t0, $t0, $s2
	addi	$s3, $s3, 1
	j	loop2
out:	
	sw	$s3, a
	lw	$a0, a
	li	$v0, 1
	syscall
exit:	li	$v0, 10
	syscall
