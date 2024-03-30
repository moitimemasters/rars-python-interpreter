	.file	"interpreter.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	interpret_unit
	.type	interpret_unit, @function
interpret_unit:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	j	.L2
.L4:
	ld	a5,-32(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	addi	a5,s0,-32
	ld	a3,-56(s0)
	ld	a2,-48(s0)
	mv	a1,a5
	ld	a0,-24(s0)
	call	interpret_instruction
	ld	a5,-56(s0)
	bne	a5,zero,.L5
.L2:
	ld	a5,-32(s0)
	bne	a5,zero,.L4
	j	.L1
.L5:
	nop
.L1:
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	interpret_unit, .-interpret_unit
	.section	.rodata
	.align	3
.LC0:
	.string	"Unknown instruction type: %d\n"
	.text
	.align	1
	.globl	interpret_instruction
	.type	interpret_instruction, @function
interpret_instruction:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	sd	a3,-48(s0)
	ld	a5,-24(s0)
	lw	a5,0(a5)
	mv	a3,a5
	li	a4,6
	bgtu	a3,a4,.L7
	slli	a4,a5,2
	lui	a5,%hi(.L9)
	addi	a5,a5,%lo(.L9)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L9:
	.word	.L7
	.word	.L13
	.word	.L12
	.word	.L7
	.word	.L11
	.word	.L10
	.word	.L8
	.text
.L13:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_load_int
	j	.L6
.L12:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_load_float
	j	.L6
.L8:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_binop
	j	.L6
.L11:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_jump_relative
	j	.L6
.L10:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_jump_relative_if_false
	j	.L6
.L7:
	ld	a5,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	my_printf
	nop
.L6:
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	interpret_instruction, .-interpret_instruction
	.align	1
	.globl	interpret_load_float
	.type	interpret_load_float, @function
interpret_load_float:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sd	a3,-64(s0)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,1
	mv	a0,a5
	call	create_value
	sd	a0,-24(s0)
	ld	a5,-40(s0)
	flw	fa5,4(a5)
	ld	a5,-24(s0)
	fsw	fa5,12(a5)
	ld	a5,-56(s0)
	ld	a5,16(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	stack_push
	ld	a5,-48(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-48(s0)
	sd	a4,0(a5)
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	interpret_load_float, .-interpret_load_float
	.align	1
	.globl	interpret_load_int
	.type	interpret_load_int, @function
interpret_load_int:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sd	a3,-64(s0)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,0
	mv	a0,a5
	call	create_value
	sd	a0,-24(s0)
	ld	a5,-40(s0)
	lw	a4,4(a5)
	ld	a5,-24(s0)
	sw	a4,12(a5)
	ld	a5,-56(s0)
	ld	a5,16(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	stack_push
	ld	a5,-48(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-48(s0)
	sd	a4,0(a5)
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	interpret_load_int, .-interpret_load_int
	.section	.rodata
	.align	3
.LC1:
	.string	"add_binop"
	.align	3
.LC2:
	.string	"sub_binop"
	.align	3
.LC3:
	.string	"mul_binop"
	.align	3
.LC4:
	.string	"div_binop"
	.text
	.align	1
	.globl	interpret_binop
	.type	interpret_binop, @function
interpret_binop:
	addi	sp,sp,-240
	sd	ra,232(sp)
	sd	s0,224(sp)
	addi	s0,sp,240
	sd	a0,-216(s0)
	sd	a1,-224(s0)
	sd	a2,-232(s0)
	sd	a3,-240(s0)
	ld	a5,-232(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-232(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a5,-232(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a5,-232(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a5,-216(s0)
	lw	a5,4(a5)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,17
	beq	a4,a5,.L18
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,17
	bgtu	a4,a5,.L19
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,15
	beq	a4,a5,.L20
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,15
	bgtu	a4,a5,.L19
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,10
	beq	a4,a5,.L21
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,13
	beq	a4,a5,.L22
	j	.L19
.L21:
	ld	a5,-232(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC1)
	addi	a5,a5,%lo(.LC1)
	sd	a5,-152(s0)
	li	a5,9
	sd	a5,-144(s0)
	ld	a1,-152(s0)
	ld	a2,-144(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-120(s0)
	ld	a5,-120(s0)
	bne	a5,zero,.L23
	ld	a5,-240(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L17
.L23:
	ld	a5,-232(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-128(s0)
	ld	a1,-32(s0)
	ld	a0,-128(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-128(s0)
	call	linked_list_push
	ld	a5,-232(s0)
	ld	a4,0(a5)
	ld	a5,-120(s0)
	ld	a2,-240(s0)
	ld	a1,-128(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-136(s0)
	ld	a5,-240(s0)
	bne	a5,zero,.L37
	ld	a5,-232(s0)
	ld	a5,16(a5)
	ld	a1,-136(s0)
	mv	a0,a5
	call	stack_push
	j	.L26
.L22:
	ld	a5,-232(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC2)
	addi	a5,a5,%lo(.LC2)
	sd	a5,-168(s0)
	li	a5,9
	sd	a5,-160(s0)
	ld	a1,-168(s0)
	ld	a2,-160(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-96(s0)
	ld	a5,-96(s0)
	bne	a5,zero,.L28
	ld	a5,-240(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L17
.L28:
	ld	a5,-232(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-104(s0)
	ld	a1,-32(s0)
	ld	a0,-104(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-104(s0)
	call	linked_list_push
	ld	a5,-232(s0)
	ld	a4,0(a5)
	ld	a5,-96(s0)
	ld	a2,-240(s0)
	ld	a1,-104(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-112(s0)
	ld	a5,-240(s0)
	bne	a5,zero,.L38
	ld	a5,-232(s0)
	ld	a5,16(a5)
	ld	a1,-112(s0)
	mv	a0,a5
	call	stack_push
	j	.L26
.L20:
	ld	a5,-232(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC3)
	addi	a5,a5,%lo(.LC3)
	sd	a5,-184(s0)
	li	a5,9
	sd	a5,-176(s0)
	ld	a1,-184(s0)
	ld	a2,-176(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-72(s0)
	ld	a5,-72(s0)
	bne	a5,zero,.L31
	ld	a5,-240(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L17
.L31:
	ld	a5,-232(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-80(s0)
	ld	a1,-32(s0)
	ld	a0,-80(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-80(s0)
	call	linked_list_push
	ld	a5,-232(s0)
	ld	a4,0(a5)
	ld	a5,-72(s0)
	ld	a2,-240(s0)
	ld	a1,-80(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-88(s0)
	ld	a5,-240(s0)
	bne	a5,zero,.L39
	ld	a5,-232(s0)
	ld	a5,16(a5)
	ld	a1,-88(s0)
	mv	a0,a5
	call	stack_push
	j	.L26
.L18:
	ld	a5,-232(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC4)
	addi	a5,a5,%lo(.LC4)
	sd	a5,-200(s0)
	li	a5,9
	sd	a5,-192(s0)
	ld	a1,-200(s0)
	ld	a2,-192(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L34
	ld	a5,-240(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L17
.L34:
	ld	a5,-232(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-56(s0)
	ld	a1,-32(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	ld	a5,-232(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	ld	a2,-240(s0)
	ld	a1,-56(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-64(s0)
	ld	a5,-240(s0)
	bne	a5,zero,.L40
	ld	a5,-232(s0)
	ld	a5,16(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	stack_push
	j	.L26
.L19:
	ld	a5,-240(s0)
	li	a4,2
	sw	a4,0(a5)
	j	.L17
.L26:
	ld	a5,-224(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-224(s0)
	sd	a4,0(a5)
	j	.L17
.L37:
	nop
	j	.L17
.L38:
	nop
	j	.L17
.L39:
	nop
	j	.L17
.L40:
	nop
.L17:
	ld	ra,232(sp)
	ld	s0,224(sp)
	addi	sp,sp,240
	jr	ra
	.size	interpret_binop, .-interpret_binop
	.align	1
	.globl	perform_jump
	.type	perform_jump, @function
perform_jump:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	lw	a5,-44(s0)
	sext.w	a5,a5
	bge	a5,zero,.L42
	sw	zero,-20(s0)
	j	.L43
.L45:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,16(a5)
	ld	a5,-40(s0)
	sd	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L43:
	lw	a5,-44(s0)
	negw	a5,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,a4,.L48
	ld	a5,-40(s0)
	ld	a5,0(a5)
	bne	a5,zero,.L45
	j	.L48
.L42:
	sw	zero,-24(s0)
	j	.L46
.L47:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-40(s0)
	sd	a4,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L46:
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L48
	ld	a5,-40(s0)
	bne	a5,zero,.L47
.L48:
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	perform_jump, .-perform_jump
	.align	1
	.globl	interpret_jump_relative
	.type	interpret_jump_relative, @function
interpret_jump_relative:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sd	a3,-64(s0)
	ld	a5,-40(s0)
	lw	a5,4(a5)
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a1,a5
	ld	a0,-48(s0)
	call	perform_jump
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	interpret_jump_relative, .-interpret_jump_relative
	.align	1
	.globl	interpret_jump_relative_if_false
	.type	interpret_jump_relative_if_false, @function
interpret_jump_relative_if_false:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	sd	a3,-80(s0)
	ld	a5,-72(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a5,-72(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a5,-32(s0)
	bne	a5,zero,.L51
	ld	a5,-56(s0)
	lw	a5,4(a5)
	sw	a5,-44(s0)
	lw	a5,-44(s0)
	mv	a1,a5
	ld	a0,-64(s0)
	call	perform_jump
	j	.L50
.L51:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L53
	ld	a5,-32(s0)
	ld	a5,16(a5)
	beq	a5,zero,.L53
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-64(s0)
	sd	a4,0(a5)
	j	.L50
.L53:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L54
	ld	a5,-56(s0)
	lw	a5,4(a5)
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	mv	a1,a5
	ld	a0,-64(s0)
	call	perform_jump
	j	.L50
.L54:
	sb	zero,-17(s0)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	bne	a5,zero,.L55
	ld	a5,-32(s0)
	lw	a5,12(a5)
	seqz	a5,a5
	sb	a5,-17(s0)
	j	.L56
.L55:
	ld	a5,-32(s0)
	lw	a5,8(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L57
	ld	a5,-32(s0)
	flw	fa5,12(a5)
	fmv.s.x	fa4,zero
	feq.s	a5,fa5,fa4
	snez	a5,a5
	sb	a5,-17(s0)
	j	.L56
.L57:
	ld	a5,-32(s0)
	lw	a5,8(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L58
	ld	a5,-32(s0)
	lbu	a5,12(a5)
	sext.w	a5,a5
	snez	a5,a5
	andi	a5,a5,0xff
	xori	a5,a5,1
	andi	a5,a5,0xff
	sext.w	a5,a5
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	andi	a5,a5,1
	sb	a5,-17(s0)
	j	.L56
.L58:
	ld	a5,-80(s0)
	sw	zero,0(a5)
	j	.L50
.L56:
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L59
	ld	a5,-56(s0)
	lw	a5,4(a5)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a1,a5
	ld	a0,-64(s0)
	call	perform_jump
	j	.L50
.L59:
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-64(s0)
	sd	a4,0(a5)
.L50:
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	interpret_jump_relative_if_false, .-interpret_jump_relative_if_false
	.section	.rodata
	.align	3
.LC5:
	.string	"started_interpreting\n"
	.align	3
.LC6:
	.string	"ended_interpreting\n"
	.align	3
.LC7:
	.string	"Interpretation Error: %d\n"
	.align	3
.LC8:
	.string	"Interpretation result: %d\n"
	.align	3
.LC9:
	.string	"Interpretation result: %f\n"
	.align	3
.LC10:
	.string	"Unsupported type: %d\n"
	.align	3
.LC11:
	.string	"Unsupported type\n"
	.text
	.align	1
	.globl	interpret
	.type	interpret, @function
interpret:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	my_printf
	sd	zero,-24(s0)
	ld	a5,-56(s0)
	ld	a5,24(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a2,-24(s0)
	ld	a1,-56(s0)
	ld	a0,-32(s0)
	call	interpret_unit
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	my_printf
	ld	a5,-24(s0)
	beq	a5,zero,.L61
	ld	a5,-24(s0)
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	my_printf
	j	.L60
.L61:
	ld	a5,-56(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	lw	a5,0(a5)
	bne	a5,zero,.L63
	ld	a5,-40(s0)
	lw	a5,8(a5)
	bne	a5,zero,.L64
	ld	a5,-40(s0)
	lw	a5,12(a5)
	mv	a1,a5
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	my_printf
	j	.L60
.L64:
	ld	a5,-40(s0)
	lw	a5,8(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L65
	ld	a5,-40(s0)
	flw	fa5,12(a5)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	my_printf
	j	.L60
.L65:
	ld	a5,-40(s0)
	lw	a5,8(a5)
	mv	a1,a5
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	my_printf
	j	.L60
.L63:
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	my_printf
.L60:
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	interpret, .-interpret
	.ident	"GCC: () 13.2.0"
