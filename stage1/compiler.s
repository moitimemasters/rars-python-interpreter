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
	li	a1,24
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
	li	a1,2
	ld	a0,-40(s0)
	call	create_instruction
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
	li	a1,3
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	flw	fa5,-44(s0)
	fsw	fa5,8(a5)
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
	li	a1,4
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lbu	a4,-41(s0)
	sb	a4,8(a5)
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
	li	a1,5
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
	li	a1,6
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
	.globl	compile_ident
	.type	compile_ident, @function
compile_ident:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	li	a1,0
	mv	a0,a5
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a4,-48(s0)
	ld	a3,8(a4)
	sd	a3,8(a5)
	ld	a4,16(a4)
	sd	a4,16(a5)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_ident, .-compile_ident
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
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	lw	a5,8(a5)
	mv	a1,a5
	mv	a0,a4
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
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	flw	fa5,8(a5)
	fmv.s	fa0,fa5
	mv	a0,a4
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
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	flw	fa5,8(a5)
	fmv.s	fa0,fa5
	mv	a0,a4
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
	ld	a5,-40(s0)
	ld	a5,0(a5)
	li	a1,7
	mv	a0,a5
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-48(s0)
	lw	a4,24(a5)
	ld	a5,-24(s0)
	sw	a4,8(a5)
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
	ld	a5,-56(s0)
	ld	a5,0(a5)
	mv	a0,a5
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
	ld	a5,-56(s0)
	ld	a5,0(a5)
	mv	a0,a5
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
	sw	a4,8(a5)
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
	sw	a4,8(a5)
	nop
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	compile_ternary_if, .-compile_ternary_if
	.align	1
	.globl	match_aug_to_binop
	.type	match_aug_to_binop, @function
match_aug_to_binop:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	addiw	a3,a5,-11
	sext.w	a4,a3
	li	a5,13
	bgtu	a4,a5,.L20
	slli	a5,a3,32
	srli	a5,a5,32
	slli	a4,a5,2
	lui	a5,%hi(.L22)
	addi	a5,a5,%lo(.L22)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L22:
	.word	.L28
	.word	.L20
	.word	.L20
	.word	.L27
	.word	.L20
	.word	.L26
	.word	.L20
	.word	.L25
	.word	.L20
	.word	.L24
	.word	.L20
	.word	.L23
	.word	.L20
	.word	.L21
	.text
.L28:
	li	a5,10
	j	.L29
.L27:
	li	a5,13
	j	.L29
.L26:
	li	a5,15
	j	.L29
.L25:
	li	a5,17
	j	.L29
.L24:
	li	a5,19
	j	.L29
.L23:
	li	a5,21
	j	.L29
.L21:
	li	a5,23
	j	.L29
.L20:
	li	a5,67
.L29:
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	match_aug_to_binop, .-match_aug_to_binop
	.section	.rodata
	.align	3
.LC0:
	.string	"invalid assign target\n"
	.text
	.align	1
	.globl	compile_assign
	.type	compile_assign, @function
compile_assign:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	ld	a5,-64(s0)
	ld	a5,8(a5)
	lw	a5,0(a5)
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	beq	a4,a5,.L31
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,22
	beq	a4,a5,.L31
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,20
	beq	a4,a5,.L31
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	my_printf
	j	.L30
.L31:
	ld	a5,-64(s0)
	lw	a5,24(a5)
	mv	a0,a5
	call	match_aug_to_binop
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,67
	bne	a4,a5,.L33
	ld	a5,-64(s0)
	ld	a5,16(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L34
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,8
	mv	a0,a5
	call	create_instruction
	sd	a0,-48(s0)
	ld	a5,-64(s0)
	ld	a4,8(a5)
	ld	a5,-48(s0)
	ld	a3,8(a4)
	sd	a3,8(a5)
	ld	a4,16(a4)
	sd	a4,16(a5)
	ld	a1,-48(s0)
	ld	a0,-72(s0)
	call	linked_list_push
	j	.L30
.L34:
	ld	a5,-64(s0)
	ld	a5,8(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,9
	mv	a0,a5
	call	create_instruction
	sd	a0,-40(s0)
	ld	a1,-40(s0)
	ld	a0,-72(s0)
	call	linked_list_push
	j	.L30
.L33:
	ld	a5,-64(s0)
	ld	a5,8(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	ld	a5,-64(s0)
	ld	a5,16(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,7
	mv	a0,a5
	call	create_instruction
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	lw	a4,-24(s0)
	sw	a4,8(a5)
	ld	a1,-32(s0)
	ld	a0,-72(s0)
	call	linked_list_push
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L35
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,8
	mv	a0,a5
	call	create_instruction
	sd	a0,-32(s0)
	ld	a5,-64(s0)
	ld	a4,8(a5)
	ld	a5,-32(s0)
	ld	a3,8(a4)
	sd	a3,8(a5)
	ld	a4,16(a4)
	sd	a4,16(a5)
	ld	a1,-32(s0)
	ld	a0,-72(s0)
	call	linked_list_push
	j	.L30
.L35:
	ld	a5,-64(s0)
	ld	a5,8(a5)
	ld	a2,-72(s0)
	mv	a1,a5
	ld	a0,-56(s0)
	call	compile_node
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,9
	mv	a0,a5
	call	create_instruction
	sd	a0,-32(s0)
	ld	a1,-32(s0)
	ld	a0,-72(s0)
	call	linked_list_push
.L30:
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	compile_assign, .-compile_assign
	.align	1
	.globl	compile_function_def
	.type	compile_function_def, @function
compile_function_def:
	addi	sp,sp,-144
	sd	ra,136(sp)
	sd	s0,128(sp)
	sd	s1,120(sp)
	addi	s0,sp,144
	sd	a0,-120(s0)
	sd	a1,-128(s0)
	sd	a2,-136(s0)
	ld	a5,-128(s0)
	ld	a5,16(a5)
	sd	a5,-48(s0)
	ld	a5,-48(s0)
	ld	a5,8(a5)
	sd	a5,-56(s0)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	sd	a5,-40(s0)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-64(s0)
	j	.L37
.L38:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-104(s0)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-112(s0)
	ld	a5,-112(s0)
	ld	a4,-104(s0)
	ld	a3,8(a4)
	sd	a3,0(a5)
	ld	a4,16(a4)
	sd	a4,8(a5)
	ld	a1,-112(s0)
	ld	a0,-64(s0)
	call	linked_list_push
	ld	a5,-40(s0)
	ld	a5,8(a5)
	sd	a5,-40(s0)
.L37:
	ld	a5,-40(s0)
	bne	a5,zero,.L38
	ld	a5,-120(s0)
	ld	a5,8(a5)
	sd	a5,-72(s0)
	ld	a5,-128(s0)
	ld	a4,24(a5)
	ld	a5,-120(s0)
	sd	a4,8(a5)
	ld	a0,-120(s0)
	call	compile
	sd	a0,-80(s0)
	ld	a5,-80(s0)
	ld	s1,8(a5)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,1
	mv	a0,a5
	call	create_instruction
	mv	a5,a0
	mv	a1,a5
	mv	a0,s1
	call	linked_list_push
	ld	a5,-80(s0)
	ld	s1,8(a5)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,11
	mv	a0,a5
	call	create_instruction
	mv	a5,a0
	mv	a1,a5
	mv	a0,s1
	call	linked_list_push
	ld	a5,-120(s0)
	ld	a4,-72(s0)
	sd	a4,8(a5)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,10
	mv	a0,a5
	call	create_instruction
	sd	a0,-88(s0)
	ld	a5,-88(s0)
	ld	a4,-80(s0)
	sd	a4,16(a5)
	ld	a5,-88(s0)
	ld	a4,-64(s0)
	sd	a4,8(a5)
	ld	a1,-88(s0)
	ld	a0,-136(s0)
	call	linked_list_push
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,8
	mv	a0,a5
	call	create_instruction
	sd	a0,-96(s0)
	ld	a5,-128(s0)
	ld	a4,8(a5)
	ld	a5,-96(s0)
	ld	a3,8(a4)
	sd	a3,8(a5)
	ld	a4,16(a4)
	sd	a4,16(a5)
	ld	a1,-96(s0)
	ld	a0,-136(s0)
	call	linked_list_push
	nop
	ld	ra,136(sp)
	ld	s0,128(sp)
	ld	s1,120(sp)
	addi	sp,sp,144
	jr	ra
	.size	compile_function_def, .-compile_function_def
	.align	1
	.globl	compile_lambda_def
	.type	compile_lambda_def, @function
compile_lambda_def:
	addi	sp,sp,-144
	sd	ra,136(sp)
	sd	s0,128(sp)
	sd	s1,120(sp)
	addi	s0,sp,144
	sd	a0,-120(s0)
	sd	a1,-128(s0)
	sd	a2,-136(s0)
	ld	a5,-128(s0)
	ld	a5,8(a5)
	sd	a5,-48(s0)
	ld	a5,-48(s0)
	ld	a5,8(a5)
	sd	a5,-56(s0)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-64(s0)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	sd	a5,-40(s0)
	j	.L40
.L41:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-96(s0)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-104(s0)
	ld	a5,-104(s0)
	ld	a4,-96(s0)
	ld	a3,8(a4)
	sd	a3,0(a5)
	ld	a4,16(a4)
	sd	a4,8(a5)
	ld	a1,-104(s0)
	ld	a0,-64(s0)
	call	linked_list_push
	ld	a5,-40(s0)
	ld	a5,8(a5)
	sd	a5,-40(s0)
.L40:
	ld	a5,-40(s0)
	bne	a5,zero,.L41
	ld	a5,-120(s0)
	ld	a5,8(a5)
	sd	a5,-72(s0)
	ld	a5,-128(s0)
	ld	a4,16(a5)
	ld	a5,-120(s0)
	sd	a4,8(a5)
	ld	a0,-120(s0)
	call	compile
	sd	a0,-80(s0)
	ld	a5,-80(s0)
	ld	s1,8(a5)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,11
	mv	a0,a5
	call	create_instruction
	mv	a5,a0
	mv	a1,a5
	mv	a0,s1
	call	linked_list_push
	ld	a5,-120(s0)
	ld	a4,-72(s0)
	sd	a4,8(a5)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,10
	mv	a0,a5
	call	create_instruction
	sd	a0,-88(s0)
	ld	a5,-88(s0)
	ld	a4,-80(s0)
	sd	a4,16(a5)
	ld	a5,-88(s0)
	ld	a4,-64(s0)
	sd	a4,8(a5)
	ld	a1,-88(s0)
	ld	a0,-136(s0)
	call	linked_list_push
	nop
	ld	ra,136(sp)
	ld	s0,128(sp)
	ld	s1,120(sp)
	addi	sp,sp,144
	jr	ra
	.size	compile_lambda_def, .-compile_lambda_def
	.align	1
	.globl	compile_return
	.type	compile_return, @function
compile_return:
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
	ld	a5,-40(s0)
	ld	a5,0(a5)
	li	a1,11
	mv	a0,a5
	call	create_instruction
	sd	a0,-24(s0)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_return, .-compile_return
	.align	1
	.globl	compile_function_call
	.type	compile_function_call, @function
compile_function_call:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	sd	a2,-88(s0)
	ld	a5,-80(s0)
	ld	a5,16(a5)
	sd	a5,-32(s0)
	ld	a5,-32(s0)
	ld	a5,8(a5)
	ld	a5,8(a5)
	sd	a5,-40(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L44
.L45:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	sd	a5,-56(s0)
	ld	a2,-88(s0)
	ld	a1,-56(s0)
	ld	a0,-72(s0)
	call	compile_node
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L44:
	ld	a5,-24(s0)
	bne	a5,zero,.L45
	ld	a5,-80(s0)
	ld	a5,8(a5)
	ld	a2,-88(s0)
	mv	a1,a5
	ld	a0,-72(s0)
	call	compile_node
	ld	a5,-72(s0)
	ld	a5,0(a5)
	li	a1,12
	mv	a0,a5
	call	create_instruction
	sd	a0,-48(s0)
	ld	a5,-40(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	ld	a5,-48(s0)
	sw	a4,8(a5)
	ld	a1,-48(s0)
	ld	a0,-88(s0)
	call	linked_list_push
	nop
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	compile_function_call, .-compile_function_call
	.align	1
	.globl	compile_while_loop
	.type	compile_while_loop, @function
compile_while_loop:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	sd	a2,-88(s0)
	ld	a5,-88(s0)
	ld	a5,16(a5)
	sw	a5,-28(s0)
	ld	a5,-80(s0)
	ld	a5,8(a5)
	ld	a2,-88(s0)
	mv	a1,a5
	ld	a0,-72(s0)
	call	compile_node
	ld	a5,-88(s0)
	ld	a5,16(a5)
	sw	a5,-32(s0)
	ld	a5,-72(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	create_jump_relative_if_false_instruction
	sd	a0,-40(s0)
	ld	a1,-40(s0)
	ld	a0,-88(s0)
	call	linked_list_push
	ld	a5,-80(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L47
.L48:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	ld	a2,-88(s0)
	mv	a1,a5
	ld	a0,-72(s0)
	call	compile_node
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L47:
	ld	a5,-24(s0)
	bne	a5,zero,.L48
	ld	a5,-72(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	create_jump_relative_instruction
	sd	a0,-48(s0)
	lw	a4,-28(s0)
	ld	a5,-88(s0)
	ld	a5,16(a5)
	sext.w	a5,a5
	subw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-48(s0)
	sw	a4,8(a5)
	ld	a1,-48(s0)
	ld	a0,-88(s0)
	call	linked_list_push
	ld	a5,-72(s0)
	ld	a5,0(a5)
	li	a1,13
	mv	a0,a5
	call	create_instruction
	sd	a0,-56(s0)
	ld	a1,-56(s0)
	ld	a0,-88(s0)
	call	linked_list_push
	ld	a5,-88(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	lw	a5,-32(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-40(s0)
	sw	a4,8(a5)
	nop
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	compile_while_loop, .-compile_while_loop
	.align	1
	.globl	compile_many_nodes
	.type	compile_many_nodes, @function
compile_many_nodes:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sd	a3,-64(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L50
.L51:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	ld	a2,-64(s0)
	mv	a1,a5
	ld	a0,-48(s0)
	call	compile_node
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L50:
	ld	a5,-24(s0)
	bne	a5,zero,.L51
	nop
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_many_nodes, .-compile_many_nodes
	.align	1
	.globl	compile_if_statement
	.type	compile_if_statement, @function
compile_if_statement:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	sd	a2,-104(s0)
	ld	a5,-96(s0)
	ld	a5,8(a5)
	sd	a5,-40(s0)
	ld	a5,-88(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	create_jump_relative_instruction
	sd	a0,-48(s0)
	ld	a5,-88(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	create_jump_relative_if_false_instruction
	sd	a0,-24(s0)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	ld	a2,-104(s0)
	mv	a1,a5
	ld	a0,-88(s0)
	call	compile_node
	ld	a5,-104(s0)
	ld	a5,16(a5)
	sw	a5,-28(s0)
	ld	a1,-24(s0)
	ld	a0,-104(s0)
	call	linked_list_push
	ld	a5,-40(s0)
	ld	a5,16(a5)
	ld	a3,-104(s0)
	ld	a2,-96(s0)
	ld	a1,-88(s0)
	mv	a0,a5
	call	compile_many_nodes
	ld	a1,-48(s0)
	ld	a0,-104(s0)
	call	linked_list_push
	ld	a5,-96(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	sd	a5,-56(s0)
	j	.L53
.L54:
	ld	a5,-104(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,8(a5)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	sd	a5,-72(s0)
	ld	a5,-88(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	create_jump_relative_instruction
	sd	a0,-24(s0)
	ld	a5,-72(s0)
	ld	a5,8(a5)
	ld	a2,-104(s0)
	mv	a1,a5
	ld	a0,-88(s0)
	call	compile_node
	ld	a5,-104(s0)
	ld	a5,16(a5)
	sw	a5,-28(s0)
	ld	a1,-24(s0)
	ld	a0,-104(s0)
	call	linked_list_push
	ld	a5,-72(s0)
	ld	a5,16(a5)
	ld	a3,-104(s0)
	ld	a2,-96(s0)
	ld	a1,-88(s0)
	mv	a0,a5
	call	compile_many_nodes
	ld	a1,-48(s0)
	ld	a0,-104(s0)
	call	linked_list_push
.L53:
	ld	a5,-56(s0)
	bne	a5,zero,.L54
	ld	a5,-96(s0)
	ld	a5,24(a5)
	sd	a5,-64(s0)
	ld	a5,-64(s0)
	beq	a5,zero,.L55
	ld	a5,-104(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,8(a5)
	ld	a5,-64(s0)
	ld	a5,16(a5)
	ld	a3,-104(s0)
	ld	a2,-96(s0)
	ld	a1,-88(s0)
	mv	a0,a5
	call	compile_many_nodes
	j	.L56
.L55:
	ld	a5,-104(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	lw	a5,-28(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,8(a5)
.L56:
	ld	a5,-104(s0)
	ld	a5,16(a5)
	sext.w	a4,a5
	ld	a5,-48(s0)
	sw	a4,8(a5)
	nop
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	compile_if_statement, .-compile_if_statement
	.align	1
	.globl	compile_break
	.type	compile_break, @function
compile_break:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	li	a1,14
	mv	a0,a5
	call	create_instruction
	sd	a0,-24(s0)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_break, .-compile_break
	.section	.rodata
	.align	3
.LC1:
	.string	"unrecognized node!\n"
	.align	3
.LC2:
	.string	"node type: %d\n"
	.align	3
.LC3:
	.string	"compiled node %d\n"
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
	li	a4,31
	bgtu	a3,a4,.L59
	slli	a4,a5,2
	lui	a5,%hi(.L61)
	addi	a5,a5,%lo(.L61)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L61:
	.word	.L73
	.word	.L72
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L71
	.word	.L70
	.word	.L59
	.word	.L69
	.word	.L68
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L67
	.word	.L66
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L59
	.word	.L65
	.word	.L59
	.word	.L64
	.word	.L63
	.word	.L59
	.word	.L62
	.word	.L60
	.text
.L71:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_ident
	j	.L74
.L73:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_int
	j	.L74
.L72:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_float
	j	.L74
.L70:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_binop
	j	.L74
.L68:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_ternary_if
	j	.L74
.L69:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_assign
	j	.L74
.L63:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_function_def
	j	.L74
.L67:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_lambda_def
	j	.L74
.L66:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_function_call
	j	.L74
.L60:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_return
	j	.L74
.L62:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_break
	j	.L74
.L64:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_while_loop
	j	.L74
.L65:
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	compile_if_statement
	j	.L74
.L59:
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	my_printf
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	my_printf
	nop
.L74:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	my_printf
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	compile_node, .-compile_node
	.align	1
	.globl	compile
	.type	compile, @function
compile:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a5,8(a5)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,32
	bne	a4,a5,.L76
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-40(s0)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-40(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,0(a5)
	ld	a5,-40(s0)
	sd	a4,0(a5)
	ld	a5,-56(s0)
	ld	a5,8(a5)
	ld	a5,8(a5)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L77
.L78:
	ld	a5,-24(s0)
	ld	a4,0(a5)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	mv	a2,a5
	mv	a1,a4
	ld	a0,-56(s0)
	call	compile_node
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L77:
	ld	a5,-24(s0)
	bne	a5,zero,.L78
	ld	a5,-40(s0)
	j	.L79
.L76:
	ld	a5,-56(s0)
	ld	a5,0(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-32(s0)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-32(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	sd	a4,0(a5)
	ld	a5,-56(s0)
	ld	a4,8(a5)
	ld	a5,-32(s0)
	ld	a5,8(a5)
	mv	a2,a5
	mv	a1,a4
	ld	a0,-56(s0)
	call	compile_node
	ld	a5,-32(s0)
.L79:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile, .-compile
	.ident	"GCC: () 13.2.0"
