	.file	"syscall.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	printstr
	.type	printstr, @function
printstr:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
 #APP
# 18 "syscall.c" 1
	mv a0, a5
	li a7, 4
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	printstr, .-printstr
	.align	1
	.globl	printchar
	.type	printchar, @function
printchar:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
 #APP
# 28 "syscall.c" 1
	mv a0, a5
	li a7, 11
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	printchar, .-printchar
	.align	1
	.globl	printint
	.type	printint, @function
printint:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
 #APP
# 38 "syscall.c" 1
	mv a0, a5
	li a7, 1
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	printint, .-printint
	.align	1
	.globl	readint
	.type	readint, @function
readint:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 49 "syscall.c" 1
	li a7, 5
	ecall
	mv a5, a0
	
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	readint, .-readint
	.align	1
	.globl	sbrk
	.type	sbrk, @function
sbrk:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a5,-36(s0)
 #APP
# 61 "syscall.c" 1
	mv a0, a5
	li a7, 9
	ecall
	mv a5, a0
	
# 0 "" 2
 #NO_APP
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	sbrk, .-sbrk
	.align	1
	.globl	readFloat
	.type	readFloat, @function
readFloat:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 74 "syscall.c" 1
	li a7, 6
	ecall
	fmv.s fa5, fa0
	
# 0 "" 2
 #NO_APP
	fsw	fa5,-20(s0)
	flw	fa5,-20(s0)
	fmv.s	fa0,fa5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	readFloat, .-readFloat
	.align	1
	.globl	readDouble
	.type	readDouble, @function
readDouble:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 86 "syscall.c" 1
	li a7, 7
	ecall
	fmv.d fa5, fa0
	
# 0 "" 2
 #NO_APP
	fsd	fa5,-24(s0)
	fld	fa5,-24(s0)
	fmv.d	fa0,fa5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	readDouble, .-readDouble
	.align	1
	.globl	printFloat
	.type	printFloat, @function
printFloat:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	fsw	fa0,-20(s0)
	flw	fa5,-20(s0)
 #APP
# 97 "syscall.c" 1
	fmv.s fa0, fa5
	li a7, 2
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	printFloat, .-printFloat
	.align	1
	.globl	printDouble
	.type	printDouble, @function
printDouble:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	fsd	fa0,-24(s0)
	fld	fa5,-24(s0)
 #APP
# 107 "syscall.c" 1
	fmv.d fa0, fa5
	li a7, 3
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	printDouble, .-printDouble
	.align	1
	.globl	readString
	.type	readString, @function
readString:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	mv	a5,a1
	sw	a5,-28(s0)
	ld	a5,-24(s0)
	lw	a4,-28(s0)
 #APP
# 117 "syscall.c" 1
	mv a0, a5
	mv a1, a4
	li a7, 8
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	readString, .-readString
	.align	1
	.globl	Exit
	.type	Exit, @function
Exit:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
 #APP
# 128 "syscall.c" 1
	li a7, 10
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
	.size	Exit, .-Exit
	.ident	"GCC: () 13.2.0"
