	.data
a:	.word	0
b:	.word	0
c:	.word	0
d:	.word	0
x:	.word	0
kq:	.word	0
nhap_a:	.asciiz	"Nhap a: "
nhap_b:	.asciiz	"Nhap b: "
nhap_c:	.asciiz	"Nhap c: "
nhap_d:	.asciiz	"Nhap d: "
nhap_x:	.asciiz	"Nhap x: "
xuat:	.asciiz	"Ket qua cua bieu thuc la: "
	.text
	.globl	main
main:
	#Nhap a
	la	$a0, nhap_a
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, a
	#Nhap b
	la	$a0, nhap_b
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, b
	#Nhap c
	la	$a0, nhap_c
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, c
	#Nhap d
	la	$a0, nhap_d
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, d
	#Nhap x
	la	$a0, nhap_x
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, x
	#Xu ly
	lw	$a0, x
	lw	$a1, a
	jal	times
	ori	$s0, $v0, 0
	lw	$a1, b
	sub	$s0, $s0, $a1
	ori	$a1, $s0, 0
	jal	times
	ori	$s0, $v0, 0
	lw	$a1, c
	sub	$s0, $s0, $a1
	ori	$a1, $s0, 0
	jal	times
	ori	$s0, $v0, 0
	lw	$a1, d
	add	$s0, $s0, $a1
	sw	$s0, kq
	j	exit
times:
	ori	$t0, $a0, 0
	li	$t1, 0
loop:	beq	$t0, 0, return
	add	$t1, $t1, $a1
	addi	$t0, $t0, -1
	j	loop
return:	ori	$v0, $t1, 0
	jr	$ra
exit:
	la	$a0, xuat
	li	$v0, 4
	syscall
	lw	$a0, kq
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall