	.data
string:	.space	32
in:	.asciiz	"Nhap chuoi can bien doi: "
wrong:	.asciiz	"Chuoi da nhap khong hop le!"
out:	.asciiz	"Chuoi sau khi bien doi la: "
	.text
	.globl	main
main:
	la	$a0, in
	li	$v0, 4
	syscall
	la	$a0, string
	li	$a1, 32
	li	$v0, 8
	syscall
	move	$t1, $a0
loop:
	lb	$t2, 0($t1)
	addi	$t1, $t1, 1
	bnez	$t2, loop
exe:
	addi	$t1, $t1, -3
	ble	$t1, $a0, error
	lb	$t4, 0($a0)
	lb	$t5, 0($t1)
	sb	$t4, 0($t1)
	sb	$t5, 0($a0)
	j	write
error:
	la	$a0, wrong
	li	$v0, 4
	syscall
	j	exit
write:
	la	$a0, out
	li	$v0, 4
	syscall
	la	$a0, string
	li	$v0, 4
	syscall
exit:
	li	$v0, 10
	syscall
