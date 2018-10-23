	.data
a:	.word	0
b:	.word	0
c:	.word	0
in1:	.asciiz	"Nhap so thu 1: "
in2:	.asciiz	"Nhap so thu 2: "
in3:	.asciiz	"Nhap so thu 3: "
out:	.asciiz	"Ket qua la: "
	.text
	.globl	main
main:
	la	$a0, in1
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, a
	la	$a0, in2
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, b
	la	$a0, in3
	li	$v0, 4
	syscall
	li	$v0, 5
	syscall
	sw	$v0, c
	lw	$a0, a
	lw	$a1, b
	lw	$a2, c
	jal	range
	la	$a0, out
	li	$v0, 4
	syscall
	move	$a0, $s2
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall
range:
	addi	$sp, $sp, -4
	sw	$ra, 4($sp)
	jal	max
	jal	min
	sub	$s2, $s0, $s1
	lw	$ra, 4($sp)
	addi	$sp, $sp, 4
	jr	$ra
max:
	addi	$sp, $sp, -4
	sw	$ra, 4($sp)
	move	$s0, $a0
	blt	$a1, $s0, max1
	move	$s0, $a1
max1:	blt	$a2, $s0, max2
	move	$s0, $a2
max2:	lw	$ra, 4($sp)
	addi	$sp, $sp, 4
	jr	$ra
min:
	addi	$sp, $sp, -4
	sw	$ra, 4($sp)
	move	$s1, $a0
	bgt	$a1, $s1, min1
	move	$s1, $a1
min1:	bgt	$a2, $s1, min2
	move	$s1, $a2
min2:	lw	$ra, 4($sp)
	addi	$sp, $sp, 4
	jr	$ra