	.text
.align 2
	.globl	printstr
printstr:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
 #APP
# 19 "syscall.c" 1
	mv a0, a5
	li a7, 4
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	printchar
printchar:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
 #APP
# 30 "syscall.c" 1
	mv a0, a5
	li a7, 11
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	printint
printint:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
 #APP
# 41 "syscall.c" 1
	mv a0, a5
	li a7, 1
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	readint
readint:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 53 "syscall.c" 1
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
	.globl	sbrk
sbrk:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a5,-36(s0)
 #APP
# 66 "syscall.c" 1
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
	.globl	readFloat
readFloat:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 80 "syscall.c" 1
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
	.globl	readDouble
readDouble:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 93 "syscall.c" 1
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
	.globl	printFloat
printFloat:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	fsw	fa0,-20(s0)
	flw	fa5,-20(s0)
 #APP
# 105 "syscall.c" 1
	fmv.s fa0, fa5
	li a7, 2
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	printDouble
printDouble:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	fsd	fa0,-24(s0)
	fld	fa5,-24(s0)
 #APP
# 116 "syscall.c" 1
	fmv.d fa0, fa5
	li a7, 3
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	readString
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
# 127 "syscall.c" 1
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
	.globl	Exit
Exit:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
 #APP
# 139 "syscall.c" 1
	li a7, 10
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
