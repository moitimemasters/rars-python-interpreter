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
	addi	sp,sp,-16
	sd	s0,0(sp)
	mv	s0,a1
	li	a1,24
	sd	ra,8(sp)
	call	my_alloc
	ld	ra,8(sp)
	sw	s0,0(a0)
	ld	s0,0(sp)
	addi	sp,sp,16
	jr	ra
	.size	create_pyobject, .-create_pyobject
	.align	1
	.globl	create_value
	.type	create_value, @function
create_value:
	addi	sp,sp,-16
	sd	s0,0(sp)
	mv	s0,a1
	li	a1,24
	sd	ra,8(sp)
	call	my_alloc
	ld	ra,8(sp)
	sw	s0,8(a0)
	ld	s0,0(sp)
	sw	zero,0(a0)
	addi	sp,sp,16
	jr	ra
	.size	create_value, .-create_value
	.align	1
	.globl	create_int
	.type	create_int, @function
create_int:
	addi	sp,sp,-16
	sd	s0,0(sp)
	mv	s0,a1
	li	a1,24
	sd	ra,8(sp)
	call	my_alloc
	ld	ra,8(sp)
	sw	s0,12(a0)
	ld	s0,0(sp)
	sw	zero,0(a0)
	sw	zero,8(a0)
	addi	sp,sp,16
	jr	ra
	.size	create_int, .-create_int
	.align	1
	.globl	create_float
	.type	create_float, @function
create_float:
	addi	sp,sp,-32
	li	a1,24
	fsd	fs0,8(sp)
	sd	ra,24(sp)
	fmv.s	fs0,fa0
	call	my_alloc
	ld	ra,24(sp)
	li	a4,1
	fsw	fs0,12(a0)
	sw	zero,0(a0)
	sw	a4,8(a0)
	fld	fs0,8(sp)
	addi	sp,sp,32
	jr	ra
	.size	create_float, .-create_float
	.align	1
	.globl	create_bool
	.type	create_bool, @function
create_bool:
	addi	sp,sp,-16
	sd	s0,0(sp)
	mv	s0,a1
	li	a1,24
	sd	ra,8(sp)
	call	my_alloc
	ld	ra,8(sp)
	sb	s0,12(a0)
	ld	s0,0(sp)
	li	a4,2
	sw	zero,0(a0)
	sw	a4,8(a0)
	addi	sp,sp,16
	jr	ra
	.size	create_bool, .-create_bool
	.ident	"GCC: () 13.2.0"
