	.file	"main.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"add_binop"
	.align	3
.LC1:
	.string	"sub_binop"
	.align	3
.LC2:
	.string	"mul_binop"
	.align	3
.LC3:
	.string	"div_binop"
	.align	3
.LC4:
	.string	"lt_binop"
	.align	3
.LC5:
	.string	"leq_binop"
	.align	3
.LC6:
	.string	"gt_binop"
	.align	3
.LC7:
	.string	"geq_binop"
	.align	3
.LC8:
	.string	"eq_binop"
	.align	3
.LC9:
	.string	"neq_binop"
	.text
	.align	1
	.globl	populate_c_functions
	.type	populate_c_functions, @function
populate_c_functions:
	addi	sp,sp,-192
	sd	ra,184(sp)
	sd	s0,176(sp)
	addi	s0,sp,192
	sd	a0,-184(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-176(s0)
	sd	a5,-168(s0)
	lui	a5,%hi(add_binop)
	addi	a3,a5,%lo(add_binop)
	ld	a1,-176(s0)
	ld	a2,-168(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-160(s0)
	sd	a5,-152(s0)
	lui	a5,%hi(sub_binop)
	addi	a3,a5,%lo(sub_binop)
	ld	a1,-160(s0)
	ld	a2,-152(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-144(s0)
	sd	a5,-136(s0)
	lui	a5,%hi(mul_binop)
	addi	a3,a5,%lo(mul_binop)
	ld	a1,-144(s0)
	ld	a2,-136(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-128(s0)
	sd	a5,-120(s0)
	lui	a5,%hi(div_binop)
	addi	a3,a5,%lo(div_binop)
	ld	a1,-128(s0)
	ld	a2,-120(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-112(s0)
	sd	a5,-104(s0)
	lui	a5,%hi(lt_binop)
	addi	a3,a5,%lo(lt_binop)
	ld	a1,-112(s0)
	ld	a2,-104(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-96(s0)
	sd	a5,-88(s0)
	lui	a5,%hi(leq_binop)
	addi	a3,a5,%lo(leq_binop)
	ld	a1,-96(s0)
	ld	a2,-88(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-80(s0)
	sd	a5,-72(s0)
	lui	a5,%hi(gt_binop)
	addi	a3,a5,%lo(gt_binop)
	ld	a1,-80(s0)
	ld	a2,-72(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-64(s0)
	sd	a5,-56(s0)
	lui	a5,%hi(geq_binop)
	addi	a3,a5,%lo(geq_binop)
	ld	a1,-64(s0)
	ld	a2,-56(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-48(s0)
	sd	a5,-40(s0)
	lui	a5,%hi(eq_binop)
	addi	a3,a5,%lo(eq_binop)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-32(s0)
	sd	a5,-24(s0)
	lui	a5,%hi(neq_binop)
	addi	a3,a5,%lo(neq_binop)
	ld	a1,-32(s0)
	ld	a2,-24(s0)
	ld	a0,-184(s0)
	call	hash_table_insert_string
	nop
	ld	ra,184(sp)
	ld	s0,176(sp)
	addi	sp,sp,192
	jr	ra
	.size	populate_c_functions, .-populate_c_functions
	.section	.rodata
	.align	3
.LC10:
	.string	"please specify path to .py file\n"
	.align	3
.LC11:
	.string	"test.py"
	.align	3
.LC12:
	.string	"started lexing\n"
	.align	3
.LC13:
	.string	"ended lexing\n"
	.align	3
.LC14:
	.string	"Invalid token at line %d, column %d\n"
	.align	3
.LC15:
	.string	"started parsing ast\n"
	.align	3
.LC16:
	.string	"ended parsing ast\n"
	.align	3
.LC17:
	.string	"Error parsing\n"
	.align	3
.LC18:
	.string	"started compiling\n"
	.align	3
.LC19:
	.string	"Error compiling\n"
	.align	3
.LC20:
	.string	"ended compiling\n"
	.align	3
.LC21:
	.string	"started interpreting\n"
	.align	3
.LC22:
	.string	"ended interpreting\n"
	.align	3
.LC23:
	.string	"Interpretation result: %d\n"
	.align	3
.LC24:
	.string	"Interpretation result: %f\n"
	.align	3
.LC25:
	.string	"Unsupported type: %d\n"
	.align	3
.LC26:
	.string	"Unsupported type\n"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-240
	sd	ra,232(sp)
	sd	s0,224(sp)
	addi	s0,sp,240
	mv	a5,a0
	sd	a1,-240(s0)
	sw	a5,-228(s0)
	lw	a5,-228(s0)
	sext.w	a4,a5
	li	a5,2
	beq	a4,a5,.L3
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	my_printf
	lui	a5,%hi(.LC11)
	addi	a5,a5,%lo(.LC11)
	sd	a5,-24(s0)
	j	.L4
.L3:
	ld	a5,-240(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L4:
	li	a5,268697600
	sd	a5,-112(s0)
	li	a5,805306368
	sd	a5,-104(s0)
	addi	a5,s0,-112
	ld	a1,-24(s0)
	mv	a0,a5
	call	read_whole_file
	sd	a0,-40(s0)
	addi	a5,s0,-112
	sd	a5,-120(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-160(s0)
	ld	a5,-40(s0)
	lw	a5,8(a5)
	sd	a5,-136(s0)
	sw	zero,-152(s0)
	li	a5,1
	sw	a5,-148(s0)
	sw	zero,-140(s0)
	li	a5,4
	sw	a5,-144(s0)
	sb	zero,-128(s0)
	addi	a4,s0,-112
	li	a5,4096
	addi	a1,a5,704
	mv	a0,a4
	call	my_alloc
	sd	a0,-48(s0)
	sw	zero,-28(s0)
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	my_printf
	j	.L5
.L7:
	lw	a5,-28(s0)
	addiw	a4,a5,1
	sw	a4,-28(s0)
	slli	a5,a5,5
	ld	a4,-48(s0)
	add	a5,a4,a5
	ld	a1,-192(s0)
	ld	a2,-184(s0)
	ld	a3,-176(s0)
	ld	a4,-168(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
.L5:
	addi	a5,s0,-192
	addi	a4,s0,-160
	mv	a1,a4
	mv	a0,a5
	call	next_token
	lw	a5,-192(s0)
	mv	a4,a5
	li	a5,66
	beq	a4,a5,.L6
	lw	a5,-192(s0)
	mv	a4,a5
	li	a5,67
	bne	a4,a5,.L7
.L6:
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	my_printf
	lw	a5,-192(s0)
	mv	a4,a5
	li	a5,67
	bne	a4,a5,.L8
	lw	a5,-172(s0)
	lw	a4,-140(s0)
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	my_printf
	call	Exit
.L8:
	sw	zero,-208(s0)
	addi	a5,s0,-112
	sd	a5,-224(s0)
	lw	a5,-28(s0)
	sw	a5,-204(s0)
	ld	a5,-48(s0)
	sd	a5,-216(s0)
	sw	zero,-200(s0)
	lui	a5,%hi(.LC15)
	addi	a0,a5,%lo(.LC15)
	call	my_printf
	addi	a5,s0,-224
	mv	a0,a5
	call	parse
	sd	a0,-56(s0)
	lui	a5,%hi(.LC16)
	addi	a0,a5,%lo(.LC16)
	call	my_printf
	ld	a5,-56(s0)
	bne	a5,zero,.L9
	lui	a5,%hi(.LC17)
	addi	a0,a5,%lo(.LC17)
	call	my_printf
	call	Exit
.L9:
	lui	a5,%hi(.LC18)
	addi	a0,a5,%lo(.LC18)
	call	my_printf
	addi	a5,s0,-112
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	addi	a4,s0,-112
	sd	a4,0(a5)
	ld	a5,-64(s0)
	ld	a4,-56(s0)
	sd	a4,8(a5)
	ld	a0,-64(s0)
	call	compile
	sd	a0,-72(s0)
	ld	a5,-72(s0)
	bne	a5,zero,.L10
	lui	a5,%hi(.LC19)
	addi	a0,a5,%lo(.LC19)
	call	my_printf
	call	Exit
.L10:
	lui	a5,%hi(.LC20)
	addi	a0,a5,%lo(.LC20)
	call	my_printf
	addi	a5,s0,-112
	li	a1,24
	mv	a0,a5
	call	my_alloc
	sd	a0,-80(s0)
	addi	a5,s0,-112
	mv	a0,a5
	call	hash_table_create
	mv	a4,a0
	ld	a5,-80(s0)
	sd	a4,8(a5)
	ld	a5,-80(s0)
	sd	zero,0(a5)
	ld	a5,-80(s0)
	addi	a4,s0,-112
	sd	a4,16(a5)
	addi	a5,s0,-112
	li	a1,40
	mv	a0,a5
	call	my_alloc
	sd	a0,-88(s0)
	ld	a5,-88(s0)
	ld	a4,-72(s0)
	sd	a4,24(a5)
	ld	a5,-88(s0)
	addi	a4,s0,-112
	sd	a4,0(a5)
	ld	a5,-88(s0)
	ld	a4,-80(s0)
	sd	a4,8(a5)
	addi	a5,s0,-112
	mv	a0,a5
	call	stack_create
	mv	a4,a0
	ld	a5,-88(s0)
	sd	a4,16(a5)
	addi	a5,s0,-112
	mv	a0,a5
	call	hash_table_create
	mv	a4,a0
	ld	a5,-88(s0)
	sd	a4,32(a5)
	ld	a5,-88(s0)
	ld	a5,32(a5)
	mv	a0,a5
	call	populate_c_functions
	lui	a5,%hi(.LC21)
	addi	a0,a5,%lo(.LC21)
	call	my_printf
	ld	a0,-88(s0)
	call	interpret
	lui	a5,%hi(.LC22)
	addi	a0,a5,%lo(.LC22)
	call	my_printf
	ld	a5,-88(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	sd	a5,-96(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	bne	a5,zero,.L11
	ld	a5,-96(s0)
	lw	a5,8(a5)
	bne	a5,zero,.L12
	ld	a5,-96(s0)
	lw	a5,12(a5)
	mv	a1,a5
	lui	a5,%hi(.LC23)
	addi	a0,a5,%lo(.LC23)
	call	my_printf
	j	.L13
.L12:
	ld	a5,-96(s0)
	lw	a5,8(a5)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L14
	ld	a5,-96(s0)
	flw	fa5,12(a5)
	fcvt.d.s	fa5,fa5
	fmv.x.d	a1,fa5
	lui	a5,%hi(.LC24)
	addi	a0,a5,%lo(.LC24)
	call	my_printf
	j	.L13
.L14:
	ld	a5,-96(s0)
	lw	a5,8(a5)
	mv	a1,a5
	lui	a5,%hi(.LC25)
	addi	a0,a5,%lo(.LC25)
	call	my_printf
	j	.L13
.L11:
	lui	a5,%hi(.LC26)
	addi	a0,a5,%lo(.LC26)
	call	my_printf
.L13:
	call	Exit
	li	a5,0
	mv	a0,a5
	ld	ra,232(sp)
	ld	s0,224(sp)
	addi	sp,sp,240
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
