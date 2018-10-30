	.data
xa:	.float	0
ya:	.float	0
xb:	.float	0
yb:	.float	0
xc:	.float	0
yc:	.float	0
a:	.float	0
b:	.float	0
c:	.float	0
two:	.float	2.0
inXA:	.asciiz	"Nhap xA: "
inYA:	.asciiz	"Nhap yA: "
inXB:	.asciiz	"Nhap xB: "
inYB:	.asciiz	"Nhap yB: "
inXC:	.asciiz	"Nhap xC: "
inYC:	.asciiz	"Nhap yC: "
outMax:	.asciiz	"(Cac) dinh co gia tri x lon nhat:\n"
outErr:	.asciiz	"Ba diem da cho khong tao thanh tam giac!"
outDT:	.asciiz	"Dien tich tam giac da cho la:\n"
	.text
	.globl	main
main:	la	$a0, inXA
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, xa
	la	$a0, inYA
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, ya
	la	$a0, inXB
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, xb
	la	$a0, inYB
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, yb
	la	$a0, inXC
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, xc
	la	$a0, inYC
	li	$v0, 4
	syscall
	li	$v0, 6
	syscall
	swc1	$f0, yc
	lwc1	$f1, xa
	lwc1	$f2, xb
	lwc1	$f3, xc
	lwc1	$f4, ya
	lwc1	$f5, yb
	lwc1	$f6, yc
	mov.s	$f27, $f1
	mov.s	$f28, $f2
	mov.s	$f29, $f3
	jal	findM
	la	$a0, outMax
	li	$v0, 4
	syscall
	c.eq.s	$f1, $f26
	bc1f	skipf1
	mov.s	$f31, $f1
	mov.s	$f30, $f4
	jal	print
skipf1:	c.eq.s	$f2, $f26
	bc1f	skipf2
	mov.s	$f31, $f2
	mov.s	$f30, $f5
	jal	print
skipf2:	c.eq.s	$f3, $f26
	bc1f	skipf3
	mov.s	$f31, $f3
	mov.s	$f30, $f6
	jal	print
skipf3:	mov.s	$f8, $f1
	mov.s	$f9, $f4
	mov.s	$f10, $f2
	mov.s	$f11, $f5
	jal	cal
	swc1	$f7, c
	mov.s	$f10, $f3
	mov.s	$f11, $f6
	jal	cal
	swc1	$f7, b
	mov.s	$f8, $f2
	mov.s	$f9, $f5
	jal	cal
	swc1	$f7, a
	lwc1	$f27, a
	lwc1	$f28, b
	lwc1	$f29, c
	jal	findM
	mov.s	$f15, $f26
	jal	findm
	mov.s	$f17, $f26
	add.s	$f16, $f27, $f28
	add.s	$f16, $f16, $f29
	sub.s	$f16, $f16, $f15
	c.le.s	$f16, $f15
	bc1t	error
	add.s	$f18, $f16, $f15
	sub.s	$f16, $f16, $f17
	lwc1	$f19, two
	div.s	$f18, $f18, $f19
	mov.s	$f19, $f18
	sub.s	$f20, $f18, $f15
	mul.s	$f19, $f19, $f20
	sub.s	$f20, $f18, $f16
	mul.s	$f19, $f19, $f20
	sub.s	$f20, $f18, $f17
	mul.s	$f19, $f19, $f20
	sqrt.s	$f19, $f19
	la	$a0, outDT
	li	$v0, 4
	syscall
	mov.s	$f12, $f19
	li	$v0, 2
	syscall
exit:	li	$v0, 10
	syscall
findM:	mov.s	$f26, $f27
	c.le.s	$f28, $f26
	bc1t	Mskip
	mov.s	$f26, $f28
Mskip:	c.le.s	$f29, $f26
	bc1t	Mret
	mov.s	$f26, $f29
Mret:	jr	$ra
findm:	mov.s	$f26, $f27
	c.lt.s	$f28, $f26
	bc1f	mskip
	mov.s	$f26, $f28
mskip:	c.lt.s	$f29, $f26
	bc1f	mret
	mov.s	$f26, $f29
mret:	jr	$ra
print:	li	$a0, '('
	li	$v0, 11
	syscall
	mov.s	$f12, $f31
	li	$v0, 2
	syscall
	li	$a0, ';'
	li	$v0, 11
	syscall
	mov.s	$f12, $f30
	li	$v0, 2
	syscall
	li	$a0, ')'
	li	$v0, 11
	syscall
	li	$a0, '\n'
	li	$v0, 11
	syscall
	jr	$ra
cal:	sub.s	$f13, $f10, $f8
	mul.s	$f13, $f13, $f13
	sub.s	$f14, $f11, $f9
	mul.s	$f14, $f14, $f14
	add.s	$f7, $f13, $f14
	sqrt.s	$f7, $f7
	jr	$ra
error:	la	$a0, outErr
	li	$v0, 4
	syscall
	j	exit
