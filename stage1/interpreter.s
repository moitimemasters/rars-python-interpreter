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
	li	a4,14
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
	.word	.L21
	.word	.L20
	.word	.L19
	.word	.L18
	.word	.L7
	.word	.L17
	.word	.L16
	.word	.L15
	.word	.L14
	.word	.L7
	.word	.L13
	.word	.L12
	.word	.L11
	.word	.L10
	.word	.L8
	.text
.L21:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_load
	j	.L6
.L20:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_load_none
	j	.L6
.L12:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_return
	j	.L6
.L19:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_load_int
	j	.L6
.L18:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_load_float
	j	.L6
.L15:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_binop
	j	.L6
.L17:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_jump_relative
	j	.L6
.L16:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_jump_relative_if_false
	j	.L6
.L14:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_store
	j	.L6
.L13:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_anon_fun
	j	.L6
.L11:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_call
	j	.L6
.L8:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_break
	j	.L6
.L10:
	ld	a3,-48(s0)
	ld	a2,-40(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	interpret_mark
.L7:
	ld	a5,-48(s0)
	li	a4,2
	sw	a4,0(a5)
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
	flw	fa5,8(a5)
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
	lw	a4,8(a5)
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
	.align	3
.LC5:
	.string	"lt_binop"
	.align	3
.LC6:
	.string	"leq_binop"
	.align	3
.LC7:
	.string	"gt_binop"
	.align	3
.LC8:
	.string	"geq_binop"
	.align	3
.LC9:
	.string	"eq_binop"
	.align	3
.LC10:
	.string	"neq_binop"
	.align	3
.LC11:
	.string	"Unknown binary operation: %d\n"
	.text
	.align	1
	.globl	interpret_binop
	.type	interpret_binop, @function
interpret_binop:
	addi	sp,sp,-480
	sd	ra,472(sp)
	sd	s0,464(sp)
	addi	s0,sp,480
	sd	a0,-456(s0)
	sd	a1,-464(s0)
	sd	a2,-472(s0)
	sd	a3,-480(s0)
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-472(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a5,-472(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a5,-456(s0)
	lw	a5,8(a5)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	addiw	a3,a5,-10
	sext.w	a4,a3
	li	a5,24
	bgtu	a4,a5,.L26
	slli	a5,a3,32
	srli	a5,a5,32
	slli	a4,a5,2
	lui	a5,%hi(.L28)
	addi	a5,a5,%lo(.L28)
	add	a5,a4,a5
	lw	a5,0(a5)
	jr	a5
	.section	.rodata
	.align	2
	.align	2
.L28:
	.word	.L37
	.word	.L26
	.word	.L26
	.word	.L36
	.word	.L26
	.word	.L35
	.word	.L26
	.word	.L34
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L26
	.word	.L33
	.word	.L32
	.word	.L31
	.word	.L30
	.word	.L29
	.word	.L27
	.text
.L37:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC1)
	addi	a5,a5,%lo(.LC1)
	sd	a5,-296(s0)
	li	a5,9
	sd	a5,-288(s0)
	ld	a1,-296(s0)
	ld	a2,-288(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-264(s0)
	ld	a5,-264(s0)
	bne	a5,zero,.L38
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L38:
	ld	a5,-472(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-272(s0)
	ld	a1,-32(s0)
	ld	a0,-272(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-272(s0)
	call	linked_list_push
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-264(s0)
	ld	a2,-480(s0)
	ld	a1,-272(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-280(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L70
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-280(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L36:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC2)
	addi	a5,a5,%lo(.LC2)
	sd	a5,-312(s0)
	li	a5,9
	sd	a5,-304(s0)
	ld	a1,-312(s0)
	ld	a2,-304(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-240(s0)
	ld	a5,-240(s0)
	bne	a5,zero,.L43
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L43:
	ld	a5,-472(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-248(s0)
	ld	a1,-32(s0)
	ld	a0,-248(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-248(s0)
	call	linked_list_push
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-240(s0)
	ld	a2,-480(s0)
	ld	a1,-248(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-256(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L71
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-256(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L35:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC3)
	addi	a5,a5,%lo(.LC3)
	sd	a5,-328(s0)
	li	a5,9
	sd	a5,-320(s0)
	ld	a1,-328(s0)
	ld	a2,-320(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-216(s0)
	ld	a5,-216(s0)
	bne	a5,zero,.L46
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L46:
	ld	a5,-472(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-224(s0)
	ld	a1,-32(s0)
	ld	a0,-224(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-224(s0)
	call	linked_list_push
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-216(s0)
	ld	a2,-480(s0)
	ld	a1,-224(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-232(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L72
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-232(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L34:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC4)
	addi	a5,a5,%lo(.LC4)
	sd	a5,-344(s0)
	li	a5,9
	sd	a5,-336(s0)
	ld	a1,-344(s0)
	ld	a2,-336(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-192(s0)
	ld	a5,-192(s0)
	bne	a5,zero,.L49
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L49:
	ld	a5,-472(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-200(s0)
	ld	a1,-32(s0)
	ld	a0,-200(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-200(s0)
	call	linked_list_push
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-192(s0)
	ld	a2,-480(s0)
	ld	a1,-200(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-208(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L73
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-208(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L31:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC5)
	addi	a5,a5,%lo(.LC5)
	sd	a5,-360(s0)
	li	a5,8
	sd	a5,-352(s0)
	ld	a1,-360(s0)
	ld	a2,-352(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-120(s0)
	ld	a5,-120(s0)
	bne	a5,zero,.L52
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L52:
	ld	a5,-472(s0)
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
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-120(s0)
	ld	a2,-480(s0)
	ld	a1,-128(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-136(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L74
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-136(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L30:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC6)
	addi	a5,a5,%lo(.LC6)
	sd	a5,-376(s0)
	li	a5,9
	sd	a5,-368(s0)
	ld	a1,-376(s0)
	ld	a2,-368(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-96(s0)
	ld	a5,-96(s0)
	bne	a5,zero,.L55
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L55:
	ld	a5,-472(s0)
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
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-96(s0)
	ld	a2,-480(s0)
	ld	a1,-104(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-112(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L75
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-112(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L29:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC7)
	addi	a5,a5,%lo(.LC7)
	sd	a5,-392(s0)
	li	a5,8
	sd	a5,-384(s0)
	ld	a1,-392(s0)
	ld	a2,-384(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-72(s0)
	ld	a5,-72(s0)
	bne	a5,zero,.L58
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L58:
	ld	a5,-472(s0)
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
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-72(s0)
	ld	a2,-480(s0)
	ld	a1,-80(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-88(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L76
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-88(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L27:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC8)
	addi	a5,a5,%lo(.LC8)
	sd	a5,-408(s0)
	li	a5,9
	sd	a5,-400(s0)
	ld	a1,-408(s0)
	ld	a2,-400(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L61
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L61:
	ld	a5,-472(s0)
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
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	ld	a2,-480(s0)
	ld	a1,-56(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-64(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L77
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L33:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC9)
	addi	a5,a5,%lo(.LC9)
	sd	a5,-424(s0)
	li	a5,8
	sd	a5,-416(s0)
	ld	a1,-424(s0)
	ld	a2,-416(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-168(s0)
	ld	a5,-168(s0)
	bne	a5,zero,.L64
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L64:
	ld	a5,-472(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-176(s0)
	ld	a1,-32(s0)
	ld	a0,-176(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-176(s0)
	call	linked_list_push
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-168(s0)
	ld	a2,-480(s0)
	ld	a1,-176(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-184(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L78
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-184(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L32:
	ld	a5,-472(s0)
	ld	a4,32(a5)
	lui	a5,%hi(.LC10)
	addi	a5,a5,%lo(.LC10)
	sd	a5,-440(s0)
	li	a5,9
	sd	a5,-432(s0)
	ld	a1,-440(s0)
	ld	a2,-432(s0)
	mv	a0,a4
	call	hash_table_get_string
	mv	a5,a0
	sd	a5,-144(s0)
	ld	a5,-144(s0)
	bne	a5,zero,.L67
	ld	a5,-480(s0)
	li	a4,3
	sw	a4,0(a5)
	j	.L25
.L67:
	ld	a5,-472(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-152(s0)
	ld	a1,-32(s0)
	ld	a0,-152(s0)
	call	linked_list_push
	ld	a1,-24(s0)
	ld	a0,-152(s0)
	call	linked_list_push
	ld	a5,-472(s0)
	ld	a4,0(a5)
	ld	a5,-144(s0)
	ld	a2,-480(s0)
	ld	a1,-152(s0)
	mv	a0,a4
	jalr	a5
	sd	a0,-160(s0)
	ld	a5,-480(s0)
	bne	a5,zero,.L79
	ld	a5,-472(s0)
	ld	a5,16(a5)
	ld	a1,-160(s0)
	mv	a0,a5
	call	stack_push
	j	.L41
.L26:
	ld	a5,-480(s0)
	li	a4,2
	sw	a4,0(a5)
	lw	a5,-36(s0)
	mv	a1,a5
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	my_printf
	j	.L25
.L41:
	ld	a5,-464(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-464(s0)
	sd	a4,0(a5)
	j	.L25
.L70:
	nop
	j	.L25
.L71:
	nop
	j	.L25
.L72:
	nop
	j	.L25
.L73:
	nop
	j	.L25
.L74:
	nop
	j	.L25
.L75:
	nop
	j	.L25
.L76:
	nop
	j	.L25
.L77:
	nop
	j	.L25
.L78:
	nop
	j	.L25
.L79:
	nop
.L25:
	ld	ra,472(sp)
	ld	s0,464(sp)
	addi	sp,sp,480
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
	bge	a5,zero,.L81
	sw	zero,-20(s0)
	j	.L82
.L84:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,16(a5)
	ld	a5,-40(s0)
	sd	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L82:
	lw	a5,-44(s0)
	negw	a5,a5
	sext.w	a4,a5
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,a4,.L87
	ld	a5,-40(s0)
	ld	a5,0(a5)
	bne	a5,zero,.L84
	j	.L87
.L81:
	sw	zero,-24(s0)
	j	.L85
.L86:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-40(s0)
	sd	a4,0(a5)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L85:
	lw	a5,-24(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	bge	a4,a5,.L87
	ld	a5,-40(s0)
	bne	a5,zero,.L86
.L87:
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
	lw	a5,8(a5)
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
	bne	a5,zero,.L90
	ld	a5,-56(s0)
	lw	a5,8(a5)
	sw	a5,-44(s0)
	lw	a5,-44(s0)
	mv	a1,a5
	ld	a0,-64(s0)
	call	perform_jump
	j	.L89
.L90:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L92
	ld	a5,-32(s0)
	ld	a5,16(a5)
	beq	a5,zero,.L92
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-64(s0)
	sd	a4,0(a5)
	j	.L89
.L92:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L93
	ld	a5,-56(s0)
	lw	a5,8(a5)
	sw	a5,-40(s0)
	lw	a5,-40(s0)
	mv	a1,a5
	ld	a0,-64(s0)
	call	perform_jump
	j	.L89
.L93:
	sb	zero,-17(s0)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	bne	a5,zero,.L94
	ld	a5,-32(s0)
	lw	a5,12(a5)
	seqz	a5,a5
	sb	a5,-17(s0)
	j	.L95
.L94:
	ld	a5,-32(s0)
	lw	a5,8(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L96
	ld	a5,-32(s0)
	flw	fa5,12(a5)
	fmv.s.x	fa4,zero
	feq.s	a5,fa5,fa4
	snez	a5,a5
	sb	a5,-17(s0)
	j	.L95
.L96:
	ld	a5,-32(s0)
	lw	a5,8(a5)
	mv	a4,a5
	li	a5,2
	bne	a4,a5,.L97
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
	j	.L95
.L97:
	ld	a5,-80(s0)
	sw	zero,0(a5)
	j	.L89
.L95:
	lbu	a5,-17(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L98
	ld	a5,-56(s0)
	lw	a5,8(a5)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	mv	a1,a5
	ld	a0,-64(s0)
	call	perform_jump
	j	.L89
.L98:
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-64(s0)
	sd	a4,0(a5)
.L89:
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	interpret_jump_relative_if_false, .-interpret_jump_relative_if_false
	.align	1
	.globl	interpret_store
	.type	interpret_store, @function
interpret_store:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sd	a3,-64(s0)
	ld	a5,-56(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-56(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a5,-56(s0)
	ld	a4,8(a5)
	ld	a5,-40(s0)
	ld	a3,-24(s0)
	ld	a1,8(a5)
	ld	a2,16(a5)
	mv	a0,a4
	call	env_store
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
	.size	interpret_store, .-interpret_store
	.section	.rodata
	.align	3
.LC12:
	.string	"ERROR: Variable not found\n"
	.text
	.align	1
	.globl	interpret_load
	.type	interpret_load, @function
interpret_load:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sd	a3,-64(s0)
	ld	a5,-56(s0)
	ld	a4,8(a5)
	ld	a5,-40(s0)
	ld	a1,8(a5)
	ld	a2,16(a5)
	mv	a0,a4
	call	env_load
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L101
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	my_printf
	ld	a5,-64(s0)
	li	a4,5
	sw	a4,0(a5)
	j	.L100
.L101:
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
.L100:
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	interpret_load, .-interpret_load
	.align	1
	.globl	interpret_anon_fun
	.type	interpret_anon_fun, @function
interpret_anon_fun:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	sd	s1,88(sp)
	addi	s0,sp,112
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	sd	a3,-80(s0)
	ld	a5,-72(s0)
	ld	a5,0(a5)
	li	a1,1
	mv	a0,a5
	call	create_pyobject
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	li	a4,3
	sw	a4,8(a5)
	ld	a5,-72(s0)
	ld	a5,0(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-56(s0)
	ld	a3,8(a4)
	sd	a3,0(a5)
	ld	a4,16(a4)
	sd	a4,8(a5)
	ld	a5,-72(s0)
	ld	a4,0(a5)
	ld	s1,-40(s0)
	addi	a5,s0,-112
	ld	a2,-48(s0)
	mv	a1,a4
	mv	a0,a5
	call	make_shared
	ld	a2,-112(s0)
	ld	a3,-104(s0)
	ld	a4,-96(s0)
	ld	a5,-88(s0)
	sd	a2,16(s1)
	sd	a3,24(s1)
	sd	a4,32(s1)
	sd	a5,40(s1)
	ld	a5,-72(s0)
	ld	a5,16(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	stack_push
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-64(s0)
	sd	a4,0(a5)
	nop
	ld	ra,104(sp)
	ld	s0,96(sp)
	ld	s1,88(sp)
	addi	sp,sp,112
	jr	ra
	.size	interpret_anon_fun, .-interpret_anon_fun
	.align	1
	.globl	interpret_return
	.type	interpret_return, @function
interpret_return:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	sd	a3,-48(s0)
	ld	a5,-32(s0)
	sd	zero,0(a5)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	interpret_return, .-interpret_return
	.align	1
	.globl	interpret_mark
	.type	interpret_mark, @function
interpret_mark:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	sd	a3,-48(s0)
	ld	a5,-32(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-32(s0)
	sd	a4,0(a5)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	interpret_mark, .-interpret_mark
	.align	1
	.globl	interpret_break
	.type	interpret_break, @function
interpret_break:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	sd	a3,-48(s0)
	j	.L107
.L109:
	ld	a5,-32(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-32(s0)
	sd	a4,0(a5)
.L107:
	ld	a5,-32(s0)
	ld	a5,0(a5)
	beq	a5,zero,.L110
	ld	a5,-32(s0)
	ld	a5,0(a5)
	ld	a5,0(a5)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,13
	bne	a4,a5,.L109
.L110:
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	interpret_break, .-interpret_break
	.align	1
	.globl	interpret_load_none
	.type	interpret_load_none, @function
interpret_load_none:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	sd	a3,-48(s0)
	ld	a5,-40(s0)
	ld	a5,16(a5)
	li	a1,0
	mv	a0,a5
	call	stack_push
	ld	a5,-32(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-32(s0)
	sd	a4,0(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	interpret_load_none, .-interpret_load_none
	.section	.rodata
	.align	3
.LC13:
	.string	"not enough args\n"
	.text
	.align	1
	.globl	interpret_call
	.type	interpret_call, @function
interpret_call:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-104(s0)
	sd	a1,-112(s0)
	sd	a2,-120(s0)
	sd	a3,-128(s0)
	ld	a5,-120(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-56(s0)
	ld	a5,-120(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a5,-56(s0)
	ld	a5,16(a5)
	sd	a5,-64(s0)
	ld	a5,-104(s0)
	lw	a5,8(a5)
	mv	a4,a5
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a5,16(a5)
	beq	a4,a5,.L113
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	my_printf
	ld	a5,-128(s0)
	li	a4,4
	sw	a4,0(a5)
	j	.L112
.L113:
	ld	a5,-120(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-72(s0)
	sw	zero,-20(s0)
	j	.L115
.L116:
	ld	a5,-120(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-96(s0)
	ld	a5,-120(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_pop
	ld	a1,-96(s0)
	ld	a0,-72(s0)
	call	linked_list_push
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L115:
	ld	a5,-104(s0)
	lw	a4,8(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	blt	a5,a4,.L116
	ld	a0,-72(s0)
	call	linked_list_reverse
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,24
	mv	a0,a5
	call	my_alloc
	sd	a0,-80(s0)
	ld	a5,-120(s0)
	ld	a4,0(a5)
	ld	a5,-80(s0)
	sd	a4,16(a5)
	ld	a5,-120(s0)
	ld	a4,8(a5)
	ld	a5,-80(s0)
	sd	a4,0(a5)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	hash_table_create
	mv	a4,a0
	ld	a5,-80(s0)
	sd	a4,8(a5)
	ld	a5,-72(s0)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-40(s0)
	sw	zero,-44(s0)
	j	.L117
.L118:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-32(s0)
	ld	a4,0(a4)
	mv	a3,a4
	ld	a1,0(a5)
	ld	a2,8(a5)
	ld	a0,-80(s0)
	call	env_store
	ld	a5,-32(s0)
	ld	a5,8(a5)
	sd	a5,-32(s0)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	sd	a5,-40(s0)
	lw	a5,-44(s0)
	addiw	a5,a5,1
	sw	a5,-44(s0)
.L117:
	lw	a4,-44(s0)
	ld	a5,-72(s0)
	ld	a5,16(a5)
	bltu	a4,a5,.L118
	ld	a5,-120(s0)
	ld	a5,0(a5)
	li	a1,40
	mv	a0,a5
	call	my_alloc
	sd	a0,-88(s0)
	ld	a5,-120(s0)
	ld	a4,0(a5)
	ld	a5,-88(s0)
	sd	a4,0(a5)
	ld	a5,-88(s0)
	ld	a4,-80(s0)
	sd	a4,8(a5)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	stack_create
	mv	a4,a0
	ld	a5,-88(s0)
	sd	a4,16(a5)
	ld	a5,-120(s0)
	ld	a4,32(a5)
	ld	a5,-88(s0)
	sd	a4,32(a5)
	ld	a5,-64(s0)
	ld	a4,8(a5)
	ld	a5,-88(s0)
	sd	a4,24(a5)
	ld	a0,-88(s0)
	call	interpret
	ld	a5,-120(s0)
	ld	a4,16(a5)
	ld	a5,-88(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	mv	a1,a5
	mv	a0,a4
	call	stack_push
	ld	a5,-88(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	stack_free
	ld	a5,-80(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	hash_table_free
	ld	a5,-88(s0)
	ld	a5,8(a5)
	ld	a4,16(a5)
	ld	a5,-88(s0)
	ld	a5,8(a5)
	mv	a1,a5
	mv	a0,a4
	call	my_free
	ld	a5,-120(s0)
	ld	a5,0(a5)
	ld	a1,-88(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-112(s0)
	ld	a5,0(a5)
	ld	a4,8(a5)
	ld	a5,-112(s0)
	sd	a4,0(a5)
.L112:
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	interpret_call, .-interpret_call
	.align	1
	.globl	interpret
	.type	interpret, @function
interpret:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	zero,-24(s0)
	ld	a5,-40(s0)
	ld	a5,24(a5)
	ld	a2,-24(s0)
	ld	a1,-40(s0)
	mv	a0,a5
	call	interpret_unit
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	interpret, .-interpret
	.ident	"GCC: () 13.2.0"
