#Chuong trinh chia 2 so thuc
#Input:		2 so thuc nhap vao tu ban phim
#Output:	Neu so chia hoac so bi chia khong hop le (NaN) thi ket qua la NaN
#		Trong truong hop so chia va so bi chia cung bang vo cuc hoac cung bang 0 thi ket qua la NaN
#		Cac truong hop con lai xuat gia tri thuong cua 2 so thuc da nhap (trong tam bieu dien cua kieu float)
#		Trong truong hop tri tuyet doi cua thuong >= 2^128 thi ket qua la vo cuc (Infinity)
#		Trong truong hop tri tuyet doi cua thuong <= 2^-127 thi ket qua la 0
#Khai bao bien:
	.data
f1:	.float	0	#So thuc thu nhat (So bi chia)
f2:	.float	0	#So thuc thu hai (So chia)
f:	.space	8	#O nho luu ket qua (Thuong cua 2 so)

#Cau nhac lenh:
in1:	.asciiz	"Nhap vao so bi chia:\n"
in2:	.asciiz	"Nhap vao so chia:\n"
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
	#Kiem tra 2 so da nhap co hop le hay khong (= NaN)
	beq	$a1, 0x7FC00000, case1
	beq	$a2, 0x7FC00000, case1
	
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

	#Kiem tra so bi chia co bang cong/tru vo cuc (Infinity) hay khong
	beq	$a1, 0x7F800000, excep1
	beq	$a1, 0xFF800000, excep1
	#Kiem tra so chia co bang 0.0 hoac -0.0 hay khong
	beqz	$a2, excep2
	beq	$a2, 0x80000000, excep2
	#Kiem tra so chia co bang vo cuc hay khong
	beq	$a2, 0x7F800000, case2
	beq	$a2, 0xFF800000, case2
	
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
loop:	blt	$t3, $t4, next
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
	#Neu $t1 < 0 hoac $t1 > 255 thi xu li ngoai le
	bltz	$t1, case2
	bgt	$t1, 0xFE, case3

#Gop ket qua thanh so thuc hoan chinh (f)
	#Luu f vao $v0
comb:	li	$v0, 0x0
	or	$v0, $v0, $t0
	sll	$v0, $v0, 8
	or	$v0, $v0, $t1
	sll	$v0, $v0, 23
	or	$v0, $v0, $t2
	#Luu f vao bo nho
save:	sw	$v0, f
	
#Xuat ket qua ra man hinh
output:	la	$a0, out
	li	$v0, 4
	syscall
	lwc1	$f12, f
	li	$v0, 2
	syscall

#Thoat chuong trinh:
exit:	li	$v0, 10
	syscall
	
#Xu ly ngoai le trong chuong trinh
	#Ngoai le: so bi chia bang vo cuc
excep1:	beq	$a2, 0x7F800000, case1
	beq	$a2, 0xFF800000, case1
	j	case3
	
	#Ngoai le: so chia bang 0
excep2:	beqz	$a1, case1
	beq	$a1, 0xF0000000, case1
	j	case3
	
	#Truong hop thuong mang gia tri khong hop le
case1:	li	$v0, 0x7FC00000
	j	save
	
	#Truong hop tri tuyet doi thuong <= 2^-127
case2:	li	$t1, 0x0
	li	$t2, 0x0
	j	comb
	
	#Truong hop tri tuyet doi thuong >= 2^128
case3:	li	$t1, 0xFF
	li	$t2, 0x0
	j	comb
