	.data
Chuoi:	.space	11
Nhap:	.asciiz	"Nhap chuoi can xuat:\n"
Xuat:	.asciiz	"\nXuat chuoi:\n"
	.text
	.globl	main
main:
	la	$a0, Nhap
	li	$v0, 4
	syscall
	la	$a0, Chuoi
	li	$a1, 11
	li	$v0, 8
	syscall
	la	$a0, Xuat
	li	$v0, 4
	syscall
	la	$a0, Chuoi
	li	$v0, 4
	syscall
	li	$v0, 10
	syscall