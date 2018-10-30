	.data
nhapD:	.asciiz	"Nhap chieu dai: "
nhapR:	.asciiz	"Nhap chieu rong: "
xuatCV:	.asciiz	"\nChu vi: "
xuatDT:	.asciiz	"\nDien tich: "
dai:	.float	0
rong:	.float	0
cv:	.float	0
dt:	.float	0
	.text
	.globl	main
main:
	#Nhap
	la	$a0, nhapD
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, dai
	la	$a0, nhapR
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, rong
	#Xu ly
	lwc1	$f1, dai
	lwc1	$f2, rong
	add.s	$f3, $f1, $f2
	swc1	$f3, cv
	mul.s	$f4, $f1, $f2
	swc1	$f4, dt
	#Xuat
	la	$a0, xuatCV
	li	$v0, 4
	syscall
	lwc1	$f12, cv
	li	$v0, 2
	syscall
	la	$a0, xuatDT
	li	$v0, 4
	syscall
	lwc1	$f12, dt
	li	$v0, 2
	syscall
	li	$v0, 10
	syscall