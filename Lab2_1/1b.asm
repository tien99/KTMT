	.data
Chuoi:	.asciiz	"Kien truc may tinh 2017"
	.text
	.globl	main
main:
	la	$a0, Chuoi
	li	$v0, 4
	syscall
	li	$v0, 10
	syscall
