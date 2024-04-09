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
.LC8:
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
	j	.L57
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
	j	.L57
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
	j	.L57
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
	sw	a5,-24(s0)
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
	sb	zero,-17(s0)
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
	j	.L57
.L52:
	ld	a5,-32(s0)
	ld	a5,8(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	linked_list_push
	sb	zero,-17(s0)
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
	j	.L57
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
	lw	a5,-24(s0)
	sext.w	a5,a5
	beq	a5,a4,.L54
	lui	a5,%hi(.LC8)
	addi	a1,a5,%lo(.LC8)
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
	j	.L57
.L54:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,63
	bne	a4,a5,.L51
	li	a5,1
	sb	a5,-17(s0)
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
.L51:
	lw	a4,-72(s0)
	lw	a5,-24(s0)
	sext.w	a5,a5
	bne	a5,a4,.L55
	lbu	a5,-17(s0)
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L56
	ld	a5,-32(s0)
	ld	a5,8(a5)
	ld	a4,16(a5)
	li	a5,1
	bne	a4,a5,.L56
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,57
	bne	a4,a5,.L56
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a5,-32(s0)
	ld	a5,8(a5)
	ld	a5,0(a5)
	ld	a5,0(a5)
	j	.L57
.L56:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a5,-32(s0)
.L57:
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
	beq	a5,zero,.L59
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L62
.L59:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,6
	bne	a4,a5,.L61
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
	j	.L62
.L61:
	li	a5,0
.L62:
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
	beq	a5,zero,.L64
	li	a5,0
	j	.L65
.L64:
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
.L70:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_argument
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L66
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L71
	li	a5,0
	j	.L65
.L66:
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
	bne	a4,a5,.L72
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	j	.L70
.L71:
	nop
	j	.L68
.L72:
	nop
.L68:
	ld	a5,-24(s0)
.L65:
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	parse_argument_list, .-parse_argument_list
	.section	.rodata
	.align	3
.LC9:
	.string	"Expected lambda arguments or \":\" after \"lambda\""
	.align	3
.LC10:
	.string	"Expected \":\" after lambda arguments"
	.align	3
.LC11:
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
	beq	a5,zero,.L74
	ld	a5,-24(s0)
	j	.L83
.L74:
	ld	a5,-128(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L76
	li	a5,0
	j	.L83
.L76:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L77
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L83
.L77:
	addi	a5,s0,-112
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,61
	beq	a4,a5,.L78
	li	a5,0
	j	.L83
.L78:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_argument_list
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L79
	addi	a5,s0,-80
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L79
	lui	a5,%hi(.LC9)
	addi	a1,a5,%lo(.LC9)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L83
.L79:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L80
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L83
.L80:
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
	beq	a4,a5,.L81
	lui	a5,%hi(.LC10)
	addi	a1,a5,%lo(.LC10)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L83
.L81:
	addi	a5,s0,-160
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-128(s0)
	ld	a0,-120(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L82
	lui	a5,%hi(.LC11)
	addi	a1,a5,%lo(.LC11)
	ld	a0,-128(s0)
	call	report_parse_error
	li	a5,0
	j	.L83
.L82:
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
.L83:
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
	beq	a5,zero,.L85
	li	a5,0
	j	.L86
.L85:
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
.L91:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_expression
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L87
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L92
	li	a5,0
	j	.L86
.L87:
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
	bne	a4,a5,.L93
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	j	.L91
.L92:
	nop
	j	.L89
.L93:
	nop
.L89:
	ld	a5,-24(s0)
.L86:
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	parse_expression_list, .-parse_expression_list
	.section	.rodata
	.align	3
.LC12:
	.string	"Expected expression list or \")\" after \"(\""
	.align	3
.LC13:
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
	beq	a5,zero,.L95
	li	a5,0
	j	.L96
.L95:
	addi	a5,s0,-128
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-128(s0)
	mv	a4,a5
	li	a5,56
	beq	a4,a5,.L97
	li	a5,0
	j	.L96
.L97:
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_expression_list
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L98
	addi	a5,s0,-96
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-96(s0)
	mv	a4,a5
	li	a5,57
	beq	a4,a5,.L98
	lui	a5,%hi(.LC12)
	addi	a1,a5,%lo(.LC12)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L96
.L98:
	addi	a5,s0,-64
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,57
	beq	a4,a5,.L99
	lui	a5,%hi(.LC13)
	addi	a1,a5,%lo(.LC13)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L96
.L99:
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
.L96:
	mv	a0,a5
	ld	ra,168(sp)
	ld	s0,160(sp)
	addi	sp,sp,176
	jr	ra
	.size	parse_function_call_partial, .-parse_function_call_partial
	.section	.rodata
	.align	3
.LC14:
	.string	"Expected expression after \"[\""
	.align	3
.LC15:
	.string	"Expected \"]\" or \":\" after index start"
	.align	3
.LC16:
	.string	"Expected expression or \"]\" after \":\""
	.align	3
.LC17:
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
	beq	a5,zero,.L101
	li	a5,0
	j	.L117
.L101:
	addi	a5,s0,-208
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,58
	beq	a4,a5,.L103
	li	a5,0
	j	.L117
.L103:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_expression
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L104
	lui	a5,%hi(.LC14)
	addi	a1,a5,%lo(.LC14)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L117
.L104:
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L105
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
	j	.L117
.L105:
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
	bne	a4,a5,.L106
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
	j	.L117
.L106:
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L107
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC15)
	addi	a1,a5,%lo(.LC15)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L117
.L107:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_expression
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L108
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L109
	addi	a5,s0,-176
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-176(s0)
	mv	a4,a5
	li	a5,59
	bne	a4,a5,.L109
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
	j	.L117
.L109:
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
	j	.L117
.L108:
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L110
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
	j	.L117
.L110:
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
	bne	a4,a5,.L111
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
.L111:
	lw	a5,-208(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L112
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC15)
	addi	a1,a5,%lo(.LC15)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L117
.L112:
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_expression
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L113
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L114
	addi	a5,s0,-144
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-144(s0)
	mv	a4,a5
	li	a5,59
	bne	a4,a5,.L114
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
	j	.L117
.L114:
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
	lui	a5,%hi(.LC16)
	addi	a1,a5,%lo(.LC16)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L117
.L113:
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L115
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
	j	.L117
.L115:
	addi	a5,s0,-112
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,59
	beq	a4,a5,.L116
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
	lui	a5,%hi(.LC17)
	addi	a1,a5,%lo(.LC17)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L117
.L116:
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
.L117:
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
	beq	a5,zero,.L119
	ld	a5,-40(s0)
	j	.L124
.L119:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L121
	li	a5,0
	j	.L124
.L121:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L122
	li	a5,0
	j	.L124
.L122:
	addi	a5,s0,-80
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,6
	beq	a4,a5,.L123
	li	a5,0
	j	.L124
.L123:
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
.L124:
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
	beq	a5,zero,.L126
	ld	a5,-48(s0)
	j	.L139
.L126:
	ld	a5,-128(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L128
	li	a5,0
	j	.L139
.L128:
	addi	a5,s0,-104
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-104(s0)
	bne	a5,zero,.L129
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L130
.L131:
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
.L130:
	lw	a4,-24(s0)
	ld	a5,-80(s0)
	bltu	a4,a5,.L131
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
	j	.L139
.L129:
	lw	a5,-104(s0)
	mv	a4,a5
	li	a5,1
	bne	a4,a5,.L132
	fmv.s.x	fa5,zero
	fsw	fa5,-52(s0)
	sw	zero,-28(s0)
	sw	zero,-32(s0)
	sw	zero,-36(s0)
	j	.L133
.L136:
	ld	a4,-96(s0)
	lw	a5,-36(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,46
	bne	a4,a5,.L134
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
	j	.L135
.L134:
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
.L133:
	lw	a4,-36(s0)
	ld	a5,-80(s0)
	bltu	a4,a5,.L136
.L135:
	li	a5,1
	sw	a5,-40(s0)
	j	.L137
.L138:
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
.L137:
	lw	a4,-36(s0)
	ld	a5,-80(s0)
	bltu	a4,a5,.L138
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
	j	.L139
.L132:
	li	a5,0
.L139:
	mv	a0,a5
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	parse_number, .-parse_number
	.section	.rodata
	.align	3
.LC18:
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
	beq	a5,zero,.L141
	ld	a5,-24(s0)
	j	.L140
.L141:
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L143
	li	a5,0
	j	.L140
.L143:
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L144
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-80(s0)
	call	report_parse_error
	li	a5,0
	j	.L140
.L144:
	addi	a5,s0,-64
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-64(s0)
	mv	a4,a5
	li	a5,56
	bne	a4,a5,.L145
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
	beq	a5,zero,.L146
	li	a5,0
	j	.L140
.L146:
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L147
	lui	a5,%hi(.LC18)
	addi	a1,a5,%lo(.LC18)
	ld	a0,-80(s0)
	call	report_parse_error
	li	a5,0
	j	.L140
.L147:
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
	beq	a4,a5,.L148
	lui	a5,%hi(.LC18)
	addi	a1,a5,%lo(.LC18)
	ld	a0,-80(s0)
	call	report_parse_error
	li	a5,0
	j	.L140
.L148:
	addi	a5,s0,-112
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_consume
	ld	a5,-32(s0)
	j	.L140
.L145:
.L140:
	mv	a0,a5
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
	jr	ra
	.size	parse_primary, .-parse_primary
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
	call	parse_primary
	mv	a5,a0
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	parse_expression_stripped, .-parse_expression_stripped
	.align	1
	.globl	parse_tail
	.type	parse_tail, @function
parse_tail:
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
	bne	a5,zero,.L153
	li	a5,0
	j	.L154
.L153:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_index_or_slice_partial
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L155
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L156
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L154
.L156:
	ld	a5,-32(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,23
	bne	a4,a5,.L157
	li	a5,22
	j	.L158
.L157:
	li	a5,20
.L158:
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
	j	.L159
.L155:
	ld	a1,-80(s0)
	ld	a0,-72(s0)
	call	parse_function_call_partial
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	beq	a5,zero,.L163
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L161
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L154
.L161:
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
.L159:
	j	.L153
.L163:
	nop
	ld	a5,-24(s0)
.L154:
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	parse_tail, .-parse_tail
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
	call	parse_tail
	sd	a0,-24(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L165
	li	a5,0
	j	.L171
.L165:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L167
	ld	a5,-24(s0)
	j	.L171
.L167:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	j	.L168
.L170:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_tail
	sd	a0,-32(s0)
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L169
	li	a5,0
	j	.L171
.L169:
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
	beq	a5,zero,.L168
	ld	a5,-24(s0)
	j	.L171
.L168:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,15
	beq	a4,a5,.L170
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,17
	beq	a4,a5,.L170
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,19
	beq	a4,a5,.L170
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,21
	beq	a4,a5,.L170
	ld	a5,-24(s0)
.L171:
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
	beq	a5,zero,.L173
	li	a5,0
	j	.L179
.L173:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L175
	ld	a5,-24(s0)
	j	.L179
.L175:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	j	.L176
.L178:
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
	beq	a5,zero,.L177
	li	a5,0
	j	.L179
.L177:
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
	beq	a5,zero,.L176
	ld	a5,-24(s0)
	j	.L179
.L176:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,10
	beq	a4,a5,.L178
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,13
	beq	a4,a5,.L178
	ld	a5,-24(s0)
.L179:
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
	beq	a5,zero,.L181
	li	a5,0
	j	.L187
.L181:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L183
	ld	a5,-24(s0)
	j	.L187
.L183:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,31
	beq	a4,a5,.L184
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,32
	beq	a4,a5,.L184
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,33
	beq	a4,a5,.L184
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,34
	beq	a4,a5,.L184
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,29
	bne	a4,a5,.L185
.L184:
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
	beq	a5,zero,.L186
	li	a5,0
	j	.L187
.L186:
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
.L185:
	ld	a5,-24(s0)
.L187:
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
	beq	a5,zero,.L189
	li	a5,0
	j	.L195
.L189:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L191
	ld	a5,-24(s0)
	j	.L195
.L191:
	addi	a5,s0,-72
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	j	.L192
.L194:
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
	beq	a5,zero,.L193
	li	a5,0
	j	.L195
.L193:
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
	beq	a5,zero,.L192
	ld	a5,-24(s0)
	j	.L195
.L192:
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,27
	beq	a4,a5,.L194
	lw	a5,-72(s0)
	mv	a4,a5
	li	a5,28
	beq	a4,a5,.L194
	ld	a5,-24(s0)
.L195:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_logical, .-parse_logical
	.section	.rodata
	.align	3
.LC19:
	.string	"if tern expr is null\n"
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
	.globl	parse_expression
	.type	parse_expression, @function
parse_expression:
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
	bne	a5,zero,.L197
	lui	a5,%hi(.LC19)
	addi	a0,a5,%lo(.LC19)
	call	my_printf
	li	a5,0
	j	.L205
.L197:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L199
	ld	a5,-24(s0)
	j	.L205
.L199:
	addi	a5,s0,-80
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,36
	beq	a4,a5,.L200
	ld	a5,-24(s0)
	j	.L205
.L200:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_logical
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L201
	lui	a5,%hi(.LC20)
	addi	a1,a5,%lo(.LC20)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L205
.L201:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L202
	lui	a5,%hi(.LC21)
	addi	a1,a5,%lo(.LC21)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L205
.L202:
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
	beq	a4,a5,.L203
	lui	a5,%hi(.LC22)
	addi	a1,a5,%lo(.LC22)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L205
.L203:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_logical
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L204
	lui	a5,%hi(.LC23)
	addi	a1,a5,%lo(.LC23)
	ld	a0,-96(s0)
	call	report_parse_error
	li	a5,0
	j	.L205
.L204:
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
.L205:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
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
	j	.L207
.L210:
	addi	a5,s0,-112
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-112(s0)
	mv	a4,a5
	li	a5,69
	bne	a4,a5,.L208
	ld	a5,-120(s0)
	li	a4,-1
	sw	a4,24(a5)
.L208:
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
.L207:
	ld	a0,-120(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L209
	addi	a5,s0,-80
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	mv	a4,a5
	li	a5,68
	beq	a4,a5,.L210
.L209:
	addi	a5,s0,-48
	ld	a1,-120(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-48(s0)
	mv	a4,a5
	li	a5,69
	beq	a4,a5,.L210
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
	.string	"Expected condition after \"if\""
	.align	3
.LC25:
	.string	"Expected \":\" after condition"
	.align	3
.LC26:
	.string	"Unexpected indentation after \":\""
	.align	3
.LC27:
	.string	"Expected statement after if"
	.align	3
.LC28:
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
	beq	a5,zero,.L213
	li	a5,0
	j	.L237
.L213:
	addi	a5,s0,-88
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_peek
	lw	a4,-88(s0)
	lw	a5,-108(s0)
	sext.w	a5,a5
	beq	a5,a4,.L215
	li	a5,0
	j	.L237
.L215:
	ld	a5,-104(s0)
	lw	a5,24(a5)
	sw	a5,-28(s0)
	addi	a5,s0,-160
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_consume
	sd	zero,-24(s0)
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L216
	ld	a1,-120(s0)
	ld	a0,-104(s0)
	call	parse_expression
	sd	a0,-24(s0)
	ld	a5,-120(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L217
	li	a5,0
	j	.L237
.L217:
	ld	a5,-24(s0)
	bne	a5,zero,.L216
	lui	a5,%hi(.LC24)
	addi	a1,a5,%lo(.LC24)
	ld	a0,-120(s0)
	call	report_parse_error
	li	a5,0
	j	.L237
.L216:
	ld	a0,-104(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L218
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-120(s0)
	call	report_parse_error
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L219
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
.L219:
	li	a5,0
	j	.L237
.L218:
	addi	a5,s0,-160
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_peek
	ld	a2,-160(s0)
	ld	a3,-152(s0)
	ld	a4,-144(s0)
	ld	a5,-136(s0)
	sd	a2,-88(s0)
	sd	a3,-80(s0)
	sd	a4,-72(s0)
	sd	a5,-64(s0)
	lw	a5,-88(s0)
	mv	a4,a5
	li	a5,55
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
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
.L221:
	li	a5,0
	j	.L237
.L220:
	addi	a5,s0,-160
	ld	a1,-104(s0)
	mv	a0,a5
	call	ast_consume
	ld	a0,-104(s0)
	call	ast_skip_indentation
	ld	a5,-104(s0)
	lw	a4,24(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L222
	lui	a5,%hi(.LC26)
	addi	a1,a5,%lo(.LC26)
	ld	a0,-120(s0)
	call	report_parse_error
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L223
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
.L223:
	li	a5,0
	j	.L237
.L222:
	ld	a0,-104(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L224
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-120(s0)
	call	report_parse_error
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L225
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
.L225:
	li	a5,0
	j	.L237
.L224:
	ld	a1,-120(s0)
	ld	a0,-104(s0)
	call	parse_statement
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L226
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L227
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
.L227:
	lui	a5,%hi(.LC27)
	addi	a1,a5,%lo(.LC27)
	ld	a0,-120(s0)
	call	report_parse_error
	li	a5,0
	j	.L237
.L226:
	li	a1,24
	ld	a0,-104(s0)
	call	create_ast_node
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-104(s0)
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
	ld	a0,-104(s0)
	call	ast_skip_indentation
	j	.L228
.L232:
	ld	a1,-120(s0)
	ld	a0,-104(s0)
	call	parse_statement
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	bne	a5,zero,.L229
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	my_free
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L230
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
.L230:
	ld	a5,-48(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	li	a5,0
	j	.L237
.L229:
	ld	a5,-48(s0)
	ld	a5,16(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	linked_list_push
	ld	a0,-104(s0)
	call	ast_skip_indentation
.L228:
	ld	a0,-104(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L231
	ld	a5,-104(s0)
	lw	a4,24(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L232
.L231:
	ld	a5,-104(s0)
	lw	a4,24(a5)
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L235
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	my_free
	lbu	a5,-109(s0)
	andi	a5,a5,0xff
	beq	a5,zero,.L234
	ld	a5,-104(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
.L234:
	ld	a5,-48(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	linked_list_free
	lui	a5,%hi(.LC28)
	addi	a1,a5,%lo(.LC28)
	ld	a0,-120(s0)
	call	report_parse_error
	li	a5,0
	j	.L237
.L236:
	ld	a0,-104(s0)
	call	retract_indentation
.L235:
	ld	a5,-104(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L236
	ld	a5,-48(s0)
.L237:
	mv	a0,a5
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	parse_condition_partial, .-parse_condition_partial
	.section	.rodata
	.align	3
.LC29:
	.string	"address of if condition: %d\n"
	.text
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
	bne	a5,zero,.L239
	li	a5,0
	j	.L240
.L239:
	ld	a5,-32(s0)
	ld	a5,8(a5)
	mv	a1,a5
	lui	a5,%hi(.LC29)
	addi	a0,a5,%lo(.LC29)
	call	my_printf
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
	j	.L241
.L246:
	ld	a0,-72(s0)
	call	ast_skip_indentation
	ld	a5,-72(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,a4,.L252
	ld	a3,-80(s0)
	li	a2,1
	li	a1,40
	ld	a0,-72(s0)
	call	parse_condition_partial
	sd	a0,-48(s0)
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L244
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
	j	.L240
.L244:
	ld	a5,-48(s0)
	beq	a5,zero,.L253
	ld	a5,-40(s0)
	ld	a5,16(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	linked_list_push
.L241:
	ld	a0,-72(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	bne	a5,zero,.L246
	j	.L243
.L252:
	nop
	j	.L243
.L253:
	nop
.L243:
	ld	a5,-72(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	beq	a5,a4,.L247
	ld	a5,-72(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bge	a5,a4,.L249
	lui	a5,%hi(.LC28)
	addi	a1,a5,%lo(.LC28)
	ld	a0,-80(s0)
	call	report_parse_error
	j	.L249
.L250:
	ld	a0,-72(s0)
	call	retract_indentation
.L249:
	ld	a5,-72(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L250
	ld	a5,-40(s0)
	j	.L240
.L247:
	ld	a3,-80(s0)
	li	a2,0
	li	a1,41
	ld	a0,-72(s0)
	call	parse_condition_partial
	sd	a0,-56(s0)
	ld	a5,-80(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L251
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
	j	.L240
.L251:
	ld	a5,-40(s0)
	ld	a4,-56(s0)
	sd	a4,24(a5)
	ld	a5,-40(s0)
.L240:
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	parse_if_statement, .-parse_if_statement
	.section	.rodata
	.align	3
.LC30:
	.string	"Expected identifier after for"
	.align	3
.LC31:
	.string	"Expected \"in\" after for"
	.align	3
.LC32:
	.string	"Expected expression after \"in\""
	.align	3
.LC33:
	.string	"Expected \":\" after for"
	.align	3
.LC34:
	.string	"Expected indentation after \":\""
	.align	3
.LC35:
	.string	"Expected statement or \"pass\" after for"
	.align	3
.LC36:
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
	beq	a5,zero,.L255
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L273
.L255:
	addi	a5,s0,-128
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-128(s0)
	mv	a4,a5
	li	a5,44
	beq	a4,a5,.L257
	li	a5,0
	j	.L273
.L257:
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
	bne	a5,zero,.L258
	lui	a5,%hi(.LC30)
	addi	a1,a5,%lo(.LC30)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L273
.L258:
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L259
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L273
.L259:
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
	beq	a4,a5,.L260
	lui	a5,%hi(.LC31)
	addi	a1,a5,%lo(.LC31)
	ld	a0,-144(s0)
	call	report_parse_error
	ld	a5,-136(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L273
.L260:
	addi	a5,s0,-176
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L261
	lui	a5,%hi(.LC32)
	addi	a1,a5,%lo(.LC32)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L273
.L261:
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L262
	lui	a5,%hi(.LC1)
	addi	a1,a5,%lo(.LC1)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L273
.L262:
	addi	a5,s0,-96
	ld	a1,-136(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-96(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L263
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
	j	.L273
.L263:
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
	beq	a4,a5,.L264
	lui	a5,%hi(.LC34)
	addi	a1,a5,%lo(.LC34)
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
	j	.L273
.L264:
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_statement
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L265
	lui	a5,%hi(.LC35)
	addi	a1,a5,%lo(.LC35)
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
	j	.L273
.L265:
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
	j	.L266
.L269:
	ld	a1,-144(s0)
	ld	a0,-136(s0)
	call	parse_statement
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	bne	a5,zero,.L267
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
	lui	a5,%hi(.LC35)
	addi	a1,a5,%lo(.LC35)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L273
.L267:
	ld	a5,-56(s0)
	ld	a5,24(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	linked_list_push
	ld	a0,-136(s0)
	call	ast_skip_indentation
.L266:
	ld	a0,-136(s0)
	call	is_end
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L268
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-136(s0)
	lw	a5,24(a5)
	beq	a4,a5,.L269
.L268:
	ld	a5,-136(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L271
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
	lui	a5,%hi(.LC36)
	addi	a1,a5,%lo(.LC36)
	ld	a0,-144(s0)
	call	report_parse_error
	li	a5,0
	j	.L273
.L272:
	ld	a0,-136(s0)
	call	retract_indentation
.L271:
	ld	a5,-136(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L272
	ld	a5,-56(s0)
.L273:
	mv	a0,a5
	ld	ra,168(sp)
	ld	s0,160(sp)
	addi	sp,sp,176
	jr	ra
	.size	parse_for_loop, .-parse_for_loop
	.section	.rodata
	.align	3
.LC37:
	.string	"Expected condition or \":\" after \"while\""
	.align	3
.LC38:
	.string	"Expected statement or \"pass\" after while"
	.align	3
.LC39:
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
	beq	a5,zero,.L275
	li	a5,0
	j	.L276
.L275:
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
	beq	a4,a5,.L277
	li	a5,0
	j	.L276
.L277:
	addi	a5,s0,-208
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-176(s0)
	ld	a0,-168(s0)
	call	parse_expression
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L278
	addi	a5,s0,-120
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-120(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L278
	lui	a5,%hi(.LC37)
	addi	a1,a5,%lo(.LC37)
	ld	a0,-176(s0)
	call	report_parse_error
	li	a5,0
	j	.L276
.L278:
	addi	a5,s0,-88
	ld	a1,-168(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-88(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L279
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
	j	.L276
.L279:
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
	beq	a4,a5,.L280
	lui	a5,%hi(.LC26)
	addi	a1,a5,%lo(.LC26)
	ld	a0,-176(s0)
	call	report_parse_error
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L276
.L280:
	ld	a1,-176(s0)
	ld	a0,-168(s0)
	call	parse_statement
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L281
	lui	a5,%hi(.LC38)
	addi	a1,a5,%lo(.LC38)
	ld	a0,-176(s0)
	call	report_parse_error
	ld	a5,-168(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L276
.L281:
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
.L285:
	ld	a0,-168(s0)
	call	ast_skip_indentation
	ld	a0,-168(s0)
	call	is_end
	mv	a5,a0
	bne	a5,zero,.L282
	ld	a5,-168(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	bne	a4,a5,.L282
	ld	a1,-176(s0)
	ld	a0,-168(s0)
	call	parse_statement
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	bne	a5,zero,.L283
	ld	a5,-176(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L289
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
	j	.L276
.L283:
	ld	a5,-48(s0)
	ld	a5,16(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	linked_list_push
	j	.L285
.L289:
	nop
.L282:
	ld	a5,-168(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L287
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
	lui	a5,%hi(.LC39)
	addi	a1,a5,%lo(.LC39)
	ld	a0,-176(s0)
	call	report_parse_error
	li	a5,0
	j	.L276
.L288:
	ld	a0,-168(s0)
	call	retract_indentation
.L287:
	ld	a5,-168(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L288
	ld	a5,-48(s0)
.L276:
	mv	a0,a5
	ld	ra,200(sp)
	ld	s0,192(sp)
	addi	sp,sp,208
	jr	ra
	.size	parse_while, .-parse_while
	.section	.rodata
	.align	3
.LC40:
	.string	"Expected function name after def"
	.align	3
.LC41:
	.string	"Expected \"(\" after function name"
	.align	3
.LC42:
	.string	"Expected \")\" after argument list"
	.align	3
.LC43:
	.string	"Expected \":\" after function definition"
	.align	3
.LC44:
	.string	"Unexpected indentation after function definition loop"
	.text
	.align	1
	.globl	parse_function_definition
	.type	parse_function_definition, @function
parse_function_definition:
	addi	sp,sp,-256
	sd	ra,248(sp)
	sd	s0,240(sp)
	addi	s0,sp,256
	sd	a0,-216(s0)
	sd	a1,-224(s0)
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L291
	li	a5,0
	j	.L292
.L291:
	addi	a5,s0,-200
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-200(s0)
	mv	a4,a5
	li	a5,48
	beq	a4,a5,.L293
	li	a5,0
	j	.L292
.L293:
	ld	a5,-216(s0)
	lw	a5,24(a5)
	sw	a5,-20(s0)
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_ident
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L294
	lui	a5,%hi(.LC40)
	addi	a1,a5,%lo(.LC40)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L292
.L294:
	addi	a5,s0,-168
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-168(s0)
	mv	a4,a5
	li	a5,56
	beq	a4,a5,.L295
	lui	a5,%hi(.LC41)
	addi	a1,a5,%lo(.LC41)
	ld	a0,-224(s0)
	call	report_parse_error
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L292
.L295:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_argument_list
	sd	a0,-40(s0)
	addi	a5,s0,-136
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-136(s0)
	mv	a4,a5
	li	a5,57
	beq	a4,a5,.L296
	lui	a5,%hi(.LC42)
	addi	a1,a5,%lo(.LC42)
	ld	a0,-224(s0)
	call	report_parse_error
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L292
.L296:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	addi	a5,s0,-104
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-104(s0)
	mv	a4,a5
	li	a5,55
	beq	a4,a5,.L297
	lui	a5,%hi(.LC43)
	addi	a1,a5,%lo(.LC43)
	ld	a0,-224(s0)
	call	report_parse_error
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L292
.L297:
	addi	a5,s0,-256
	ld	a1,-216(s0)
	mv	a0,a5
	call	ast_consume
	ld	a0,-216(s0)
	call	ast_skip_indentation
	ld	a5,-216(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	beq	a4,a5,.L298
	lui	a5,%hi(.LC26)
	addi	a1,a5,%lo(.LC26)
	ld	a0,-224(s0)
	call	report_parse_error
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L292
.L298:
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_statement
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	bne	a5,zero,.L299
	lui	a5,%hi(.LC38)
	addi	a1,a5,%lo(.LC38)
	ld	a0,-224(s0)
	call	report_parse_error
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-32(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L292
.L299:
	li	a1,28
	ld	a0,-216(s0)
	call	create_ast_node
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	li	a1,32
	ld	a0,-216(s0)
	call	create_ast_node
	sd	a0,-64(s0)
	ld	a5,-216(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	mv	a4,a0
	ld	a5,-64(s0)
	sd	a4,8(a5)
	ld	a5,-56(s0)
	ld	a4,-64(s0)
	sd	a4,24(a5)
	ld	a5,-64(s0)
	ld	a5,8(a5)
	ld	a1,-48(s0)
	mv	a0,a5
	call	linked_list_push
.L303:
	ld	a0,-216(s0)
	call	ast_skip_indentation
	ld	a0,-216(s0)
	call	is_end
	mv	a5,a0
	bne	a5,zero,.L300
	ld	a5,-216(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	bne	a4,a5,.L300
	ld	a1,-224(s0)
	ld	a0,-216(s0)
	call	parse_statement
	sd	a0,-72(s0)
	ld	a5,-72(s0)
	bne	a5,zero,.L301
	ld	a5,-224(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L307
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-64(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	linked_list_free
	li	a5,0
	j	.L292
.L301:
	ld	a5,-64(s0)
	ld	a5,8(a5)
	ld	a1,-72(s0)
	mv	a0,a5
	call	linked_list_push
	j	.L303
.L307:
	nop
.L300:
	ld	a5,-216(s0)
	lw	a4,24(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	ble	a4,a5,.L305
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-56(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-40(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-216(s0)
	ld	a5,0(a5)
	ld	a1,-64(s0)
	mv	a0,a5
	call	my_free
	ld	a5,-64(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	linked_list_free
	lui	a5,%hi(.LC44)
	addi	a1,a5,%lo(.LC44)
	ld	a0,-224(s0)
	call	report_parse_error
	li	a5,0
	j	.L292
.L306:
	ld	a0,-216(s0)
	call	retract_indentation
.L305:
	ld	a5,-216(s0)
	lw	a5,24(a5)
	bne	a5,zero,.L306
	ld	a5,-56(s0)
.L292:
	mv	a0,a5
	ld	ra,248(sp)
	ld	s0,240(sp)
	addi	sp,sp,256
	jr	ra
	.size	parse_function_definition, .-parse_function_definition
	.section	.rodata
	.align	3
.LC45:
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
	beq	a5,zero,.L309
	li	a5,0
	j	.L310
.L309:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_expression
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L311
	li	a5,0
	j	.L310
.L311:
	ld	a0,-88(s0)
	call	is_end
	mv	a5,a0
	beq	a5,zero,.L312
	ld	a5,-24(s0)
	j	.L310
.L312:
	addi	a5,s0,-80
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-80(s0)
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,7
	beq	a4,a5,.L313
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,11
	beq	a4,a5,.L313
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,14
	beq	a4,a5,.L313
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,16
	beq	a4,a5,.L313
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,18
	beq	a4,a5,.L313
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,22
	beq	a4,a5,.L313
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,24
	beq	a4,a5,.L313
	ld	a5,-24(s0)
	j	.L310
.L313:
	addi	a5,s0,-128
	ld	a1,-88(s0)
	mv	a0,a5
	call	ast_consume
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_expression
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	bne	a5,zero,.L314
	lui	a5,%hi(.LC45)
	addi	a1,a5,%lo(.LC45)
	ld	a0,-96(s0)
	call	report_parse_error
	ld	a5,-88(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	li	a5,0
	j	.L310
.L314:
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
	j	.L311
.L310:
	mv	a0,a5
	ld	ra,120(sp)
	ld	s0,112(sp)
	addi	sp,sp,128
	jr	ra
	.size	parse_assign, .-parse_assign
	.section	.rodata
	.align	3
.LC46:
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
	beq	a5,zero,.L316
	li	a5,0
	j	.L317
.L316:
	addi	a5,s0,-56
	ld	a1,-72(s0)
	mv	a0,a5
	call	ast_peek
	lw	a4,-56(s0)
	lw	a5,-76(s0)
	sext.w	a5,a5
	beq	a5,a4,.L318
	li	a5,0
	j	.L317
.L318:
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
	bne	a5,zero,.L319
	ld	a5,-72(s0)
	ld	a5,0(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	my_free
	lui	a5,%hi(.LC46)
	addi	a1,a5,%lo(.LC46)
	ld	a0,-88(s0)
	call	report_parse_error
	li	a5,0
	j	.L317
.L319:
	ld	a5,-24(s0)
.L317:
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
	beq	a5,zero,.L325
	li	a5,0
	j	.L326
.L325:
	addi	a5,s0,-48
	ld	a1,-56(s0)
	mv	a0,a5
	call	ast_peek
	lw	a5,-48(s0)
	mv	a4,a5
	li	a5,46
	bne	a4,a5,.L327
	addi	a5,s0,-96
	ld	a1,-56(s0)
	mv	a0,a5
	call	ast_consume
	li	a1,30
	ld	a0,-56(s0)
	call	create_ast_node
	mv	a5,a0
	j	.L326
.L327:
	li	a5,0
.L326:
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
	beq	a5,zero,.L329
	li	a5,0
	j	.L330
.L329:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_if_statement
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	beq	a5,zero,.L331
	ld	a5,-24(s0)
	j	.L330
.L331:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L332
	li	a5,0
	j	.L330
.L332:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_for_loop
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L333
	ld	a5,-32(s0)
	j	.L330
.L333:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L334
	li	a5,0
	j	.L330
.L334:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_while
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	beq	a5,zero,.L335
	ld	a5,-40(s0)
	j	.L330
.L335:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L336
	li	a5,0
	j	.L330
.L336:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_function_definition
	sd	a0,-48(s0)
	ld	a5,-48(s0)
	beq	a5,zero,.L337
	ld	a5,-48(s0)
	j	.L330
.L337:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L338
	li	a5,0
	j	.L330
.L338:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_delete
	sd	a0,-56(s0)
	ld	a5,-56(s0)
	beq	a5,zero,.L339
	ld	a5,-56(s0)
	j	.L330
.L339:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L340
	li	a5,0
	j	.L330
.L340:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_return
	sd	a0,-64(s0)
	ld	a5,-64(s0)
	beq	a5,zero,.L341
	ld	a5,-64(s0)
	j	.L330
.L341:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L342
	li	a5,0
	j	.L330
.L342:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_break
	sd	a0,-72(s0)
	ld	a5,-72(s0)
	beq	a5,zero,.L343
	ld	a5,-72(s0)
	j	.L330
.L343:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L344
	li	a5,0
	j	.L330
.L344:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_assign
	sd	a0,-80(s0)
	ld	a5,-80(s0)
	beq	a5,zero,.L345
	ld	a5,-80(s0)
	j	.L330
.L345:
	ld	a5,-96(s0)
	lw	a5,0(a5)
	beq	a5,zero,.L346
	li	a5,0
	j	.L330
.L346:
	ld	a1,-96(s0)
	ld	a0,-88(s0)
	call	parse_expression
	mv	a5,a0
.L330:
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
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	sw	zero,-44(s0)
	ld	a5,-56(s0)
	ld	a5,0(a5)
	mv	a0,a5
	call	linked_list_create
	sd	a0,-24(s0)
	ld	a5,-56(s0)
	sw	zero,24(a5)
	j	.L348
.L352:
	ld	a5,-56(s0)
	lw	a5,24(a5)
	beq	a5,zero,.L349
	addi	a4,s0,-44
	lui	a5,%hi(.LC28)
	addi	a1,a5,%lo(.LC28)
	mv	a0,a4
	call	report_parse_error
	ld	a0,-24(s0)
	call	linked_list_free
	li	a5,0
	j	.L353
.L349:
	lw	a5,-44(s0)
	beq	a5,zero,.L351
	ld	a0,-24(s0)
	call	linked_list_free
	li	a5,0
	j	.L353
.L351:
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	linked_list_push
	ld	a0,-56(s0)
	call	ast_skip_indentation
.L348:
	addi	a5,s0,-44
	mv	a1,a5
	ld	a0,-56(s0)
	call	parse_statement
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	bne	a5,zero,.L352
	li	a1,32
	ld	a0,-56(s0)
	call	create_ast_node
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a4,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
.L353:
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	parse, .-parse
	.ident	"GCC: () 13.2.0"
