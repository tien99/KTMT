#Chuong trinh chia 2 so thuc
#Input:		2 so thuc nhap vao tu ban phim
#Output:	Thuong cua 2 so thuc da nhap
#		Trong truong hop so chia bang 0 hoac ket qua bi tran so thi bao loi
#Han che:	Ket qua tinh toan khong chinh xac tuyet doi
#Khai bao bien:
	.data
f1:	.float	1.5	#So thuc thu nhat (So bi chia)
f2:	.float	2.5	#So thuc thu hai (So chia)
f:	.space	8	#O nho luu ket qua (Thuong cua 2 so)

#Cau nhac lenh:
in1:	.asciiz	"Nhap vao so bi chia:\n"
in2:	.asciiz	"Nhap vao so chia:\n"
err1:	.asciiz	"So chia bang 0!"
err2:	.asciiz	"Ket qua bi tran so!"
out:	.asciiz	"Thuong cua hai so da nhap la:\n"

#Code:
	.text
	.globl	main
main:

#Nhap du lieu:
	#Nhap so bi chia:
	la	$a0, in1
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, f1
	#Nhap so chia
	la	$a0, in2
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, f2
	
#Xu ly:
	#Load f1, f2 vao $a1, $a2
	lw	$a1, f1
	lw	$a2, f2
	beqz	$a2, error1
	
#Xu ly bit dau cua f:
	#Luu bit dau cua f1, f2 vao $t1, $t2
	andi	$t1, $a1, 0x80000000
	srl	$t1, $t1, 31
	andi	$t2, $a2, 0x80000000
	srl	$t2, $t2, 31
	#Neu bit dau cua f1 va f2 giong nhau thi bit dau cua f la 0 (duong) nguoc lai la am (1)
	#Do do bit dau cua f = xor($t1, $t2)
	#Luu bit dau cua f vao $t0
	xor	$t0, $t1, $t2

#Xu ly cac bit mu cua f:
	#Luu cac bit mu cua f1, f2 vao $t2, $t3
	andi	$t2, $a1, 0x7F800000
	srl	$t2, $t2, 23
	andi	$t3, $a2, 0x7F800000
	srl	$t3, $t3, 23
	#Do f = f1 / f2 nen bit mu cua f se bang bit mu cua f1 tru bit mu cua f2
	#Luu bit mu cua f vao $t1
	sub	$t1, $t2, $t3
	#Them bias = 127 vao $t1
	addi	$t1, $t1, 127

#Xu ly cac bit co so cua f:
	#Luu cac bit co so cua f1, f2 vao $t3, $t4
	andi	$t3, $a1, 0x007FFFFF
	andi	$t4, $a2, 0x007FFFFF
	#Them 1 vao bit 24
	ori	$t3, $t3, 0x00800000
	ori	$t4, $t4, 0x00800000
	#Thuc hien phep chia $t3 cho $t4
	#Luu ket qua vao $t2
	li	$t2, 0
loop:	ble	$t3, $t4, next
	addi	$t2, $t2, 1
	sub	$t3, $t3, $t4
next:	sll	$t2, $t2, 1
	sll	$t3, $t3, 1
	addi	$t1, $t1, -1
	blt	$t2, 0x007FFFFF, loop
	
	#Sau khi chia, loai bo bit 1 o vi tri bit 24 cua $t2
	andi	$t2, $t2, 0x007FFFFF
	#Cong so mu len 23
	addi	$t1, $t1, 23
	
#Phat hien loi tran so mu:
	#Neu $t1 < 0 hoac $t1 > 255 thi xay ra tran so
	bltz	$t1, error2
	bgt	$t1, 0xFF, error2

#Gop ket qua thanh so thuc hoan chinh (f)
	#Luu f vao $v0
	li	$v0, 0x0
	or	$v0, $v0, $t0
	sll	$v0, $v0, 8
	or	$v0, $v0, $t1
	sll	$v0, $v0, 23
	or	$v0, $v0, $t2
	#Luu f vao bo nho
	sw	$v0, f
	
#Xuat ket qua ra man hinh
	la	$a0, out
	li	$v0, 4
	syscall
	lwc1	$f12, f
	li	$v0, 2
	syscall

#Thoat chuong trinh:
exit:	li	$v0, 10
	syscall
	
#Xu ly ngoai le trong chuong trinh
	#Loi: so chia bang 0
error1:	la	$a0, err1
	li	$v0, 4
	syscall
	j	exit
	#Loi: ket qua bi tran so
error2:	la	$a0, err2
	li	$v0, 4
	syscall
	j	exit
