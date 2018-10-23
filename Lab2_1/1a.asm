#Data segment
	.data
So1:	.word	0
So2:	.word	0
So3:	.word	0
Ketqua:	.word	0
#Cac cau nhac nhap du lieu
Nhap1:	.asciiz	"Nhap so thu 1: "
Nhap2:	.asciiz "Nhap so thu 2: "
Nhap3:	.asciiz	"Nhap so thu 3: "
Xuat:	.asciiz "Tong cua 3 so la: "
#Code segment
	.text
	.globl	main
main:
#Nhap 3 so
	la	$a0, Nhap1	#Nhap so thu 1
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, So1
	la	$a0, Nhap2	#Nhap so thu 2
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, So2
	la	$a0, Nhap3	#Nhap so thu 3
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, So3
#Xu ly
	lw	$t0, So1
	lw	$t1, So2
	add	$t0, $t0, $t1
	lw	$t1, So3
	add	$t0, $t0, $t1
	sw	$a0, Ketqua
#Xuat ket qua
	la	$a0, Xuat
	li	$v0, 4
	syscall
	la	$a0, 0($t0)
	li	$v0, 1
	syscall
#exit
	li	$v0, 10
	syscall
