	.file	"compiler.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	create_instruction
	.type	create_instruction, @function
create_instruction:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	li	a1,8
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
	.size	create_instruction, .-create_instruction
	.align	1
	.globl	create_load_int
	.type	create_load_int, @function
create_load_int:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	li	a1,1
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a4,-44(s0)
	sw	a4,4(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_load_int, .-create_load_int
	.align	1
	.globl	create_load_float
	.type	create_load_float, @function
create_load_float:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	fsw	fa0,-44(s0)
	li	a1,2
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	flw	fa5,-44(s0)
	fsw	fa5,4(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_load_float, .-create_load_float
	.align	1
	.globl	create_load_bool
	.type	create_load_bool, @function
create_load_bool:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sb	a5,-41(s0)
	li	a1,3
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lbu	a4,-41(s0)
	sb	a4,4(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_load_bool, .-create_load_bool
	.align	1
	.globl	create_jump_relative_instruction
	.type	create_jump_relative_instruction, @function
create_jump_relative_instruction:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	li	a1,4
	ld	a0,-24(s0)
	call	create_instruction
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	create_jump_relative_instruction, .-create_jump_relative_instruction
	.align	1
	.globl	create_jump_relative_if_false_instruction
	.type	create_jump_relative_if_false_instruction, @function
create_jump_relative_if_false_instruction:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	li	a1,5
	ld	a0,-24(s0)
	call	create_instruction
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	create_jump_relative_if_false_instruction, .-create_jump_relative_if_false_instruction
	.align	1
	.globl	compile_int
	.type	compile_int, @function
compile_int:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a5,-48(s0)
	lw	a5,8(a5)
	mv	a1,a5
	ld	a0,-40(s0)
	call	create_load_int
	sd	a0,-24(s0)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_int, .-compile_int
	.align	1
	.globl	compile_float
	.type	compile_float, @function
compile_float:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a5,-48(s0)
	flw	fa5,8(a5)
	fmv.s	fa0,fa5
	ld	a0,-40(s0)
	call	create_load_float
	sd	a0,-24(s0)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_float, .-compile_float
	.align	1
	.globl	compile_bool
	.type	compile_bool, @function
compile_bool:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a5,-48(s0)
	flw	fa5,8(a5)
	fmv.s	fa0,fa5
	ld	a0,-40(s0)
	call	create_load_float
	sd	a0,-24(s0)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_bool, .-compile_bool
	.align	1
	.globl	compile_binop
	.type	compile_binop, @function
compile_binop:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a5,-48(s0)
	ld	a5,8(a5)
	ld	a2,-56(s0)
	mv	a1,a5
	ld	a0,-40(s0)
	call	compile_node
	ld	a5,-48(s0)
	ld	a5,16(a5)
	ld	a2,-56(s0)
	mv	a1,a5
	ld	a0,-40(s0)
	call	compile_node
	li	a1,6
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-48(s0)
	lw	a4,24(a5)
	ld	a5,-24(s0)
	sw	a4,4(a5)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_binop, .-compile_binop
	.align	1
	.globl	compile_ternary_if
	.type	compile_ternary_if, @function
compile_ternary_if:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	ld	a5,-64(s0)
	ld	a5,16(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	ld	a0,-56(s0)
	call	create_jump_relative_if_false_instruction
	sd	a0,-24(s0)
	ld	a5,-72(s0)
	ld	a5,16(a5)
	sw	a5,-28(s0)
	ld	a1,-24(s0)
	ld	a0,-72(s0)
	call	linked_list_push
	ld	a5,-64(s0)
	ld	a5,8(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	ld	a0,-56(s0)
	call	create_jump_relative_instruction
	sd	a0,-40(s0)
	ld	a5,-72(s0)
	ld	a5,16(a5)
	sw	a5,-44(s0)
	ld	a1,-40(s0)
	ld	a0,-72(s0)
	call	linked_list_push
	ld	a5,-72(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,4(a5)
	ld	a5,-64(s0)
	ld	a5,24(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	ld	a5,-72(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	lw	a5,-44(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,4(a5)
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	compile_ternary_if, .-compile_ternary_if
	.section	.rodata
	.align	3
.LC0:
	.string	"unrecognized node!\n"
	.align	3
.LC1:
	.string	"node type: %d\n"
	.text
	.align	1
	.globl	compile_node
	.type	compile_node, @function
compile_node:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a3,a5
	li	a4,9
	beq	a3,a4,.L19
	mv	a3,a5
	li	a4,9
	bgtu	a3,a4,.L20
	mv	a3,a5
	li	a4,6
	beq	a3,a4,.L21
	mv	a3,a5
	li	a4,6
	bgtu	a3,a4,.L20
	beq	a5,zero,.L22
	mv	a4,a5
	li	a5,1
	beq	a4,a5,.L23
	j	.L20
.L22:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_int
	j	.L18
.L23:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_float
	j	.L18
.L21:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_binop
	j	.L18
.L19:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_ternary_if
	j	.L18
.L20:
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	my_printf
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	my_printf
	nop
.L18:
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	compile_node, .-compile_node
	.align	1
	.globl	compile
	.type	compile, @function
compile:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-24(s0)
	sd	a4,0(a5)
	ld	a5,-24(s0)
	ld	a4,0(a5)
	ld	a5,-40(s0)
	ld	a3,8(a5)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	mv	a2,a5
	mv	a1,a3
	mv	a0,a4
	call	compile_node
	ld	a5,-40(s0)
	ld	a5,16(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	linked_list_push
	ld	a5,-40(s0)
	ld	a5,16(a5)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	compile, .-compile
	.ident	"GCC: () 13.2.0"
