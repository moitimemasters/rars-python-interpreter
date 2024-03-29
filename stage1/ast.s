	.file	"ast.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Error: %s\n"
	.text
	.align	1
	.globl	report_parse_error
	.type	report_parse_error, @function
report_parse_error:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-24(s0)
	lw	a5,0(a5)
	bne	a5,zero,.L3
	ld	a5,-24(s0)
	li	a4,1
	sw	a4,0(a5)
	ld	a1,-32(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	my_printf
.L3:
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	report_parse_error, .-report_parse_error
	.align	1
	.globl	create_ast_node
	.type	create_ast_node, @function
create_ast_node:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	li	a1,32
	mv	a0,a5
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
	.size	create_ast_node, .-create_ast_node
	.align	1
	.globl	ast_peek
	.type	ast_peek, @function
ast_peek:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-32(s0)
	ld	a4,8(a5)
	ld	a5,-32(s0)
	lw	a5,16(a5)
	slli	a5,a5,5
	add	a4,a4,a5
	ld	a5,-24(s0)
	ld	a1,0(a4)
	ld	a2,8(a4)
	ld	a3,16(a4)
	ld	a4,24(a4)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	ld	a0,-24(s0)
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	ast_peek, .-ast_peek
	.align	1
	.globl	ast_consume
	.type	ast_consume, @function
ast_consume:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-32(s0)
	ld	a4,8(a5)
	ld	a5,-32(s0)
	lw	a5,16(a5)
	addiw	a3,a5,1
	sext.w	a2,a3
	ld	a3,-32(s0)
	sw	a2,16(a3)
	slli	a5,a5,5
	add	a4,a4,a5
	ld	a5,-24(s0)
	ld	a1,0(a4)
	ld	a2,8(a4)
	ld	a3,16(a4)
	ld	a4,24(a4)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	ld	a0,-24(s0)
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	ast_consume, .-ast_consume
	.align	1
	.globl	is_end
	.type	is_end, @function
is_end:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a4,16(a5)
	ld	a5,-24(s0)
	lw	a5,20(a5)
	slt	a5,a4,a5
	seqz	a5,a5
	andi	a5,a5,0xff
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	is_end, .-is_end
	.section	.rodata
	.align	3
.LC1:
	.string	"Unexpected end of input"
	.text
	.align	1
	.globl	parse_string
	.type	parse_string, @function
parse_string:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	sd	s1,104(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L13
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L16
.L13:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,2
	beq	a4,a5,.L15
	li	a5,0
	j	.L16
.L15:
	li	a1,2
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-64(s0)
	ld	a4,-48(s0)
	ld	s1,-40(s0)
	mv	a1,a4
	mv	a0,a5
	call	string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,8(s1)
	sd	a5,16(s1)
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a5,-40(s0)
.L16:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	ld	s1,104(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_string, .-parse_string
	.section	.rodata
	.align	3
.LC2:
	.string	"Expected item or closing of sequence delcaration"
	.align	3
.LC3:
	.string	"Expected \":\" or \",\" or \"}\" after key in set or dict declaration"
	.align	3
.LC4:
	.string	"Expected \",\" or \"}\" after key in set declaration"
	.align	3
.LC5:
	.string	"Expected \":\" after key in dict declaration"
	.align	3
.LC6:
	.string	"Expected value after \":\" in set declaration"
	.align	3
.LC7:
	.string	"Expected \"}\" or \",\" after value in dict declaration"
	.align	3
.LC8:
	.string	"parsed set or dict\n"
	.text
	.align	1
	.globl	parse_set_or_dict
	.type	parse_set_or_dict, @function
parse_set_or_dict:
	addi	sp,sp,-160
	sd	ra,152(sp)
	sd	s0,144(sp)
	addi	s0,sp,160
	sd	a0,-120(s0)
	sd	a1,-128(s0)
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_string
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L18
	ld	a5,-32(s0)
	j	.L41
.L18:
	ld	a5,-128(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L20
	li	a5,0
	j	.L41
.L20:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L21
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L41
.L21:
	addi	a5,s0,-112
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,60
	beq	a4,a5,.L22
	li	a5,0
	j	.L41
.L22:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L23
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L41
.L23:
	ld	a5,-120(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-40(s0)
	ld	a5,-120(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-48(s0)
	li	a5,-1
	sw	a5,-20(s0)
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-112(s0)
	sd	a3,-104(s0)
	sd	a4,-96(s0)
	sd	a5,-88(s0)
	j	.L24
.L38:
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_expression
	sd	a0,-72(s0)
	ld	a5,-72(s0)
	bne	a5,zero,.L25
	lui	a5,%hi(.LC2)
	addi	a1,a5,%lo(.LC2)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L25:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,-1
	bne	a4,a5,.L26
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L27
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L27:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-112(s0)
	sd	a3,-104(s0)
	sd	a4,-96(s0)
	sd	a5,-88(s0)
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,55
	bne	a4,a5,.L28
	sw	zero,-20(s0)
	j	.L26
.L28:
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,63
	beq	a4,a5,.L29
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,62
	bne	a4,a5,.L30
.L29:
	li	a5,1
	sw	a5,-20(s0)
	j	.L26
.L30:
	lui	a5,%hi(.LC3)
	addi	a1,a5,%lo(.LC3)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L26:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L31
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L32
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L32:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-112(s0)
	sd	a3,-104(s0)
	sd	a4,-96(s0)
	sd	a5,-88(s0)
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,62
	beq	a4,a5,.L33
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,63
	beq	a4,a5,.L33
	lui	a5,%hi(.LC4)
	addi	a1,a5,%lo(.LC4)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L33:
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,63
	bne	a4,a5,.L31
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
.L31:
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,zero,.L24
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L34
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L34:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-112(s0)
	sd	a3,-104(s0)
	sd	a4,-96(s0)
	sd	a5,-88(s0)
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,62
	beq	a4,a5,.L35
	lui	a5,%hi(.LC5)
	addi	a1,a5,%lo(.LC5)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L35:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_expression
	sd	a0,-80(s0)
	ld	a5,-80(s0)
	bne	a5,zero,.L36
	lui	a5,%hi(.LC6)
	addi	a1,a5,%lo(.LC6)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L36:
	ld	a1,-72(s0)
	ld	a0,-40(s0)
	call	linked_list_push
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L37
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L37:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-112(s0)
	sd	a3,-104(s0)
	sd	a4,-96(s0)
	sd	a5,-88(s0)
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,62
	beq	a4,a5,.L24
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,63
	beq	a4,a5,.L24
	lui	a5,%hi(.LC7)
	addi	a1,a5,%lo(.LC7)
	ld	a0,-128(s0)
	call	report_parse_error
	ld	a0,-40(s0)
	call	linked_list_free
	ld	a0,-48(s0)
	call	linked_list_free
	li	a5,0
	j	.L41
.L24:
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,62
	bne	a4,a5,.L38
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,-1
	beq	a4,a5,.L39
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L40
.L39:
	li	a1,18
	ld	a0,-120(s0)
	call	create_ast_node
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	ld	a4,-40(s0)
	sd	a4,8(a5)
	ld	a0,-48(s0)
	call	linked_list_free
	ld	a5,-64(s0)
	j	.L41
.L40:
	li	a1,19
	ld	a0,-120(s0)
	call	create_ast_node
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a4,-40(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,-48(s0)
	sd	a4,16(a5)
	lui	a5,%hi(.LC8)
	addi	a0,a5,%lo(.LC8)
	call	my_printf
	ld	a5,-56(s0)
.L41:
	mv	a0,a5
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	parse_set_or_dict, .-parse_set_or_dict
	.section	.rodata
	.align	3
.LC9:
	.string	"Expected \",\" or \")\" after sequence item"
	.text
	.align	1
	.globl	parse_list_or_tuple
	.type	parse_list_or_tuple, @function
parse_list_or_tuple:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L43
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L56
.L43:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,58
	beq	a4,a5,.L45
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,56
	beq	a4,a5,.L45
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_set_or_dict
	mv	a5,a0
	j	.L56
.L45:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L46
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L56
.L46:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,58
	bne	a4,a5,.L47
	li	a5,59
	j	.L48
.L47:
	li	a5,57
.L48:
	sw	a5,-20(s0)
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,58
	bne	a4,a5,.L49
	li	a5,17
	j	.L50
.L49:
	li	a5,16
.L50:
	mv	a1,a5
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-32(s0)
	ld	a5,-88(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-32(s0)
	sd	a4,8(a5)
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-128(s0)
	ld	a3,-120(s0)
	ld	a4,-112(s0)
	ld	a5,-104(s0)
	sd	a2,-72(s0)
	sd	a3,-64(s0)
	sd	a4,-56(s0)
	sd	a5,-48(s0)
	j	.L51
.L55:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L52
	lui	a5,%hi(.LC2)
	addi	a1,a5,%lo(.LC2)
	ld	a0,-96(s0)
	call	report_parse_error
	ld	a5,-32(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	linked_list_free
	ld	a5,-88(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L56
.L52:
	ld	a5,-32(s0)
	ld	a5,8(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	linked_list_push
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L53
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-96(s0)
	call	report_parse_error
	ld	a5,-32(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	linked_list_free
	ld	a5,-88(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L56
.L53:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-128(s0)
	ld	a3,-120(s0)
	ld	a4,-112(s0)
	ld	a5,-104(s0)
	sd	a2,-72(s0)
	sd	a3,-64(s0)
	sd	a4,-56(s0)
	sd	a5,-48(s0)
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,63
	beq	a4,a5,.L54
	lw	a4,-72(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	beq	a5,a4,.L54
	lui	a5,%hi(.LC9)
	addi	a1,a5,%lo(.LC9)
	ld	a0,-96(s0)
	call	report_parse_error
	ld	a5,-32(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	linked_list_free
	ld	a5,-88(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L56
.L54:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,63
	bne	a4,a5,.L51
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
.L51:
	lw	a4,-72(s0)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,a4,.L55
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a5,-32(s0)
.L56:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_list_or_tuple, .-parse_list_or_tuple
	.align	1
	.globl	parse_argument
	.type	parse_argument, @function
parse_argument:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	sd	s1,104(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L58
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L61
.L58:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,6
	bne	a4,a5,.L60
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,10
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-64(s0)
	ld	a4,-48(s0)
	ld	s1,-40(s0)
	mv	a1,a4
	mv	a0,a5
	call	string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,8(s1)
	sd	a5,16(s1)
	ld	a5,-40(s0)
	j	.L61
.L60:
	li	a5,0
.L61:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	ld	s1,104(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_argument, .-parse_argument
	.align	1
	.globl	parse_argument_list
	.type	parse_argument_list, @function
parse_argument_list:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L63
	li	a5,0
	j	.L64
.L63:
	li	a1,11
	ld	a0,-72(s0)
	call	create_ast_node
	sd	a0,-24(s0)
	ld	a5,-72(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,8(a5)
.L69:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_argument
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L65
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L70
	li	a5,0
	j	.L64
.L65:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	linked_list_push
	addi	a5,s0,-64
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,63
	bne	a4,a5,.L71
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	j	.L69
.L70:
	nop
	j	.L67
.L71:
	nop
.L67:
	ld	a5,-24(s0)
.L64:
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	parse_argument_list, .-parse_argument_list
	.section	.rodata
	.align	3
.LC10:
	.string	"Expected lambda arguments or \":\" after \"lambda\""
	.align	3
.LC11:
	.string	"Expected \":\" after lambda arguments"
	.align	3
.LC12:
	.string	"Expected expression or \"pass\" after lambda arguments"
	.text
	.align	1
	.globl	parse_lambda
	.type	parse_lambda, @function
parse_lambda:
	addi	sp,sp,-160
	sd	ra,152(sp)
	sd	s0,144(sp)
	addi	s0,sp,160
	sd	a0,-120(s0)
	sd	a1,-128(s0)
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_list_or_tuple
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	beq	a5,zero,.L73
	ld	a5,-24(s0)
	j	.L82
.L73:
	ld	a5,-128(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L75
	li	a5,0
	j	.L82
.L75:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L76
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L82
.L76:
	addi	a5,s0,-112
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,61
	beq	a4,a5,.L77
	li	a5,0
	j	.L82
.L77:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_argument_list
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L78
	addi	a5,s0,-80
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L78
	lui	a5,%hi(.LC10)
	addi	a1,a5,%lo(.LC10)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L82
.L78:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L79
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L82
.L79:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-112(s0)
	sd	a3,-104(s0)
	sd	a4,-96(s0)
	sd	a5,-88(s0)
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L80
	lui	a5,%hi(.LC11)
	addi	a1,a5,%lo(.LC11)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L82
.L80:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L81
	lui	a5,%hi(.LC12)
	addi	a1,a5,%lo(.LC12)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L82
.L81:
	li	a1,13
	ld	a0,-120(s0)
	call	create_ast_node
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
	ld	a5,-48(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-48(s0)
.L82:
	mv	a0,a5
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	parse_lambda, .-parse_lambda
	.align	1
	.globl	parse_expression_list
	.type	parse_expression_list, @function
parse_expression_list:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L84
	li	a5,0
	j	.L85
.L84:
	li	a1,12
	ld	a0,-72(s0)
	call	create_ast_node
	sd	a0,-24(s0)
	ld	a5,-72(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,8(a5)
.L90:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_expression
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L86
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L91
	li	a5,0
	j	.L85
.L86:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	linked_list_push
	addi	a5,s0,-64
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,63
	bne	a4,a5,.L92
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	j	.L90
.L91:
	nop
	j	.L88
.L92:
	nop
.L88:
	ld	a5,-24(s0)
.L85:
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	parse_expression_list, .-parse_expression_list
	.section	.rodata
	.align	3
.LC13:
	.string	"Expected expression list or \":\" after \"(\""
	.align	3
.LC14:
	.string	"Expected \")\" after expression list"
	.text
	.align	1
	.globl	parse_function_call_partial
	.type	parse_function_call_partial, @function
parse_function_call_partial:
	addi	sp,sp,-176
	sd	ra,168(sp)
	sd	s0,160(sp)
	addi	s0,sp,176
	sd	a0,-136(s0)
	sd	a1,-144(s0)
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L94
	li	a5,0
	j	.L95
.L94:
	addi	a5,s0,-128
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-128(s0)
	mv	a4,a5
	li	a5,56
	beq	a4,a5,.L96
	li	a5,0
	j	.L95
.L96:
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_expression_list
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L97
	addi	a5,s0,-96
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-96(s0)
	mv	a4,a5
	li	a5,57
	beq	a4,a5,.L97
	lui	a5,%hi(.LC13)
	addi	a1,a5,%lo(.LC13)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L95
.L97:
	addi	a5,s0,-64
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,57
	beq	a4,a5,.L98
	lui	a5,%hi(.LC14)
	addi	a1,a5,%lo(.LC14)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L95
.L98:
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,15
	ld	a0,-136(s0)
	call	create_ast_node
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-32(s0)
.L95:
	mv	a0,a5
	ld	ra,168(sp)
	ld	s0,160(sp)
	addi	sp,sp,176
	jr	ra
	.size	parse_function_call_partial, .-parse_function_call_partial
	.section	.rodata
	.align	3
.LC15:
	.string	"Expected expression after \"[\""
	.align	3
.LC16:
	.string	"Expected \"]\" or \":\" after index start"
	.align	3
.LC17:
	.string	"Expected expression or \"]\" after \":\""
	.align	3
.LC18:
	.string	"Expected \"]\" after slice step"
	.text
	.align	1
	.globl	parse_index_or_slice_partial
	.type	parse_index_or_slice_partial, @function
parse_index_or_slice_partial:
	addi	sp,sp,-256
	sd	ra,248(sp)
	sd	s0,240(sp)
	addi	s0,sp,256
	sd	a0,-216(s0)
	sd	a1,-224(s0)
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L100
	li	a5,0
	j	.L116
.L100:
	addi	a5,s0,-208
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,58
	beq	a4,a5,.L102
	li	a5,0
	j	.L116
.L102:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_expression
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L103
	lui	a5,%hi(.LC15)
	addi	a1,a5,%lo(.LC15)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L103:
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L104
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L104:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-256(s0)
	ld	a3,-248(s0)
	ld	a4,-240(s0)
	ld	a5,-232(s0)
	sd	a2,-208(s0)
	sd	a3,-200(s0)
	sd	a4,-192(s0)
	sd	a5,-184(s0)
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,59
	bne	a4,a5,.L105
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,21
	ld	a0,-216(s0)
	call	create_ast_node
	sd	a0,-80(s0)
	ld	a5,-80(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-80(s0)
	j	.L116
.L105:
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L106
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC16)
	addi	a1,a5,%lo(.LC16)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L106:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_expression
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L107
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L108
	addi	a5,s0,-176
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-176(s0)
	mv	a4,a5
	li	a5,59
	bne	a4,a5,.L108
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,23
	ld	a0,-216(s0)
	call	create_ast_node
	sd	a0,-72(s0)
	ld	a5,-72(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-72(s0)
	sd	zero,16(a5)
	ld	a5,-72(s0)
	sd	zero,24(a5)
	ld	a5,-72(s0)
	j	.L116
.L108:
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC17)
	addi	a1,a5,%lo(.LC17)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L107:
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L109
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L109:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-256(s0)
	ld	a3,-248(s0)
	ld	a4,-240(s0)
	ld	a5,-232(s0)
	sd	a2,-208(s0)
	sd	a3,-200(s0)
	sd	a4,-192(s0)
	sd	a5,-184(s0)
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,59
	bne	a4,a5,.L110
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,23
	ld	a0,-216(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	ld	a5,-40(s0)
	sd	zero,24(a5)
.L110:
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L111
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC16)
	addi	a1,a5,%lo(.LC16)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L111:
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_expression
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L112
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L113
	addi	a5,s0,-144
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-144(s0)
	mv	a4,a5
	li	a5,59
	bne	a4,a5,.L113
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,23
	ld	a0,-216(s0)
	call	create_ast_node
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-64(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	ld	a5,-64(s0)
	sd	zero,24(a5)
	ld	a5,-64(s0)
	j	.L116
.L113:
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC17)
	addi	a1,a5,%lo(.LC17)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L112:
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L114
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L114:
	addi	a5,s0,-112
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,59
	beq	a4,a5,.L115
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC18)
	addi	a1,a5,%lo(.LC18)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L116
.L115:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,23
	ld	a0,-216(s0)
	call	create_ast_node
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	ld	a5,-56(s0)
	ld	a4,-48(s0)
	sd	a4,24(a5)
	ld	a5,-56(s0)
.L116:
	mv	a0,a5
	ld	ra,248(sp)
	ld	s0,240(sp)
	addi	sp,sp,256
	jr	ra
	.size	parse_index_or_slice_partial, .-parse_index_or_slice_partial
	.align	1
	.globl	parse_ident
	.type	parse_ident, @function
parse_ident:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	sd	s1,104(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_lambda
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	beq	a5,zero,.L118
	ld	a5,-40(s0)
	j	.L123
.L118:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L120
	li	a5,0
	j	.L123
.L120:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L121
	li	a5,0
	j	.L123
.L121:
	addi	a5,s0,-80
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,6
	beq	a4,a5,.L122
	li	a5,0
	j	.L123
.L122:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,5
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-48(s0)
	ld	a5,-72(s0)
	ld	a4,-56(s0)
	ld	s1,-48(s0)
	mv	a1,a4
	mv	a0,a5
	call	string_view
	mv	a4,a0
	mv	a5,a1
	sd	a4,8(s1)
	sd	a5,16(s1)
	ld	a5,-48(s0)
.L123:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	ld	s1,104(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_ident, .-parse_ident
	.align	1
	.globl	parse_number
	.type	parse_number, @function
parse_number:
	addi	sp,sp,-160
	sd	ra,152(sp)
	sd	s0,144(sp)
	addi	s0,sp,160
	sd	a0,-120(s0)
	sd	a1,-128(s0)
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_ident
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	beq	a5,zero,.L125
	ld	a5,-48(s0)
	j	.L138
.L125:
	ld	a5,-128(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L127
	li	a5,0
	j	.L138
.L127:
	addi	a5,s0,-104
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-104(s0)
	bne	a5,zero,.L128
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L129
.L130:
	lw	a5,-20(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,2
	addw	a5,a5,a4
	slliw	a5,a5,1
	sext.w	a4,a5
	ld	a3,-96(s0)
	lw	a5,-24(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,-48
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L129:
	lw	a4,-24(s0)
	ld	a5,-80(s0)
	bltu	a4,a5,.L130
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,0
	ld	a0,-120(s0)
	call	create_ast_node
	sd	a0,-72(s0)
	ld	a5,-72(s0)
	lw	a4,-20(s0)
	sw	a4,8(a5)
	ld	a5,-72(s0)
	j	.L138
.L128:
	lw	a5,-104(s0)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L131
	fmv.s.x	fa5,zero
	fsw	fa5,-52(s0)
	sw	zero,-28(s0)
	sw	zero,-32(s0)
	sw	zero,-36(s0)
	j	.L132
.L135:
	ld	a4,-96(s0)
	lw	a5,-36(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,46
	bne	a4,a5,.L133
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
	j	.L134
.L133:
	lw	a5,-28(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,2
	addw	a5,a5,a4
	slliw	a5,a5,1
	sext.w	a4,a5
	ld	a3,-96(s0)
	lw	a5,-36(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,-48
	sw	a5,-28(s0)
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L132:
	lw	a4,-36(s0)
	ld	a5,-80(s0)
	bltu	a4,a5,.L135
.L134:
	li	a5,1
	sw	a5,-40(s0)
	j	.L136
.L137:
	lw	a5,-32(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,2
	addw	a5,a5,a4
	slliw	a5,a5,1
	sext.w	a4,a5
	ld	a3,-96(s0)
	lw	a5,-36(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,-48
	sw	a5,-32(s0)
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
	lw	a5,-40(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,2
	addw	a5,a5,a4
	slliw	a5,a5,1
	sw	a5,-40(s0)
.L136:
	lw	a4,-36(s0)
	ld	a5,-80(s0)
	bltu	a4,a5,.L137
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	lw	a5,-28(s0)
	fcvt.s.w	fa4,a5
	lw	a5,-32(s0)
	fcvt.s.w	fa3,a5
	lw	a5,-40(s0)
	fcvt.s.w	fa5,a5
	fdiv.s	fa5,fa3,fa5
	fadd.s	fa5,fa4,fa5
	fsw	fa5,-52(s0)
	li	a1,1
	ld	a0,-120(s0)
	call	create_ast_node
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	flw	fa5,-52(s0)
	fsw	fa5,8(a5)
	ld	a5,-64(s0)
	j	.L138
.L131:
	li	a5,0
.L138:
	mv	a0,a5
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	parse_number, .-parse_number
	.section	.rodata
	.align	3
.LC19:
	.string	"Expected )"
	.text
	.align	1
	.globl	parse_primary
	.type	parse_primary, @function
parse_primary:
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_number
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	beq	a5,zero,.L140
	ld	a5,-24(s0)
	j	.L139
.L140:
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L142
	li	a5,0
	j	.L139
.L142:
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L143
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-80(s0)
	call	report_parse_error
	li	a5,0
	j	.L139
.L143:
	addi	a5,s0,-64
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,56
	bne	a4,a5,.L144
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_expression
	sd	a0,-32(s0)
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L145
	li	a5,0
	j	.L139
.L145:
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L146
	lui	a5,%hi(.LC19)
	addi	a1,a5,%lo(.LC19)
	ld	a0,-80(s0)
	call	report_parse_error
	li	a5,0
	j	.L139
.L146:
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-112(s0)
	ld	a3,-104(s0)
	ld	a4,-96(s0)
	ld	a5,-88(s0)
	sd	a2,-64(s0)
	sd	a3,-56(s0)
	sd	a4,-48(s0)
	sd	a5,-40(s0)
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,57
	beq	a4,a5,.L147
	lui	a5,%hi(.LC19)
	addi	a1,a5,%lo(.LC19)
	ld	a0,-80(s0)
	call	report_parse_error
	li	a5,0
	j	.L139
.L147:
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	ld	a5,-32(s0)
	j	.L139
.L144:
.L139:
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	parse_primary, .-parse_primary
	.align	1
	.globl	parse_product
	.type	parse_product, @function
parse_product:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_primary
	sd	a0,-24(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L150
	li	a5,0
	j	.L156
.L150:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L152
	ld	a5,-24(s0)
	j	.L156
.L152:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	j	.L153
.L155:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_primary
	sd	a0,-32(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L154
	li	a5,0
	j	.L156
.L154:
	li	a1,6
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	lw	a4,-72(s0)
	ld	a5,-40(s0)
	sw	a4,24(a5)
	ld	a5,-40(s0)
	sd	a5,-24(s0)
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-128(s0)
	ld	a3,-120(s0)
	ld	a4,-112(s0)
	ld	a5,-104(s0)
	sd	a2,-72(s0)
	sd	a3,-64(s0)
	sd	a4,-56(s0)
	sd	a5,-48(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L153
	ld	a5,-24(s0)
	j	.L156
.L153:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,15
	beq	a4,a5,.L155
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,17
	beq	a4,a5,.L155
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,19
	beq	a4,a5,.L155
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,21
	beq	a4,a5,.L155
	ld	a5,-24(s0)
.L156:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_product, .-parse_product
	.align	1
	.globl	parse_sum
	.type	parse_sum, @function
parse_sum:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_product
	sd	a0,-24(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L158
	li	a5,0
	j	.L164
.L158:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L160
	ld	a5,-24(s0)
	j	.L164
.L160:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	j	.L161
.L163:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_product
	sd	a0,-32(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L162
	li	a5,0
	j	.L164
.L162:
	li	a1,6
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	lw	a4,-72(s0)
	ld	a5,-40(s0)
	sw	a4,24(a5)
	ld	a5,-40(s0)
	sd	a5,-24(s0)
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-128(s0)
	ld	a3,-120(s0)
	ld	a4,-112(s0)
	ld	a5,-104(s0)
	sd	a2,-72(s0)
	sd	a3,-64(s0)
	sd	a4,-56(s0)
	sd	a5,-48(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L161
	ld	a5,-24(s0)
	j	.L164
.L161:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,10
	beq	a4,a5,.L163
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,13
	beq	a4,a5,.L163
	ld	a5,-24(s0)
.L164:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_sum, .-parse_sum
	.align	1
	.globl	parse_comparison
	.type	parse_comparison, @function
parse_comparison:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_sum
	sd	a0,-24(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L166
	li	a5,0
	j	.L172
.L166:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L168
	ld	a5,-24(s0)
	j	.L172
.L168:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,31
	beq	a4,a5,.L169
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,32
	beq	a4,a5,.L169
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,33
	beq	a4,a5,.L169
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,34
	beq	a4,a5,.L169
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,29
	bne	a4,a5,.L170
.L169:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_sum
	sd	a0,-32(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L171
	li	a5,0
	j	.L172
.L171:
	li	a1,6
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	lw	a4,-72(s0)
	ld	a5,-40(s0)
	sw	a4,24(a5)
	ld	a5,-40(s0)
	sd	a5,-24(s0)
.L170:
	ld	a5,-24(s0)
.L172:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_comparison, .-parse_comparison
	.align	1
	.globl	parse_logical
	.type	parse_logical, @function
parse_logical:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_comparison
	sd	a0,-24(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L174
	li	a5,0
	j	.L180
.L174:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L176
	ld	a5,-24(s0)
	j	.L180
.L176:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	j	.L177
.L179:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_comparison
	sd	a0,-32(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L178
	li	a5,0
	j	.L180
.L178:
	li	a1,6
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	lw	a4,-72(s0)
	ld	a5,-40(s0)
	sw	a4,24(a5)
	ld	a5,-40(s0)
	sd	a5,-24(s0)
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-128(s0)
	ld	a3,-120(s0)
	ld	a4,-112(s0)
	ld	a5,-104(s0)
	sd	a2,-72(s0)
	sd	a3,-64(s0)
	sd	a4,-56(s0)
	sd	a5,-48(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L177
	ld	a5,-24(s0)
	j	.L180
.L177:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,27
	beq	a4,a5,.L179
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,28
	beq	a4,a5,.L179
	ld	a5,-24(s0)
.L180:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_logical, .-parse_logical
	.section	.rodata
	.align	3
.LC20:
	.string	"Expected expression after ternary if"
	.align	3
.LC21:
	.string	"Unexpected end of input, expected \"else\" after ternary if"
	.align	3
.LC22:
	.string	"Expected \"else\" after ternary if"
	.align	3
.LC23:
	.string	"Expected expression after \"else\" in ternary if"
	.text
	.align	1
	.globl	parse_ternary
	.type	parse_ternary, @function
parse_ternary:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_logical
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L182
	li	a5,0
	j	.L190
.L182:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L184
	ld	a5,-24(s0)
	j	.L190
.L184:
	addi	a5,s0,-80
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,36
	beq	a4,a5,.L185
	ld	a5,-24(s0)
	j	.L190
.L185:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_logical
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L186
	lui	a5,%hi(.LC20)
	addi	a1,a5,%lo(.LC20)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L190
.L186:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L187
	lui	a5,%hi(.LC21)
	addi	a1,a5,%lo(.LC21)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L190
.L187:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-128(s0)
	ld	a3,-120(s0)
	ld	a4,-112(s0)
	ld	a5,-104(s0)
	sd	a2,-80(s0)
	sd	a3,-72(s0)
	sd	a4,-64(s0)
	sd	a5,-56(s0)
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,41
	beq	a4,a5,.L188
	lui	a5,%hi(.LC22)
	addi	a1,a5,%lo(.LC22)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L190
.L188:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_logical
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L189
	lui	a5,%hi(.LC23)
	addi	a1,a5,%lo(.LC23)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L190
.L189:
	li	a1,9
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-48(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	ld	a5,-48(s0)
	ld	a4,-40(s0)
	sd	a4,24(a5)
	ld	a5,-48(s0)
.L190:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_ternary, .-parse_ternary
	.align	1
	.globl	parse_expression_stripped
	.type	parse_expression_stripped, @function
parse_expression_stripped:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	parse_ternary
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	parse_expression_stripped, .-parse_expression_stripped
	.align	1
	.globl	parse_expression
	.type	parse_expression, @function
parse_expression:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_expression_stripped
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L194
	li	a5,0
	j	.L195
.L194:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_index_or_slice_partial
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L196
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L197
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L195
.L197:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,23
	bne	a4,a5,.L198
	li	a5,22
	j	.L199
.L198:
	li	a5,20
.L199:
	mv	a1,a5
	ld	a0,-72(s0)
	call	create_ast_node
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a4,-32(s0)
	sd	a4,16(a5)
	ld	a5,-56(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	sd	a5,-24(s0)
	j	.L200
.L196:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_function_call_partial
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	beq	a5,zero,.L204
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L202
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L195
.L202:
	li	a1,14
	ld	a0,-72(s0)
	call	create_ast_node
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-48(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-48(s0)
	sd	a5,-24(s0)
	nop
.L200:
	j	.L194
.L204:
	nop
	ld	a5,-24(s0)
.L195:
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	parse_expression, .-parse_expression
	.align	1
	.globl	ast_skip_indentation
	.type	ast_skip_indentation, @function
ast_skip_indentation:
	addi	sp,sp,-160
	sd	ra,152(sp)
	sd	s0,144(sp)
	addi	s0,sp,160
	sd	a0,-120(s0)
	j	.L206
.L209:
	addi	a5,s0,-112
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,69
	bne	a4,a5,.L207
	ld	a5,-120(s0)
	li	a4,-1
	sw	a4,24(a5)
.L207:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	ld	a5,-120(s0)
	lw	a5,24(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-120(s0)
	sw	a4,24(a5)
.L206:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L208
	addi	a5,s0,-80
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,68
	beq	a4,a5,.L209
.L208:
	addi	a5,s0,-48
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-48(s0)
	mv	a4,a5
	li	a5,69
	beq	a4,a5,.L209
	nop
	nop
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	ast_skip_indentation, .-ast_skip_indentation
	.align	1
	.globl	retract_indentation
	.type	retract_indentation, @function
retract_indentation:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a5,24(a5)
	addiw	a5,a5,-1
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,24(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	retract_indentation, .-retract_indentation
	.section	.rodata
	.align	3
.LC24:
	.string	"Expected \":\" after condition"
	.align	3
.LC25:
	.string	"Unexpected indentation after \":\""
	.align	3
.LC26:
	.string	"Expected statement after if"
	.align	3
.LC27:
	.string	"Unexpected indentation"
	.text
	.align	1
	.globl	parse_condition_partial
	.type	parse_condition_partial, @function
parse_condition_partial:
	addi	sp,sp,-160
	sd	ra,152(sp)
	sd	s0,144(sp)
	addi	s0,sp,160
	sd	a0,-104(s0)
	mv	a5,a1
	mv	a4,a2
	sd	a3,-120(s0)
	sw	a5,-108(s0)
	mv	a5,a4
	sb	a5,-109(s0)
	ld	a0,-104(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L212
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-120(s0)
	call	report_parse_error
	li	a5,0
	j	.L235
.L212:
	addi	a5,s0,-96
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_peek
	lw	a4,-96(s0)
	lw	a5,-108(s0)
	sext.w	a5,a5
	beq	a5,a4,.L214
	li	a5,0
	j	.L235
.L214:
	ld	a5,-104(s0)
	lw	a5,24(a5)
	sw	a5,-20(s0)
	addi	a5,s0,-160
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_consume
	sd	zero,-32(s0)
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L215
	ld	a1,-120(s0)
	ld	a0,-104(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-120(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L215
	li	a5,0
	j	.L235
.L215:
	ld	a0,-104(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L216
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-120(s0)
	call	report_parse_error
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L217
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
.L217:
	li	a5,0
	j	.L235
.L216:
	addi	a5,s0,-160
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-96(s0)
	sd	a3,-88(s0)
	sd	a4,-80(s0)
	sd	a5,-72(s0)
	lw	a5,-96(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L218
	lui	a5,%hi(.LC24)
	addi	a1,a5,%lo(.LC24)
	ld	a0,-120(s0)
	call	report_parse_error
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L219
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
.L219:
	li	a5,0
	j	.L235
.L218:
	addi	a5,s0,-160
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_consume
	ld	a0,-104(s0)
	call	ast_skip_indentation
	ld	a5,-104(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L220
	lui	a5,%hi(.LC25)
	addi	a1,a5,%lo(.LC25)
	ld	a0,-120(s0)
	call	report_parse_error
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L221
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
.L221:
	li	a5,0
	j	.L235
.L220:
	ld	a0,-104(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L222
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-120(s0)
	call	report_parse_error
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L223
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
.L223:
	li	a5,0
	j	.L235
.L222:
	ld	a1,-120(s0)
	ld	a0,-104(s0)
	call	parse_statement
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L224
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L225
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
.L225:
	lui	a5,%hi(.LC26)
	addi	a1,a5,%lo(.LC26)
	ld	a0,-120(s0)
	call	report_parse_error
	li	a5,0
	j	.L235
.L224:
	li	a1,24
	ld	a0,-104(s0)
	call	create_ast_node
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
	ld	a5,-104(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-56(s0)
	sd	a4,16(a5)
	ld	a5,-56(s0)
	ld	a5,16(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	linked_list_push
	ld	a0,-104(s0)
	call	ast_skip_indentation
	j	.L226
.L230:
	ld	a1,-120(s0)
	ld	a0,-104(s0)
	call	parse_statement
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	bne	a5,zero,.L227
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L228
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
.L228:
	ld	a5,-56(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	li	a5,0
	j	.L235
.L227:
	ld	a5,-56(s0)
	ld	a5,16(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	linked_list_push
	ld	a0,-104(s0)
	call	ast_skip_indentation
.L226:
	ld	a0,-104(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L229
	ld	a5,-104(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L230
.L229:
	ld	a5,-104(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L233
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L232
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
.L232:
	ld	a5,-56(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	lui	a5,%hi(.LC27)
	addi	a1,a5,%lo(.LC27)
	ld	a0,-120(s0)
	call	report_parse_error
	li	a5,0
	j	.L235
.L234:
	ld	a0,-104(s0)
	call	retract_indentation
.L233:
	ld	a5,-104(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L234
	ld	a5,-56(s0)
.L235:
	mv	a0,a5
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	parse_condition_partial, .-parse_condition_partial
	.align	1
	.globl	parse_if_statement
	.type	parse_if_statement, @function
parse_if_statement:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	ld	a5,-72(s0)
	lw	a5,24(a5)
	sw	a5,-20(s0)
	ld	a3,-80(s0)
	li	a2,1
	li	a1,36
	ld	a0,-72(s0)
	call	parse_condition_partial
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L237
	li	a5,0
	j	.L238
.L237:
	li	a1,25
	ld	a0,-72(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	sd	zero,24(a5)
	ld	a5,-72(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-40(s0)
	sd	a4,16(a5)
	j	.L239
.L244:
	ld	a0,-72(s0)
	call	ast_skip_indentation
	ld	a5,-72(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,a4,.L250
	ld	a3,-80(s0)
	li	a2,1
	li	a1,40
	ld	a0,-72(s0)
	call	parse_condition_partial
	sd	a0,-48(s0)
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L242
	ld	a5,-40(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L238
.L242:
	ld	a5,-48(s0)
	beq	a5,zero,.L251
	ld	a5,-40(s0)
	ld	a5,16(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	linked_list_push
.L239:
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	bne	a5,zero,.L244
	j	.L241
.L250:
	nop
	j	.L241
.L251:
	nop
.L241:
	ld	a5,-72(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	beq	a5,a4,.L245
	ld	a5,-72(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,a4,.L247
	lui	a5,%hi(.LC27)
	addi	a1,a5,%lo(.LC27)
	ld	a0,-80(s0)
	call	report_parse_error
	j	.L247
.L248:
	ld	a0,-72(s0)
	call	retract_indentation
.L247:
	ld	a5,-72(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L248
	ld	a5,-40(s0)
	j	.L238
.L245:
	ld	a3,-80(s0)
	li	a2,0
	li	a1,41
	ld	a0,-72(s0)
	call	parse_condition_partial
	sd	a0,-56(s0)
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L249
	ld	a5,-40(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L238
.L249:
	ld	a5,-40(s0)
	ld	a4,-56(s0)
	sd	a4,24(a5)
	ld	a5,-40(s0)
.L238:
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	parse_if_statement, .-parse_if_statement
	.section	.rodata
	.align	3
.LC28:
	.string	"Expected identifier after for"
	.align	3
.LC29:
	.string	"Expected \"in\" after for"
	.align	3
.LC30:
	.string	"Expected expression after \"in\""
	.align	3
.LC31:
	.string	"Expected \":\" after for"
	.align	3
.LC32:
	.string	"Expected indentation after \":\""
	.align	3
.LC33:
	.string	"Expected statement or \"pass\" after for"
	.align	3
.LC34:
	.string	"Unexpected indentation after for loop"
	.text
	.align	1
	.globl	parse_for_loop
	.type	parse_for_loop, @function
parse_for_loop:
	addi	sp,sp,-176
	sd	ra,168(sp)
	sd	s0,160(sp)
	addi	s0,sp,176
	sd	a0,-136(s0)
	sd	a1,-144(s0)
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L253
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L271
.L253:
	addi	a5,s0,-128
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-128(s0)
	mv	a4,a5
	li	a5,44
	beq	a4,a5,.L255
	li	a5,0
	j	.L271
.L255:
	ld	a5,-136(s0)
	lw	a5,24(a5)
	sw	a5,-20(s0)
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_ident
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L256
	lui	a5,%hi(.LC28)
	addi	a1,a5,%lo(.LC28)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L271
.L256:
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L257
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L271
.L257:
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-176(s0)
	ld	a3,-168(s0)
	ld	a4,-160(s0)
	ld	a5,-152(s0)
	sd	a2,-128(s0)
	sd	a3,-120(s0)
	sd	a4,-112(s0)
	sd	a5,-104(s0)
	lw	a5,-128(s0)
	mv	a4,a5
	li	a5,38
	beq	a4,a5,.L258
	lui	a5,%hi(.LC29)
	addi	a1,a5,%lo(.LC29)
	ld	a0,-144(s0)
	call	report_parse_error
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L271
.L258:
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L259
	lui	a5,%hi(.LC30)
	addi	a1,a5,%lo(.LC30)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L271
.L259:
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L260
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L271
.L260:
	addi	a5,s0,-96
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-96(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L261
	lui	a5,%hi(.LC31)
	addi	a1,a5,%lo(.LC31)
	ld	a0,-144(s0)
	call	report_parse_error
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L271
.L261:
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_consume
	ld	a0,-136(s0)
	call	ast_skip_indentation
	ld	a5,-136(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L262
	lui	a5,%hi(.LC32)
	addi	a1,a5,%lo(.LC32)
	ld	a0,-144(s0)
	call	report_parse_error
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L271
.L262:
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_statement
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L263
	lui	a5,%hi(.LC33)
	addi	a1,a5,%lo(.LC33)
	ld	a0,-144(s0)
	call	report_parse_error
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L271
.L263:
	li	a1,26
	ld	a0,-136(s0)
	call	create_ast_node
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-136(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-56(s0)
	sd	a4,24(a5)
	ld	a0,-136(s0)
	call	ast_skip_indentation
	j	.L264
.L267:
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_statement
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	bne	a5,zero,.L265
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-56(s0)
	ld	a5,24(a5)
	mv	a0,a5
	call	linked_list_free
	lui	a5,%hi(.LC33)
	addi	a1,a5,%lo(.LC33)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L271
.L265:
	ld	a5,-56(s0)
	ld	a5,24(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	linked_list_push
	ld	a0,-136(s0)
	call	ast_skip_indentation
.L264:
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L266
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-136(s0)
	lw	a5,24(a5)
	beq	a4,a5,.L267
.L266:
	ld	a5,-136(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L269
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-56(s0)
	ld	a5,24(a5)
	mv	a0,a5
	call	linked_list_free
	lui	a5,%hi(.LC34)
	addi	a1,a5,%lo(.LC34)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L271
.L270:
	ld	a0,-136(s0)
	call	retract_indentation
.L269:
	ld	a5,-136(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L270
	ld	a5,-56(s0)
.L271:
	mv	a0,a5
	ld	ra,168(sp)
	ld	s0,160(sp)
	addi	sp,sp,176
	jr	ra
	.size	parse_for_loop, .-parse_for_loop
	.section	.rodata
	.align	3
.LC35:
	.string	"Expected condition or \":\" after \"while\""
	.align	3
.LC36:
	.string	"Expected statement or \"pass\" after while"
	.align	3
.LC37:
	.string	"Unexpected indentation after while loop"
	.text
	.align	1
	.globl	parse_while
	.type	parse_while, @function
parse_while:
	addi	sp,sp,-208
	sd	ra,200(sp)
	sd	s0,192(sp)
	addi	s0,sp,208
	sd	a0,-168(s0)
	sd	a1,-176(s0)
	ld	a0,-168(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L273
	li	a5,0
	j	.L274
.L273:
	ld	a5,-168(s0)
	lw	a5,24(a5)
	sw	a5,-20(s0)
	addi	a5,s0,-152
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-152(s0)
	mv	a4,a5
	li	a5,42
	beq	a4,a5,.L275
	li	a5,0
	j	.L274
.L275:
	addi	a5,s0,-208
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-176(s0)
	ld	a0,-168(s0)
	call	parse_expression
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L276
	addi	a5,s0,-120
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-120(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L276
	lui	a5,%hi(.LC35)
	addi	a1,a5,%lo(.LC35)
	ld	a0,-176(s0)
	call	report_parse_error
	li	a5,0
	j	.L274
.L276:
	addi	a5,s0,-88
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-88(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L277
	lui	a5,%hi(.LC24)
	addi	a1,a5,%lo(.LC24)
	ld	a0,-176(s0)
	call	report_parse_error
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L274
.L277:
	addi	a5,s0,-208
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_consume
	ld	a0,-168(s0)
	call	ast_skip_indentation
	ld	a5,-168(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L278
	lui	a5,%hi(.LC25)
	addi	a1,a5,%lo(.LC25)
	ld	a0,-176(s0)
	call	report_parse_error
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L274
.L278:
	ld	a1,-176(s0)
	ld	a0,-168(s0)
	call	parse_statement
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L279
	lui	a5,%hi(.LC36)
	addi	a1,a5,%lo(.LC36)
	ld	a0,-176(s0)
	call	report_parse_error
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L274
.L279:
	li	a1,27
	ld	a0,-168(s0)
	call	create_ast_node
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
	ld	a5,-168(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-48(s0)
	sd	a4,16(a5)
	ld	a5,-48(s0)
	ld	a5,16(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	linked_list_push
.L283:
	ld	a0,-168(s0)
	call	ast_skip_indentation
	ld	a0,-168(s0)
	call	is_end
	mv	a5,a0
	bne	a5,zero,.L280
	ld	a5,-168(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	bne	a4,a5,.L280
	ld	a1,-176(s0)
	ld	a0,-168(s0)
	call	parse_statement
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	bne	a5,zero,.L281
	ld	a5,-176(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L287
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-48(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	li	a5,0
	j	.L274
.L281:
	ld	a5,-48(s0)
	ld	a5,16(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	linked_list_push
	j	.L283
.L287:
	nop
.L280:
	ld	a5,-168(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L285
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-48(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	lui	a5,%hi(.LC37)
	addi	a1,a5,%lo(.LC37)
	ld	a0,-176(s0)
	call	report_parse_error
	li	a5,0
	j	.L274
.L286:
	ld	a0,-168(s0)
	call	retract_indentation
.L285:
	ld	a5,-168(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L286
	ld	a5,-48(s0)
.L274:
	mv	a0,a5
	ld	ra,200(sp)
	ld	s0,192(sp)
	addi	sp,sp,208
	jr	ra
	.size	parse_while, .-parse_while
	.section	.rodata
	.align	3
.LC38:
	.string	"Expected function name after def"
	.align	3
.LC39:
	.string	"Expected \"(\" after function name"
	.align	3
.LC40:
	.string	"Expected \")\" after argument list"
	.align	3
.LC41:
	.string	"Expected \":\" after function definition"
	.align	3
.LC42:
	.string	"Unexpected indentation after function definition loop"
	.text
	.align	1
	.globl	parse_function_definition
	.type	parse_function_definition, @function
parse_function_definition:
	addi	sp,sp,-240
	sd	ra,232(sp)
	sd	s0,224(sp)
	addi	s0,sp,240
	sd	a0,-200(s0)
	sd	a1,-208(s0)
	ld	a0,-200(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L289
	li	a5,0
	j	.L290
.L289:
	addi	a5,s0,-192
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-192(s0)
	mv	a4,a5
	li	a5,48
	beq	a4,a5,.L291
	li	a5,0
	j	.L290
.L291:
	ld	a5,-200(s0)
	lw	a5,24(a5)
	sw	a5,-20(s0)
	addi	a5,s0,-240
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-208(s0)
	ld	a0,-200(s0)
	call	parse_ident
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L292
	lui	a5,%hi(.LC38)
	addi	a1,a5,%lo(.LC38)
	ld	a0,-208(s0)
	call	report_parse_error
	li	a5,0
	j	.L290
.L292:
	addi	a5,s0,-160
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-160(s0)
	mv	a4,a5
	li	a5,56
	beq	a4,a5,.L293
	lui	a5,%hi(.LC39)
	addi	a1,a5,%lo(.LC39)
	ld	a0,-208(s0)
	call	report_parse_error
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L290
.L293:
	addi	a5,s0,-240
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-208(s0)
	ld	a0,-200(s0)
	call	parse_argument_list
	sd	a0,-40(s0)
	addi	a5,s0,-128
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-128(s0)
	mv	a4,a5
	li	a5,57
	beq	a4,a5,.L294
	lui	a5,%hi(.LC40)
	addi	a1,a5,%lo(.LC40)
	ld	a0,-208(s0)
	call	report_parse_error
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L290
.L294:
	addi	a5,s0,-240
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_consume
	addi	a5,s0,-96
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-96(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L295
	lui	a5,%hi(.LC41)
	addi	a1,a5,%lo(.LC41)
	ld	a0,-208(s0)
	call	report_parse_error
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L290
.L295:
	addi	a5,s0,-240
	ld	a1,-200(s0)
	mv	a0,a5
	call	ast_consume
	ld	a0,-200(s0)
	call	ast_skip_indentation
	ld	a5,-200(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L296
	lui	a5,%hi(.LC25)
	addi	a1,a5,%lo(.LC25)
	ld	a0,-208(s0)
	call	report_parse_error
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L290
.L296:
	ld	a1,-208(s0)
	ld	a0,-200(s0)
	call	parse_statement
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L297
	lui	a5,%hi(.LC36)
	addi	a1,a5,%lo(.LC36)
	ld	a0,-208(s0)
	call	report_parse_error
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L290
.L297:
	li	a1,28
	ld	a0,-200(s0)
	call	create_ast_node
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-200(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-56(s0)
	sd	a4,24(a5)
	ld	a5,-56(s0)
	ld	a5,24(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	linked_list_push
.L301:
	ld	a0,-200(s0)
	call	ast_skip_indentation
	ld	a0,-200(s0)
	call	is_end
	mv	a5,a0
	bne	a5,zero,.L298
	ld	a5,-200(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	bne	a4,a5,.L298
	ld	a1,-208(s0)
	ld	a0,-200(s0)
	call	parse_statement
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	bne	a5,zero,.L299
	ld	a5,-208(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L305
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-56(s0)
	ld	a5,24(a5)
	mv	a0,a5
	call	linked_list_free
	li	a5,0
	j	.L290
.L299:
	ld	a5,-56(s0)
	ld	a5,16(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	linked_list_push
	j	.L301
.L305:
	nop
.L298:
	ld	a5,-200(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L303
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-200(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-56(s0)
	ld	a5,24(a5)
	mv	a0,a5
	call	linked_list_free
	lui	a5,%hi(.LC42)
	addi	a1,a5,%lo(.LC42)
	ld	a0,-208(s0)
	call	report_parse_error
	li	a5,0
	j	.L290
.L304:
	ld	a0,-200(s0)
	call	retract_indentation
.L303:
	ld	a5,-200(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L304
	ld	a5,-56(s0)
.L290:
	mv	a0,a5
	ld	ra,232(sp)
	ld	s0,224(sp)
	addi	sp,sp,240
	jr	ra
	.size	parse_function_definition, .-parse_function_definition
	.section	.rodata
	.align	3
.LC43:
	.string	"Expected value after assignment"
	.text
	.align	1
	.globl	parse_assign
	.type	parse_assign, @function
parse_assign:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L307
	li	a5,0
	j	.L308
.L307:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_expression
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L309
	li	a5,0
	j	.L308
.L309:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L310
	ld	a5,-24(s0)
	j	.L308
.L310:
	addi	a5,s0,-80
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,7
	beq	a4,a5,.L311
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,11
	beq	a4,a5,.L311
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,14
	beq	a4,a5,.L311
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,16
	beq	a4,a5,.L311
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,18
	beq	a4,a5,.L311
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,22
	beq	a4,a5,.L311
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,24
	beq	a4,a5,.L311
	ld	a5,-24(s0)
	j	.L308
.L311:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L312
	lui	a5,%hi(.LC43)
	addi	a1,a5,%lo(.LC43)
	ld	a0,-96(s0)
	call	report_parse_error
	ld	a5,-88(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L308
.L312:
	li	a1,8
	ld	a0,-88(s0)
	call	create_ast_node
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-48(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-48(s0)
	lw	a4,-28(s0)
	sw	a4,24(a5)
	ld	a5,-48(s0)
	sd	a5,-24(s0)
	j	.L309
.L308:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_assign, .-parse_assign
	.section	.rodata
	.align	3
.LC44:
	.string	"Expected expression after unary operator"
	.text
	.align	1
	.globl	parse_unary_statement
	.type	parse_unary_statement, @function
parse_unary_statement:
	addi	sp,sp,-128
	sd	ra,120(sp)
	sd	s0,112(sp)
	addi	s0,sp,128
	sd	a0,-72(s0)
	mv	a5,a1
	mv	a4,a2
	sd	a3,-88(s0)
	sw	a5,-76(s0)
	mv	a5,a4
	sw	a5,-80(s0)
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L314
	li	a5,0
	j	.L315
.L314:
	addi	a5,s0,-56
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_peek
	lw	a4,-56(s0)
	lw	a5,-76(s0)
	sext.w	a5,a5
	beq	a5,a4,.L316
	li	a5,0
	j	.L315
.L316:
	addi	a5,s0,-128
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	lw	a5,-80(s0)
	mv	a1,a5
	ld	a0,-72(s0)
	call	create_ast_node
	sd	a0,-24(s0)
	ld	a1,-88(s0)
	ld	a0,-72(s0)
	call	parse_expression
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,8(a5)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	bne	a5,zero,.L317
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC44)
	addi	a1,a5,%lo(.LC44)
	ld	a0,-88(s0)
	call	report_parse_error
	li	a5,0
	j	.L315
.L317:
	ld	a5,-24(s0)
.L315:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_unary_statement, .-parse_unary_statement
	.align	1
	.globl	parse_delete
	.type	parse_delete, @function
parse_delete:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a3,-32(s0)
	li	a2,29
	li	a1,49
	ld	a0,-24(s0)
	call	parse_unary_statement
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	parse_delete, .-parse_delete
	.align	1
	.globl	parse_return
	.type	parse_return, @function
parse_return:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a3,-32(s0)
	li	a2,31
	li	a1,50
	ld	a0,-24(s0)
	call	parse_unary_statement
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	parse_return, .-parse_return
	.align	1
	.globl	parse_break
	.type	parse_break, @function
parse_break:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	ld	a0,-56(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L323
	li	a5,0
	j	.L324
.L323:
	addi	a5,s0,-48
	ld	a1,-56(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-48(s0)
	mv	a4,a5
	li	a5,46
	bne	a4,a5,.L325
	addi	a5,s0,-96
	ld	a1,-56(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,30
	ld	a0,-56(s0)
	call	create_ast_node
	mv	a5,a0
	j	.L324
.L325:
	li	a5,0
.L324:
	mv	a0,a5
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	parse_break, .-parse_break
	.align	1
	.globl	parse_statement
	.type	parse_statement, @function
parse_statement:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L327
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L328
.L327:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_if_statement
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	beq	a5,zero,.L329
	ld	a5,-24(s0)
	j	.L328
.L329:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L330
	li	a5,0
	j	.L328
.L330:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_for_loop
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L331
	ld	a5,-32(s0)
	j	.L328
.L331:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L332
	li	a5,0
	j	.L328
.L332:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_while
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	beq	a5,zero,.L333
	ld	a5,-40(s0)
	j	.L328
.L333:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L334
	li	a5,0
	j	.L328
.L334:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_function_definition
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	beq	a5,zero,.L335
	ld	a5,-48(s0)
	j	.L328
.L335:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L336
	li	a5,0
	j	.L328
.L336:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_delete
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	beq	a5,zero,.L337
	ld	a5,-56(s0)
	j	.L328
.L337:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L338
	li	a5,0
	j	.L328
.L338:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_return
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	beq	a5,zero,.L339
	ld	a5,-64(s0)
	j	.L328
.L339:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L340
	li	a5,0
	j	.L328
.L340:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_break
	sd	a0,-72(s0)
	ld	a5,-72(s0)
	beq	a5,zero,.L341
	ld	a5,-72(s0)
	j	.L328
.L341:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L342
	li	a5,0
	j	.L328
.L342:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_assign
	sd	a0,-80(s0)
	ld	a5,-80(s0)
	beq	a5,zero,.L343
	ld	a5,-80(s0)
	j	.L328
.L343:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L344
	li	a5,0
	j	.L328
.L344:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_expression
	mv	a5,a0
.L328:
	mv	a0,a5
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	parse_statement, .-parse_statement
	.align	1
	.globl	parse
	.type	parse, @function
parse:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	addi	a5,s0,-20
	mv	a1,a5
	ld	a0,-40(s0)
	call	parse_statement
	mv	a5,a0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	parse, .-parse
	.ident	"GCC: () 13.2.0"
