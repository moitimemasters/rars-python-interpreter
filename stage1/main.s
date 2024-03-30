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
	.text
	.align	1
	.globl	populate_c_functions
	.type	populate_c_functions, @function
populate_c_functions:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	sd	a0,-88(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-80(s0)
	sd	a5,-72(s0)
	lui	a5,%hi(add_binop)
	addi	a3,a5,%lo(add_binop)
	ld	a1,-80(s0)
	ld	a2,-72(s0)
	ld	a0,-88(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-64(s0)
	sd	a5,-56(s0)
	lui	a5,%hi(sub_binop)
	addi	a3,a5,%lo(sub_binop)
	ld	a1,-64(s0)
	ld	a2,-56(s0)
	ld	a0,-88(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-48(s0)
	sd	a5,-40(s0)
	lui	a5,%hi(mul_binop)
	addi	a3,a5,%lo(mul_binop)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a0,-88(s0)
	call	hash_table_insert_string
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	const_string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,-32(s0)
	sd	a5,-24(s0)
	lui	a5,%hi(div_binop)
	addi	a3,a5,%lo(div_binop)
	ld	a1,-32(s0)
	ld	a2,-24(s0)
	ld	a0,-88(s0)
	call	hash_table_insert_string
	nop
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	populate_c_functions, .-populate_c_functions
	.section	.rodata
	.align	3
.LC4:
	.string	"4 if 0 else 5 + 3"
	.align	3
.LC5:
	.string	"started lexing\n"
	.align	3
.LC6:
	.string	"ended lexing\n"
	.align	3
.LC7:
	.string	"Invalid token at line %d, column %d\n"
	.align	3
.LC8:
	.string	"started parsing ast\n"
	.align	3
.LC9:
	.string	"ended parsing ast\n"
	.align	3
.LC10:
	.string	"Error parsing\n"
	.align	3
.LC11:
	.string	"started compiling\n"
	.align	3
.LC12:
	.string	"compiled size: %d\n"
	.align	3
.LC13:
	.string	"Error compiling\n"
	.align	3
.LC14:
	.string	"ended compiling\n"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-208
	sd	ra,200(sp)
	sd	s0,192(sp)
	addi	s0,sp,208
	li	a5,268697600
	sd	a5,-96(s0)
	li	a5,805306368
	sd	a5,-88(s0)
	lui	a5,%hi(.LC4)
	addi	a5,a5,%lo(.LC4)
	sd	a5,-32(s0)
	addi	a5,s0,-96
	sd	a5,-104(s0)
	ld	a5,-32(s0)
	sd	a5,-144(s0)
	ld	a0,-32(s0)
	call	my_strlen
	mv	a5,a0
	sd	a5,-120(s0)
	sw	zero,-136(s0)
	li	a5,1
	sw	a5,-132(s0)
	sw	zero,-124(s0)
	li	a5,4
	sw	a5,-128(s0)
	sb	zero,-112(s0)
	addi	a4,s0,-96
	li	a5,4096
	addi	a1,a5,-96
	mv	a0,a4
	call	my_alloc
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	my_printf
	j	.L3
.L5:
	lw	a5,-20(s0)
	addiw	a4,a5,1
	sw	a4,-20(s0)
	slli	a5,a5,5
	ld	a4,-40(s0)
	add	a5,a4,a5
	ld	a1,-176(s0)
	ld	a2,-168(s0)
	ld	a3,-160(s0)
	ld	a4,-152(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
.L3:
	addi	a5,s0,-176
	addi	a4,s0,-144
	mv	a1,a4
	mv	a0,a5
	call	next_token
	lw	a5,-176(s0)
	mv	a4,a5
	li	a5,66
	beq	a4,a5,.L4
	lw	a5,-176(s0)
	mv	a4,a5
	li	a5,67
	bne	a4,a5,.L5
.L4:
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	my_printf
	lw	a5,-176(s0)
	mv	a4,a5
	li	a5,67
	bne	a4,a5,.L6
	lw	a5,-156(s0)
	lw	a4,-124(s0)
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC7)
	addi	a0,a5,%lo(.LC7)
	call	my_printf
	call	Exit
.L6:
	sw	zero,-192(s0)
	addi	a5,s0,-96
	sd	a5,-208(s0)
	lw	a5,-20(s0)
	sw	a5,-188(s0)
	ld	a5,-40(s0)
	sd	a5,-200(s0)
	sw	zero,-184(s0)
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	my_printf
	addi	a5,s0,-208
	mv	a0,a5
	call	parse
	sd	a0,-48(s0)
	lui	a5,%hi(.LC9)
	addi	a0,a5,%lo(.LC9)
	call	my_printf
	ld	a5,-48(s0)
	bne	a5,zero,.L7
	lui	a5,%hi(.LC10)
	addi	a0,a5,%lo(.LC10)
	call	my_printf
	call	Exit
.L7:
	lui	a5,%hi(.LC11)
	addi	a0,a5,%lo(.LC11)
	call	my_printf
	addi	a5,s0,-96
	li	a1,24
	mv	a0,a5
	call	my_alloc
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	addi	a4,s0,-96
	sd	a4,0(a5)
	ld	a5,-56(s0)
	ld	a4,-48(s0)
	sd	a4,8(a5)
	addi	a5,s0,-96
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-56(s0)
	sd	a4,16(a5)
	ld	a0,-56(s0)
	call	compile
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	ld	a5,16(a5)
	mv	a1,a5
	lui	a5,%hi(.LC12)
	addi	a0,a5,%lo(.LC12)
	call	my_printf
	ld	a5,-64(s0)
	bne	a5,zero,.L8
	lui	a5,%hi(.LC13)
	addi	a0,a5,%lo(.LC13)
	call	my_printf
	call	Exit
.L8:
	lui	a5,%hi(.LC14)
	addi	a0,a5,%lo(.LC14)
	call	my_printf
	addi	a5,s0,-96
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-72(s0)
	addi	a5,s0,-96
	mv	a0,a5
	call	hash_table_create
	mv	a4,a0
	ld	a5,-72(s0)
	sd	a4,8(a5)
	ld	a5,-72(s0)
	sd	zero,0(a5)
	addi	a5,s0,-96
	li	a1,40
	mv	a0,a5
	call	my_alloc
	sd	a0,-80(s0)
	ld	a5,-80(s0)
	addi	a4,s0,-96
	sd	a4,0(a5)
	ld	a5,-80(s0)
	ld	a4,-64(s0)
	sd	a4,24(a5)
	ld	a5,-80(s0)
	ld	a4,-72(s0)
	sd	a4,8(a5)
	addi	a5,s0,-96
	mv	a0,a5
	call	stack_create
	mv	a4,a0
	ld	a5,-80(s0)
	sd	a4,16(a5)
	addi	a5,s0,-96
	mv	a0,a5
	call	hash_table_create
	mv	a4,a0
	ld	a5,-80(s0)
	sd	a4,32(a5)
	ld	a5,-80(s0)
	ld	a5,32(a5)
	mv	a0,a5
	call	populate_c_functions
	ld	a0,-80(s0)
	call	interpret
	call	Exit
	li	a5,0
	mv	a0,a5
	ld	ra,200(sp)
	ld	s0,192(sp)
	addi	sp,sp,208
	jr	ra
	.size	main, .-main
	.ident	"GCC: () 13.2.0"
