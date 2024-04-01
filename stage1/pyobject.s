	.file	"pyobject.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	create_pyobject
	.type	create_pyobject, @function
create_pyobject:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	li	a1,48
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a4,-44(s0)
	sw	a4,0(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_pyobject, .-create_pyobject
	.align	1
	.globl	create_value
	.type	create_value, @function
create_value:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	li	a1,0
	ld	a0,-40(s0)
	call	create_pyobject
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a4,-44(s0)
	sw	a4,8(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_value, .-create_value
	.align	1
	.globl	create_int
	.type	create_int, @function
create_int:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	li	a1,0
	ld	a0,-40(s0)
	call	create_value
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a4,-44(s0)
	sw	a4,12(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_int, .-create_int
	.align	1
	.globl	create_float
	.type	create_float, @function
create_float:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	fsw	fa0,-44(s0)
	li	a1,1
	ld	a0,-40(s0)
	call	create_value
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	flw	fa5,-44(s0)
	fsw	fa5,12(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_float, .-create_float
	.align	1
	.globl	create_bool
	.type	create_bool, @function
create_bool:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sb	a5,-41(s0)
	li	a1,2
	ld	a0,-40(s0)
	call	create_value
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lbu	a4,-41(s0)
	sb	a4,12(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_bool, .-create_bool
	.align	1
	.globl	release_pyobject
	.type	release_pyobject, @function
release_pyobject:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L15
	ld	a5,-32(s0)
	lw	a5,0(a5)
	bne	a5,zero,.L14
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	my_free
.L14:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L11
	ld	a5,-32(s0)
	addi	a5,a5,16
	mv	a0,a5
	call	release_shared
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	my_free
	j	.L11
.L15:
	nop
.L11:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	release_pyobject, .-release_pyobject
	.align	1
	.globl	copy_pyobject
	.type	copy_pyobject, @function
copy_pyobject:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	sd	s1,104(sp)
	addi	s0,sp,128
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	ld	a5,-64(s0)
	bne	a5,zero,.L17
	li	a5,0
	j	.L18
.L17:
	ld	a5,-64(s0)
	lw	a5,0(a5)
	bne	a5,zero,.L19
	ld	a5,-64(s0)
	lw	a5,8(a5)
	mv	a1,a5
	ld	a0,-56(s0)
	call	create_value
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-64(s0)
	ld	a0,8(a4)
	ld	a1,16(a4)
	ld	a2,24(a4)
	ld	a3,32(a4)
	ld	a4,40(a4)
	sd	a0,8(a5)
	sd	a1,16(a5)
	sd	a2,24(a5)
	sd	a3,32(a5)
	sd	a4,40(a5)
	ld	a5,-48(s0)
	j	.L18
.L19:
	li	a1,1
	ld	a0,-56(s0)
	call	create_pyobject
	sd	a0,-40(s0)
	ld	s1,-40(s0)
	addi	a0,s0,-96
	ld	a5,-64(s0)
	ld	a2,16(a5)
	ld	a3,24(a5)
	ld	a4,32(a5)
	ld	a5,40(a5)
	sd	a2,-128(s0)
	sd	a3,-120(s0)
	sd	a4,-112(s0)
	sd	a5,-104(s0)
	addi	a5,s0,-128
	mv	a1,a5
	call	copy_shared
	ld	a2,-96(s0)
	ld	a3,-88(s0)
	ld	a4,-80(s0)
	ld	a5,-72(s0)
	sd	a2,16(s1)
	sd	a3,24(s1)
	sd	a4,32(s1)
	sd	a5,40(s1)
	ld	a5,-64(s0)
	lw	a4,8(a5)
	ld	a5,-40(s0)
	sw	a4,8(a5)
	ld	a5,-40(s0)
.L18:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	ld	s1,104(sp)
	addi	sp,sp,128
	jr	ra
	.size	copy_pyobject, .-copy_pyobject
	.ident	"GCC: () 13.2.0"
