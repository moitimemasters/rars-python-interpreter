	.file	"string.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	my_strlen
	.type	my_strlen, @function
my_strlen:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	ld	a5,-40(s0)
	addi	a4,a5,1
	sd	a4,-40(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L3
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	my_strlen, .-my_strlen
	.align	1
	.globl	my_strcpy
	.type	my_strcpy, @function
my_strcpy:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	j	.L6
.L7:
	ld	a5,-32(s0)
	lbu	a4,0(a5)
	ld	a5,-24(s0)
	sb	a4,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	addi	a5,a5,1
	sd	a5,-32(s0)
.L6:
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L7
	ld	a5,-24(s0)
	sb	zero,0(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	my_strcpy, .-my_strcpy
	.align	1
	.globl	my_strcmp
	.type	my_strcmp, @function
my_strcmp:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	j	.L9
.L11:
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	addi	a5,a5,1
	sd	a5,-32(s0)
.L9:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	beq	a5,zero,.L10
	ld	a5,-24(s0)
	lbu	a4,0(a5)
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	beq	a4,a5,.L11
.L10:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	sext.w	a4,a5
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	sext.w	a5,a5
	subw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	my_strcmp, .-my_strcmp
	.ident	"GCC: () 13.2.0"
