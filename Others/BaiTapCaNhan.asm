#Chuong trinh tinh dien tich tu giac
#Input:		Toa do 4 diem A, B, C, D
#Output:	Dien tich tu giac ABCD (neu A, B, C, D tao thanh tu giac don)
#		Hoac bao loi ABCD khong phai la tu giac don (theo dinh nghia cua Wikipedia)
#Han che:	Khong xu ly duoc truong hop tran so
#		Khong tinh toan chinh xac tuyet doi dien tich cua tu giac
#Khai bao bien
	.data
xA:	.float	0
yA:	.float	0
xB:	.float	0
yB:	.float	0
xC:	.float	0
yC:	.float	0
xD:	.float	0
yD:	.float	0
zero:	.float	0
half:	.float	0.5
one:	.float	1
#Cau nhac lenh
inXA:	.asciiz	"Nhap toa do xA:\n"
inYA:	.asciiz	"Nhap toa do yA:\n"
inXB:	.asciiz	"Nhap toa do xB:\n"
inYB:	.asciiz	"Nhap toa do yB:\n"
inXC:	.asciiz	"Nhap toa do xC:\n"
inYC:	.asciiz	"Nhap toa do yC:\n"
inXD:	.asciiz	"Nhap toa do xD:\n"
inYD:	.asciiz	"Nhap toa do yD:\n"
outS:	.asciiz	"Dien tich tu giac ABCD la:\n"
err:	.asciiz	"Loi: ABCD khong tao thanh tu giac don!\n"
#Code
	.text
	.globl	main
main:
#Nhap du lieu
	la	$a0, inXA
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, xA
	mov.s	$f1, $f0
	la	$a0, inYA
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, yA
	mov.s	$f3, $f0
	la	$a0, inXB
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, xB
	mov.s	$f3, $f0
	la	$a0, inYB
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, yB
	mov.s	$f4, $f0
	la	$a0, inXC
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, xC
	la	$a0, inYC
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, yC
	la	$a0, inXD
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, xD
	la	$a0, inYD
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, yD
#Xu ly
	l.s	$f0, zero
#Doc toa do A, B, C, D vao $f1 den $f8
	lwc1	$f1, xA
	lwc1	$f2, yA
	lwc1	$f3, xB
	lwc1	$f4, yB
	lwc1	$f5, xC
	lwc1	$f6, yC
	lwc1	$f7, xD
	lwc1	$f8, yD
#Kiem tra B va D co nam 2 phia duong thang AC khong
	#Tinh gia tri a, b, c trong phuong trinh duong thang AC: ax + by + c = 0
	#Gan gia tri vao $f29, $f30, $f31
	sub.s	$f29, $f2, $f6		#a = yA - yC
	sub.s	$f30, $f5, $f1		#b = xC - xA
	#Neu a = b = 0 thi bao loi do A trung voi C
	c.eq.s	0, $f29, $f0
	bc1f	0, next1
	c.eq.s	1, $f30, $f0
	bc1f	1, next2
	j	error
	#Neu a != 0 thi rut gon b = b/a, a = 1
	#Neu khong thi b = 1
next1:
	div.s	$f30, $f30, $f29
	lwc1	$f29, one
	j	ok
next2:
	lwc1	$f30, one
ok:	mul.s	$f27, $f29, $f1		#$f27 = xA*a
	mul.s	$f28, $f30, $f2		#$f28 = yA*b
	add.s	$f31, $f27, $f28	#$f31 = xA*a + yA*b
	neg.s	$f31, $f31		#$f31 = -(xA*a + yA*b)
	#Tinh a*xB + b*yB + c gan vao $f28
	mov.s	$f28, $f31		#$f28 = c
	mul.s	$f27, $f29, $f3		#$f27 = a*xB
	add.s	$f28, $f28, $f27	#$f28 = a*xB + c
	mul.s	$f27, $f30, $f4		#$f27 = b*yB
	add.s	$f28, $f28, $f27	#$f28 = a*xB + b*yB + c
	#Bao loi neu $f28 = 0 do B thuoc duong thang AC
	c.eq.s	$f28, $f0
	bc1t	error
	#Tinh a*xD + b*yD + c gan vao $f27
	mov.s	$f27, $f31		#$f27 = c
	mul.s	$f26, $f29, $f7		#$f26 = a*xD
	add.s	$f27, $f27, $f26	#$f27 = a*xD + c
	mul.s	$f26, $f30, $f8		#$f26 = b*yD
	add.s	$f27, $f27, $f26	#$f27 = a*xD + b*yD + c
	#Bao loi neu $f27 = 0 do D thuoc duong thang AC
	c.eq.s	$f27, $f0
	bc1t	error
	#Tinh $f26 = $f27 * $f28
	mul.s	$f26, $f27, $f28
	#Neu $f26 > 0 thi bao loi do B, D cung phia voi duong thang AC
	c.le.s	$f26, $f0
	bc1f	error
#Tinh dien tich 2 tam giac ABC va ACD
	#Tinh do dai doan thang AC va luu vao $f26
	sub.s	$f24, $f1, $f5		#$f24 = xA - xC
	mul.s	$f24, $f24, $f24	#$f24 = (xA - xC)^2
	sub.s	$f25, $f2, $f6		#$f25 = yA - yC
	mul.s	$f25, $f25, $f25	#$f25 = (yA - yC)^2
	add.s	$f26, $f24, $f25	#$f26 = (xA - xC)^2 + (yA - yC)^2
	sqrt.s	$f26, $f26		#$f26 = AC
	#Tinh sqrt(a*a + b*b) va luu vao thanh ghi $f25
	mul.s	$f23, $f29, $f29	#$f23 = a^2
	mul.s	$f24, $f30, $f30	#$f24 = b^2
	add.s	$f25, $f24, $f23	#$f25 = a^2 + b^2
	sqrt.s	$f25, $f25		#$f25 = sqrt(a^2 + b^2)
	#Tinh khoang cach tu B den AC (hB), luu vao $f24
	mov.s	$f24, $f28
	abs.s	$f24, $f24
	div.s	$f24, $f24, $f25
	#Tinh khoang cach tu D den AC (hD), luu vao $f23
	mov.s	$f23, $f27
	abs.s	$f23, $f23
	div.s	$f23, $f23, $f25
	#Tinh Sabc, luu vao $f22
	lwc1	$f22, half		#$f22 = 0.5
	mul.s	$f22, $f22, $f24
	mul.s	$f22, $f22, $f26
	#Tinh Sacd, luu vao $f21
	lwc1	$f21, half		#$f21 = 0.5
	mul.s	$f21, $f21, $f23
	mul.s	$f21, $f21, $f26
	#Tinh Sabcd = Sabc + Sacd, luu vao $f20
	add.s	$f20, $f21, $f22
#Xuat ket qua
	la	$a0, outS
	li	$v0, 4
	syscall
	mov.s	$f12, $f20
	li	$v0, 2
	syscall
#Thoat chuong trinh
exit:
	li	$v0, 10
	syscall
#Xu ly ngoai le
error:
	la	$a0, err
	li	$v0, 4
	syscall
	j	exit