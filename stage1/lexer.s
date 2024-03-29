	.file	"lexer.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	create_substring
	.type	create_substring, @function
create_substring:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	mv	a5,a1
	mv	a4,a2
	sd	a3,-56(s0)
	sw	a5,-44(s0)
	mv	a5,a4
	sw	a5,-48(s0)
	lw	a5,-48(s0)
	mv	a4,a5
	lw	a5,-44(s0)
	subw	a5,a4,a5
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	mv	a1,a5
	ld	a0,-56(s0)
	call	my_alloc
	sd	a0,-32(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-44(s0)
	mv	a4,a5
	lw	a5,-20(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	mv	a4,a5
	ld	a5,-40(s0)
	add	a4,a5,a4
	lw	a5,-20(s0)
	ld	a3,-32(s0)
	add	a5,a3,a5
	lbu	a4,0(a4)
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L3
	lw	a5,-24(s0)
	ld	a4,-32(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
	ld	a5,-32(s0)
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	create_substring, .-create_substring
	.align	1
	.globl	tok_peek
	.type	tok_peek, @function
tok_peek:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a5,8(a5)
	mv	a4,a5
	ld	a5,-24(s0)
	ld	a5,24(a5)
	bgeu	a4,a5,.L6
	ld	a5,-24(s0)
	ld	a5,0(a5)
	ld	a4,-24(s0)
	lw	a4,8(a4)
	add	a5,a5,a4
	lbu	a5,0(a5)
	j	.L7
.L6:
	li	a5,0
.L7:
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	tok_peek, .-tok_peek
	.align	1
	.globl	tok_consume
	.type	tok_consume, @function
tok_consume:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a0,-24(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,10
	bne	a4,a5,.L9
	ld	a5,-24(s0)
	lw	a5,12(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,12(a5)
	ld	a5,-24(s0)
	li	a4,-1
	sw	a4,20(a5)
.L9:
	ld	a5,-24(s0)
	lw	a5,20(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,20(a5)
	ld	a5,-24(s0)
	lw	a5,8(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,8(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	tok_consume, .-tok_consume
	.align	1
	.globl	is_eof
	.type	is_eof, @function
is_eof:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a5,8(a5)
	mv	a4,a5
	ld	a5,-24(s0)
	ld	a5,24(a5)
	sltu	a5,a4,a5
	seqz	a5,a5
	andi	a5,a5,0xff
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	is_eof, .-is_eof
	.align	1
	.globl	make_token
	.type	make_token, @function
make_token:
	addi	sp,sp,-96
	sd	s0,88(sp)
	addi	s0,sp,96
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a3,-80(s0)
	sd	a5,-88(s0)
	mv	a5,a2
	sw	a5,-68(s0)
	mv	a5,a4
	sw	a5,-72(s0)
	lw	a5,-68(s0)
	sw	a5,-48(s0)
	ld	a5,-80(s0)
	sd	a5,-40(s0)
	lw	a5,-72(s0)
	sw	a5,-32(s0)
	ld	a5,-64(s0)
	lw	a5,12(a5)
	sw	a5,-28(s0)
	ld	a5,-88(s0)
	sd	a5,-24(s0)
	ld	a5,-56(s0)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a3,-32(s0)
	ld	a4,-24(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	ld	a0,-56(s0)
	ld	s0,88(sp)
	addi	sp,sp,96
	jr	ra
	.size	make_token, .-make_token
	.align	1
	.globl	make_error_token
	.type	make_error_token, @function
make_error_token:
	addi	sp,sp,-80
	sd	s0,72(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	li	a5,67
	sw	a5,-48(s0)
	ld	a5,-72(s0)
	sd	a5,-40(s0)
	sw	zero,-32(s0)
	ld	a5,-64(s0)
	lw	a5,12(a5)
	sw	a5,-28(s0)
	ld	a5,-56(s0)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a3,-32(s0)
	ld	a4,-24(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	ld	a0,-56(s0)
	ld	s0,72(sp)
	addi	sp,sp,80
	jr	ra
	.size	make_error_token, .-make_error_token
	.section	.rodata
	.align	3
.LC0:
	.string	"Invalid indentation"
	.text
	.align	1
	.globl	try_tokenize_indentation
	.type	try_tokenize_indentation, @function
try_tokenize_indentation:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-48(s0)
	lw	a5,8(a5)
	sw	a5,-24(s0)
	sw	zero,-20(s0)
	j	.L17
.L20:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	ld	a0,-48(s0)
	call	tok_consume
	ld	a5,-48(s0)
	lw	a4,16(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,a4,.L17
	ld	a5,-48(s0)
	ld	a4,0(a5)
	lw	a5,-24(s0)
	add	a3,a4,a5
	ld	a5,-48(s0)
	lw	a4,12(a5)
	lw	a5,-20(s0)
	ld	a0,-40(s0)
	li	a2,68
	ld	a1,-48(s0)
	call	make_token
	j	.L18
.L17:
	ld	a0,-48(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L19
	ld	a0,-48(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,32
	beq	a4,a5,.L20
.L19:
	ld	a4,-40(s0)
	lui	a5,%hi(.LC0)
	addi	a2,a5,%lo(.LC0)
	ld	a1,-48(s0)
	mv	a0,a4
	call	make_error_token
.L18:
	ld	a0,-40(s0)
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	try_tokenize_indentation, .-try_tokenize_indentation
	.align	1
	.globl	skip_whitespace
	.type	skip_whitespace, @function
skip_whitespace:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	j	.L22
.L24:
	ld	a0,-24(s0)
	call	tok_consume
.L22:
	ld	a0,-24(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L25
	ld	a0,-24(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,32
	beq	a4,a5,.L24
.L25:
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	skip_whitespace, .-skip_whitespace
	.align	1
	.globl	skip_comment
	.type	skip_comment, @function
skip_comment:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a0,-24(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,35
	bne	a4,a5,.L26
	j	.L28
.L30:
	ld	a0,-24(s0)
	call	tok_consume
.L28:
	ld	a0,-24(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L29
	ld	a0,-24(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,10
	bne	a4,a5,.L30
.L29:
	ld	a0,-24(s0)
	call	is_eof
	mv	a5,a0
	bne	a5,zero,.L32
	ld	a0,-24(s0)
	call	tok_consume
	j	.L26
.L32:
	nop
.L26:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	skip_comment, .-skip_comment
	.align	1
	.globl	can_continue_name_c
	.type	can_continue_name_c, @function
can_continue_name_c:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,47
	bleu	a4,a5,.L34
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,57
	bleu	a4,a5,.L35
.L34:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,96
	bleu	a4,a5,.L36
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,122
	bleu	a4,a5,.L35
.L36:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,64
	bleu	a4,a5,.L37
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,90
	bleu	a4,a5,.L35
.L37:
	lbu	a5,-17(s0)
	andi	a4,a5,0xff
	li	a5,95
	bne	a4,a5,.L38
.L35:
	li	a5,1
	j	.L39
.L38:
	li	a5,0
.L39:
	andi	a5,a5,1
	andi	a5,a5,0xff
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	can_continue_name_c, .-can_continue_name_c
	.align	1
	.globl	can_continue_name
	.type	can_continue_name, @function
can_continue_name:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a0,-40(s0)
	call	is_eof
	mv	a5,a0
	beq	a5,zero,.L42
	li	a5,0
	j	.L43
.L42:
	ld	a0,-40(s0)
	call	tok_peek
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
	mv	a0,a5
	call	can_continue_name_c
	mv	a5,a0
.L43:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	can_continue_name, .-can_continue_name
	.align	1
	.globl	matched_at_least
	.type	matched_at_least, @function
matched_at_least:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
	j	.L45
.L49:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-40(s0)
	lw	a4,8(a4)
	lw	a3,-20(s0)
	addw	a4,a3,a4
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a3,0(a5)
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	beq	a4,a5,.L46
	lw	a5,-20(s0)
	j	.L47
.L46:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L45:
	ld	a0,-40(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L48
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-40(s0)
	lw	a4,8(a4)
	lw	a3,-20(s0)
	addw	a4,a3,a4
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a5,0(a5)
	beq	a5,zero,.L48
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L49
.L48:
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L50
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-40(s0)
	lw	a4,8(a4)
	lw	a3,-20(s0)
	addw	a4,a3,a4
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a5,0(a5)
	bne	a5,zero,.L50
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-40(s0)
	lw	a4,8(a4)
	lw	a3,-20(s0)
	addw	a4,a3,a4
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a5,0(a5)
	mv	a0,a5
	call	can_continue_name_c
	mv	a5,a0
	beq	a5,zero,.L50
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sext.w	a5,a5
	j	.L47
.L50:
	lw	a5,-20(s0)
.L47:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	matched_at_least, .-matched_at_least
	.align	1
	.globl	tokenize_name
	.type	tokenize_name, @function
tokenize_name:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-64(s0)
	lw	a4,8(a4)
	add	a5,a5,a4
	sd	a5,-40(s0)
	ld	a5,-64(s0)
	lw	a5,12(a5)
	sw	a5,-28(s0)
	li	a5,6
	sw	a5,-48(s0)
	sw	zero,-32(s0)
	j	.L52
.L53:
	ld	a0,-64(s0)
	call	tok_consume
.L52:
	ld	a0,-64(s0)
	call	can_continue_name
	mv	a5,a0
	bne	a5,zero,.L53
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-64(s0)
	lw	a4,8(a4)
	add	a4,a5,a4
	ld	a5,-40(s0)
	sub	a5,a4,a5
	sd	a5,-24(s0)
	ld	a5,-56(s0)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a3,-32(s0)
	ld	a4,-24(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	ld	a0,-56(s0)
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	tokenize_name, .-tokenize_name
	.align	1
	.globl	is_digit
	.type	is_digit, @function
is_digit:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a0,-24(s0)
	call	is_eof
	mv	a5,a0
	beq	a5,zero,.L56
	li	a5,0
	j	.L57
.L56:
	ld	a0,-24(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,47
	bleu	a4,a5,.L58
	ld	a0,-24(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,57
	bgtu	a4,a5,.L58
	li	a5,1
	j	.L59
.L58:
	li	a5,0
.L59:
	andi	a5,a5,1
	andi	a5,a5,0xff
.L57:
	mv	a0,a5
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	is_digit, .-is_digit
	.align	1
	.globl	tokenize_number
	.type	tokenize_number, @function
tokenize_number:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-64(s0)
	lw	a4,8(a4)
	add	a5,a5,a4
	sd	a5,-40(s0)
	ld	a5,-64(s0)
	lw	a5,12(a5)
	sw	a5,-28(s0)
	sw	zero,-32(s0)
	j	.L61
.L62:
	ld	a0,-64(s0)
	call	tok_consume
.L61:
	ld	a0,-64(s0)
	call	is_digit
	mv	a5,a0
	bne	a5,zero,.L62
	ld	a0,-64(s0)
	call	is_eof
	mv	a5,a0
	bne	a5,zero,.L63
	ld	a0,-64(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,46
	beq	a4,a5,.L64
.L63:
	sw	zero,-48(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-64(s0)
	lw	a4,8(a4)
	add	a4,a5,a4
	ld	a5,-40(s0)
	sub	a5,a4,a5
	sd	a5,-24(s0)
	ld	a5,-56(s0)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a3,-32(s0)
	ld	a4,-24(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	j	.L68
.L64:
	ld	a0,-64(s0)
	call	tok_consume
	j	.L66
.L67:
	ld	a0,-64(s0)
	call	tok_consume
.L66:
	ld	a0,-64(s0)
	call	is_digit
	mv	a5,a0
	bne	a5,zero,.L67
	li	a5,1
	sw	a5,-48(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-64(s0)
	lw	a4,8(a4)
	add	a4,a5,a4
	ld	a5,-40(s0)
	sub	a5,a4,a5
	sd	a5,-24(s0)
	ld	a5,-56(s0)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a3,-32(s0)
	ld	a4,-24(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
.L68:
	ld	a0,-56(s0)
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	tokenize_number, .-tokenize_number
	.align	1
	.globl	is_mathing_exact
	.type	is_mathing_exact, @function
is_mathing_exact:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sw	zero,-20(s0)
	j	.L70
.L74:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-40(s0)
	lw	a4,8(a4)
	lw	a3,-20(s0)
	addw	a4,a3,a4
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a3,0(a5)
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a3
	beq	a4,a5,.L71
	li	a5,0
	j	.L72
.L71:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L70:
	ld	a0,-40(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L73
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-40(s0)
	lw	a4,8(a4)
	lw	a3,-20(s0)
	addw	a4,a3,a4
	sext.w	a4,a4
	add	a5,a5,a4
	lbu	a5,0(a5)
	beq	a5,zero,.L73
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L74
.L73:
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L75
	li	a5,1
	j	.L72
.L75:
	li	a5,0
.L72:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	is_mathing_exact, .-is_mathing_exact
	.section	.rodata
	.align	3
.LC1:
	.string	"Unterminated string"
	.text
	.align	1
	.globl	try_tokenize_string
	.type	try_tokenize_string, @function
try_tokenize_string:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	mv	a5,a2
	sb	a5,-65(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	ld	a4,-64(s0)
	lw	a4,8(a4)
	add	a5,a5,a4
	sd	a5,-40(s0)
	ld	a5,-64(s0)
	lw	a5,12(a5)
	sw	a5,-28(s0)
	li	a5,2
	sw	a5,-48(s0)
	sw	zero,-32(s0)
	ld	a0,-64(s0)
	call	tok_consume
	j	.L77
.L79:
	ld	a0,-64(s0)
	call	tok_consume
.L77:
	ld	a0,-64(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L78
	ld	a0,-64(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	lbu	a5,-65(s0)
	andi	a5,a5,0xff
	bne	a5,a4,.L79
.L78:
	ld	a0,-64(s0)
	call	is_eof
	mv	a5,a0
	beq	a5,zero,.L80
	ld	a4,-56(s0)
	lui	a5,%hi(.LC1)
	addi	a2,a5,%lo(.LC1)
	ld	a1,-64(s0)
	mv	a0,a4
	call	make_error_token
	j	.L82
.L80:
	ld	a0,-64(s0)
	call	tok_consume
	ld	a5,-64(s0)
	ld	a4,0(a5)
	ld	a5,-40(s0)
	sub	a5,a4,a5
	sd	a5,-24(s0)
	ld	a5,-56(s0)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a3,-32(s0)
	ld	a4,-24(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
.L82:
	ld	a0,-56(s0)
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.size	try_tokenize_string, .-try_tokenize_string
	.section	.rodata
	.align	3
.LC2:
	.string	"Unexpected character"
	.text
	.align	1
	.globl	try_tokenize_special
	.type	try_tokenize_special, @function
try_tokenize_special:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,34
	bne	a4,a5,.L84
	ld	a5,-24(s0)
	li	a2,34
	ld	a1,-32(s0)
	mv	a0,a5
	call	try_tokenize_string
	j	.L85
.L84:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,39
	bne	a4,a5,.L86
	ld	a5,-24(s0)
	li	a2,39
	ld	a1,-32(s0)
	mv	a0,a5
	call	try_tokenize_string
	j	.L85
.L86:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,40
	bne	a4,a5,.L87
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,56
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L87:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,41
	bne	a4,a5,.L88
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,57
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L88:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,91
	bne	a4,a5,.L89
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,58
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L89:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,93
	bne	a4,a5,.L90
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,59
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L90:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,123
	bne	a4,a5,.L91
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,60
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L91:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,125
	bne	a4,a5,.L92
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,62
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L92:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,44
	bne	a4,a5,.L93
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,63
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L93:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,58
	bne	a4,a5,.L94
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,55
	ld	a1,-32(s0)
	call	make_token
	j	.L85
.L94:
	ld	a0,-32(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,35
	bne	a4,a5,.L95
	ld	a0,-32(s0)
	call	skip_comment
	ld	a5,-24(s0)
	ld	a1,-32(s0)
	mv	a0,a5
	call	next_token
	j	.L85
.L95:
	ld	a4,-24(s0)
	lui	a5,%hi(.LC2)
	addi	a2,a5,%lo(.LC2)
	ld	a1,-32(s0)
	mv	a0,a4
	call	make_error_token
.L85:
	ld	a0,-24(s0)
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	try_tokenize_special, .-try_tokenize_special
	.section	.rodata
	.align	3
.LC3:
	.string	"<="
	.align	3
.LC4:
	.string	"<"
	.align	3
.LC5:
	.string	"=="
	.align	3
.LC6:
	.string	"="
	.align	3
.LC7:
	.string	">="
	.align	3
.LC8:
	.string	">"
	.align	3
.LC9:
	.string	"!="
	.align	3
.LC10:
	.string	"+="
	.align	3
.LC11:
	.string	"-="
	.align	3
.LC12:
	.string	"*="
	.align	3
.LC13:
	.string	"/="
	.align	3
.LC14:
	.string	"%="
	.align	3
.LC15:
	.string	"//="
	.align	3
.LC16:
	.string	"**="
	.align	3
.LC17:
	.string	"+"
	.align	3
.LC18:
	.string	"-"
	.align	3
.LC19:
	.string	"//"
	.align	3
.LC20:
	.string	"/"
	.align	3
.LC21:
	.string	"**"
	.align	3
.LC22:
	.string	"*"
	.align	3
.LC23:
	.string	"%"
	.text
	.align	1
	.globl	try_tokenize_operator
	.type	try_tokenize_operator, @function
try_tokenize_operator:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	lui	a5,%hi(.LC3)
	addi	a1,a5,%lo(.LC3)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L97
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,31
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L97:
	lui	a5,%hi(.LC4)
	addi	a1,a5,%lo(.LC4)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L99
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,31
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L99:
	lui	a5,%hi(.LC5)
	addi	a1,a5,%lo(.LC5)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L100
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,29
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L100:
	lui	a5,%hi(.LC6)
	addi	a1,a5,%lo(.LC6)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L101
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,7
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L101:
	lui	a5,%hi(.LC7)
	addi	a1,a5,%lo(.LC7)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L102
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,33
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L102:
	lui	a5,%hi(.LC8)
	addi	a1,a5,%lo(.LC8)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L103
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,33
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L103:
	lui	a5,%hi(.LC9)
	addi	a1,a5,%lo(.LC9)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L104
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,30
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L104:
	lui	a5,%hi(.LC10)
	addi	a1,a5,%lo(.LC10)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L105
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,11
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L105:
	lui	a5,%hi(.LC11)
	addi	a1,a5,%lo(.LC11)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L106
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,14
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L106:
	lui	a5,%hi(.LC12)
	addi	a1,a5,%lo(.LC12)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L107
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,16
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L107:
	lui	a5,%hi(.LC13)
	addi	a1,a5,%lo(.LC13)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L108
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,18
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L108:
	lui	a5,%hi(.LC14)
	addi	a1,a5,%lo(.LC14)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L109
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,2
	li	a4,0
	li	a2,22
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L109:
	lui	a5,%hi(.LC15)
	addi	a1,a5,%lo(.LC15)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L110
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,3
	li	a4,0
	li	a2,20
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L110:
	lui	a5,%hi(.LC16)
	addi	a1,a5,%lo(.LC16)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L111
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,3
	li	a4,0
	li	a2,24
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L111:
	lui	a5,%hi(.LC17)
	addi	a1,a5,%lo(.LC17)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L112
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,10
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L112:
	lui	a5,%hi(.LC18)
	addi	a1,a5,%lo(.LC18)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L113
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,13
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L113:
	lui	a5,%hi(.LC19)
	addi	a1,a5,%lo(.LC19)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L114
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,19
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L114:
	lui	a5,%hi(.LC20)
	addi	a1,a5,%lo(.LC20)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L115
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,17
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L115:
	lui	a5,%hi(.LC21)
	addi	a1,a5,%lo(.LC21)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L116
	ld	a0,-32(s0)
	call	tok_consume
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,23
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L116:
	lui	a5,%hi(.LC22)
	addi	a1,a5,%lo(.LC22)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L117
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,15
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L117:
	lui	a5,%hi(.LC23)
	addi	a1,a5,%lo(.LC23)
	ld	a0,-32(s0)
	call	is_mathing_exact
	mv	a5,a0
	beq	a5,zero,.L118
	ld	a0,-32(s0)
	call	tok_consume
	ld	a5,-32(s0)
	ld	a4,0(a5)
	ld	a5,-32(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-24(s0)
	li	a5,1
	li	a4,0
	li	a2,21
	ld	a1,-32(s0)
	call	make_token
	j	.L98
.L118:
	ld	a5,-24(s0)
	ld	a1,-32(s0)
	mv	a0,a5
	call	try_tokenize_special
.L98:
	ld	a0,-24(s0)
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	try_tokenize_operator, .-try_tokenize_operator
	.section	.rodata
	.align	3
.LC24:
	.string	"assert"
	.align	3
.LC25:
	.string	"as"
	.align	3
.LC26:
	.string	"and"
	.align	3
.LC27:
	.string	"break"
	.align	3
.LC28:
	.string	"continue"
	.align	3
.LC29:
	.string	"def"
	.align	3
.LC30:
	.string	"del"
	.align	3
.LC31:
	.string	"else"
	.align	3
.LC32:
	.string	"elif"
	.align	3
.LC33:
	.string	"except"
	.align	3
.LC34:
	.string	"finally"
	.align	3
.LC35:
	.string	"for"
	.align	3
.LC36:
	.string	"from"
	.align	3
.LC37:
	.string	"global"
	.align	3
.LC38:
	.string	"import"
	.align	3
.LC39:
	.string	"if"
	.align	3
.LC40:
	.string	"in"
	.align	3
.LC41:
	.string	"is"
	.align	3
.LC42:
	.string	"lambda"
	.align	3
.LC43:
	.string	"not"
	.align	3
.LC44:
	.string	"or"
	.align	3
.LC45:
	.string	"pass"
	.align	3
.LC46:
	.string	"return"
	.align	3
.LC47:
	.string	"raise"
	.align	3
.LC48:
	.string	"try"
	.align	3
.LC49:
	.string	"while"
	.align	3
.LC50:
	.string	"with"
	.align	3
.LC51:
	.string	"yield"
	.align	3
.LC52:
	.string	"True"
	.align	3
.LC53:
	.string	"False"
	.text
	.align	1
	.globl	try_tokenize_keyword_tree
	.type	try_tokenize_keyword_tree, @function
try_tokenize_keyword_tree:
	addi	sp,sp,-160
	sd	ra,152(sp)
	sd	s0,144(sp)
	addi	s0,sp,160
	sd	a0,-152(s0)
	sd	a1,-160(s0)
	lui	a5,%hi(.LC24)
	addi	a1,a5,%lo(.LC24)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,6
	bne	a4,a5,.L120
	sw	zero,-20(s0)
	j	.L121
.L122:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L121:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,5
	ble	a4,a5,.L122
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-6
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,6
	li	a4,0
	li	a2,9
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L120:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L124
	lui	a5,%hi(.LC25)
	addi	a1,a5,%lo(.LC25)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L125
	sw	zero,-24(s0)
	j	.L126
.L127:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L126:
	lw	a5,-24(s0)
	sext.w	a4,a5
	li	a5,1
	ble	a4,a5,.L127
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,2
	li	a4,0
	li	a2,8
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L125:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L124:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L128
	lui	a5,%hi(.LC26)
	addi	a1,a5,%lo(.LC26)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,3
	bne	a4,a5,.L129
	sw	zero,-28(s0)
	j	.L130
.L131:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-28(s0)
	addiw	a5,a5,1
	sw	a5,-28(s0)
.L130:
	lw	a5,-28(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L131
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,3
	li	a4,0
	li	a2,27
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L129:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L128:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L132
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L132:
	lui	a5,%hi(.LC27)
	addi	a1,a5,%lo(.LC27)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L133
	sw	zero,-32(s0)
	j	.L134
.L135:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-32(s0)
	addiw	a5,a5,1
	sw	a5,-32(s0)
.L134:
	lw	a5,-32(s0)
	sext.w	a4,a5
	li	a5,4
	ble	a4,a5,.L135
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-5
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,5
	li	a4,0
	li	a2,46
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L133:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L136
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L136:
	lui	a5,%hi(.LC28)
	addi	a1,a5,%lo(.LC28)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,8
	bne	a4,a5,.L137
	sw	zero,-36(s0)
	j	.L138
.L139:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L138:
	lw	a5,-36(s0)
	sext.w	a4,a5
	li	a5,7
	ble	a4,a5,.L139
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-8
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,8
	li	a4,0
	li	a2,47
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L137:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L140
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L140:
	lui	a5,%hi(.LC29)
	addi	a1,a5,%lo(.LC29)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,3
	bne	a4,a5,.L141
	sw	zero,-40(s0)
	j	.L142
.L143:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-40(s0)
	addiw	a5,a5,1
	sw	a5,-40(s0)
.L142:
	lw	a5,-40(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L143
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,3
	li	a4,0
	li	a2,48
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L141:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L144
	lui	a5,%hi(.LC30)
	addi	a1,a5,%lo(.LC30)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,3
	bne	a4,a5,.L145
	sw	zero,-44(s0)
	j	.L146
.L147:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-44(s0)
	addiw	a5,a5,1
	sw	a5,-44(s0)
.L146:
	lw	a5,-44(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L147
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,3
	li	a4,0
	li	a2,49
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L145:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L144:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L148
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L148:
	lui	a5,%hi(.LC31)
	addi	a1,a5,%lo(.LC31)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,4
	bne	a4,a5,.L149
	sw	zero,-48(s0)
	j	.L150
.L151:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-48(s0)
	addiw	a5,a5,1
	sw	a5,-48(s0)
.L150:
	lw	a5,-48(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L151
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-4
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,4
	li	a4,0
	li	a2,41
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L149:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L152
	lui	a5,%hi(.LC32)
	addi	a1,a5,%lo(.LC32)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,4
	bne	a4,a5,.L153
	sw	zero,-52(s0)
	j	.L154
.L155:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-52(s0)
	addiw	a5,a5,1
	sw	a5,-52(s0)
.L154:
	lw	a5,-52(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L155
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-4
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,4
	li	a4,0
	li	a2,40
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L153:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L152:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L156
	lui	a5,%hi(.LC33)
	addi	a1,a5,%lo(.LC33)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,6
	bne	a4,a5,.L157
	sw	zero,-56(s0)
	j	.L158
.L159:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-56(s0)
	addiw	a5,a5,1
	sw	a5,-56(s0)
.L158:
	lw	a5,-56(s0)
	sext.w	a4,a5
	li	a5,5
	ble	a4,a5,.L159
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-6
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,6
	li	a4,0
	li	a2,53
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L157:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L156:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L160
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L160:
	lui	a5,%hi(.LC34)
	addi	a1,a5,%lo(.LC34)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,7
	bne	a4,a5,.L161
	sw	zero,-60(s0)
	j	.L162
.L163:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-60(s0)
	addiw	a5,a5,1
	sw	a5,-60(s0)
.L162:
	lw	a5,-60(s0)
	sext.w	a4,a5
	li	a5,6
	ble	a4,a5,.L163
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-7
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,7
	li	a4,0
	li	a2,54
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L161:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L164
	lui	a5,%hi(.LC35)
	addi	a1,a5,%lo(.LC35)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,3
	bne	a4,a5,.L165
	sw	zero,-64(s0)
	j	.L166
.L167:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-64(s0)
	addiw	a5,a5,1
	sw	a5,-64(s0)
.L166:
	lw	a5,-64(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L167
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,3
	li	a4,0
	li	a2,44
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L165:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	beq	a4,a5,.L168
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L168:
	lui	a5,%hi(.LC36)
	addi	a1,a5,%lo(.LC36)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,4
	bne	a4,a5,.L169
	sw	zero,-68(s0)
	j	.L170
.L171:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-68(s0)
	addiw	a5,a5,1
	sw	a5,-68(s0)
.L170:
	lw	a5,-68(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L171
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-4
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,4
	li	a4,0
	li	a2,45
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L169:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L164:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L172
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L172:
	lui	a5,%hi(.LC37)
	addi	a1,a5,%lo(.LC37)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,6
	bne	a4,a5,.L173
	sw	zero,-72(s0)
	j	.L174
.L175:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-72(s0)
	addiw	a5,a5,1
	sw	a5,-72(s0)
.L174:
	lw	a5,-72(s0)
	sext.w	a4,a5
	li	a5,5
	ble	a4,a5,.L175
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-6
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,6
	li	a4,0
	li	a2,35
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L173:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L176
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L176:
	lui	a5,%hi(.LC38)
	addi	a1,a5,%lo(.LC38)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,6
	bne	a4,a5,.L177
	sw	zero,-76(s0)
	j	.L178
.L179:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-76(s0)
	addiw	a5,a5,1
	sw	a5,-76(s0)
.L178:
	lw	a5,-76(s0)
	sext.w	a4,a5
	li	a5,5
	ble	a4,a5,.L179
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-6
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,6
	li	a4,0
	li	a2,37
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L177:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L180
	lui	a5,%hi(.LC39)
	addi	a1,a5,%lo(.LC39)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L181
	sw	zero,-80(s0)
	j	.L182
.L183:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-80(s0)
	addiw	a5,a5,1
	sw	a5,-80(s0)
.L182:
	lw	a5,-80(s0)
	sext.w	a4,a5
	li	a5,1
	ble	a4,a5,.L183
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,2
	li	a4,0
	li	a2,36
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L181:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	beq	a4,a5,.L184
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L184:
	lui	a5,%hi(.LC40)
	addi	a1,a5,%lo(.LC40)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L185
	sw	zero,-84(s0)
	j	.L186
.L187:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-84(s0)
	addiw	a5,a5,1
	sw	a5,-84(s0)
.L186:
	lw	a5,-84(s0)
	sext.w	a4,a5
	li	a5,1
	ble	a4,a5,.L187
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,2
	li	a4,0
	li	a2,38
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L185:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	beq	a4,a5,.L188
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L188:
	lui	a5,%hi(.LC41)
	addi	a1,a5,%lo(.LC41)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L189
	sw	zero,-88(s0)
	j	.L190
.L191:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-88(s0)
	addiw	a5,a5,1
	sw	a5,-88(s0)
.L190:
	lw	a5,-88(s0)
	sext.w	a4,a5
	li	a5,1
	ble	a4,a5,.L191
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,2
	li	a4,0
	li	a2,39
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L189:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L180:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L192
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L192:
	lui	a5,%hi(.LC42)
	addi	a1,a5,%lo(.LC42)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,6
	bne	a4,a5,.L193
	sw	zero,-92(s0)
	j	.L194
.L195:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-92(s0)
	addiw	a5,a5,1
	sw	a5,-92(s0)
.L194:
	lw	a5,-92(s0)
	sext.w	a4,a5
	li	a5,5
	ble	a4,a5,.L195
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-6
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,6
	li	a4,0
	li	a2,61
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L193:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L196
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L196:
	lui	a5,%hi(.LC43)
	addi	a1,a5,%lo(.LC43)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,3
	bne	a4,a5,.L197
	sw	zero,-96(s0)
	j	.L198
.L199:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-96(s0)
	addiw	a5,a5,1
	sw	a5,-96(s0)
.L198:
	lw	a5,-96(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L199
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,3
	li	a4,0
	li	a2,25
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L197:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L200
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L200:
	lui	a5,%hi(.LC44)
	addi	a1,a5,%lo(.LC44)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,2
	bne	a4,a5,.L201
	sw	zero,-100(s0)
	j	.L202
.L203:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-100(s0)
	addiw	a5,a5,1
	sw	a5,-100(s0)
.L202:
	lw	a5,-100(s0)
	sext.w	a4,a5
	li	a5,1
	ble	a4,a5,.L203
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-2
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,2
	li	a4,0
	li	a2,28
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L201:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L204
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L204:
	lui	a5,%hi(.LC45)
	addi	a1,a5,%lo(.LC45)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,4
	bne	a4,a5,.L205
	sw	zero,-104(s0)
	j	.L206
.L207:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-104(s0)
	addiw	a5,a5,1
	sw	a5,-104(s0)
.L206:
	lw	a5,-104(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L207
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-4
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,4
	li	a4,0
	li	a2,12
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L205:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L208
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L208:
	lui	a5,%hi(.LC46)
	addi	a1,a5,%lo(.LC46)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,6
	bne	a4,a5,.L209
	sw	zero,-108(s0)
	j	.L210
.L211:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-108(s0)
	addiw	a5,a5,1
	sw	a5,-108(s0)
.L210:
	lw	a5,-108(s0)
	sext.w	a4,a5
	li	a5,5
	ble	a4,a5,.L211
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-6
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,6
	li	a4,0
	li	a2,50
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L209:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L212
	lui	a5,%hi(.LC47)
	addi	a1,a5,%lo(.LC47)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L213
	sw	zero,-112(s0)
	j	.L214
.L215:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-112(s0)
	addiw	a5,a5,1
	sw	a5,-112(s0)
.L214:
	lw	a5,-112(s0)
	sext.w	a4,a5
	li	a5,4
	ble	a4,a5,.L215
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-5
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,5
	li	a4,0
	li	a2,51
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L213:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L212:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L216
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L216:
	lui	a5,%hi(.LC48)
	addi	a1,a5,%lo(.LC48)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,3
	bne	a4,a5,.L217
	sw	zero,-116(s0)
	j	.L218
.L219:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-116(s0)
	addiw	a5,a5,1
	sw	a5,-116(s0)
.L218:
	lw	a5,-116(s0)
	sext.w	a4,a5
	li	a5,2
	ble	a4,a5,.L219
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-3
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,3
	li	a4,0
	li	a2,52
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L217:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L220
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L220:
	lui	a5,%hi(.LC49)
	addi	a1,a5,%lo(.LC49)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L221
	sw	zero,-120(s0)
	j	.L222
.L223:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-120(s0)
	addiw	a5,a5,1
	sw	a5,-120(s0)
.L222:
	lw	a5,-120(s0)
	sext.w	a4,a5
	li	a5,4
	ble	a4,a5,.L223
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-5
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,5
	li	a4,0
	li	a2,42
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L221:
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,1
	bne	a4,a5,.L224
	lui	a5,%hi(.LC50)
	addi	a1,a5,%lo(.LC50)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,4
	bne	a4,a5,.L225
	sw	zero,-124(s0)
	j	.L226
.L227:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-124(s0)
	addiw	a5,a5,1
	sw	a5,-124(s0)
.L226:
	lw	a5,-124(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L227
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-4
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,4
	li	a4,0
	li	a2,43
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L225:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L224:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L228
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L228:
	lui	a5,%hi(.LC51)
	addi	a1,a5,%lo(.LC51)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L229
	sw	zero,-128(s0)
	j	.L230
.L231:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-128(s0)
	addiw	a5,a5,1
	sw	a5,-128(s0)
.L230:
	lw	a5,-128(s0)
	sext.w	a4,a5
	li	a5,4
	ble	a4,a5,.L231
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-5
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,5
	li	a4,0
	li	a2,65
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L229:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L232
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L232:
	lui	a5,%hi(.LC52)
	addi	a1,a5,%lo(.LC52)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,4
	bne	a4,a5,.L233
	sw	zero,-132(s0)
	j	.L234
.L235:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-132(s0)
	addiw	a5,a5,1
	sw	a5,-132(s0)
.L234:
	lw	a5,-132(s0)
	sext.w	a4,a5
	li	a5,3
	ble	a4,a5,.L235
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-4
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,4
	li	a4,0
	li	a2,4
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L233:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L236
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L236:
	lui	a5,%hi(.LC53)
	addi	a1,a5,%lo(.LC53)
	ld	a0,-160(s0)
	call	matched_at_least
	mv	a5,a0
	sw	a5,-140(s0)
	lw	a5,-140(s0)
	sext.w	a4,a5
	li	a5,5
	bne	a4,a5,.L237
	sw	zero,-136(s0)
	j	.L238
.L239:
	ld	a0,-160(s0)
	call	tok_consume
	lw	a5,-136(s0)
	addiw	a5,a5,1
	sw	a5,-136(s0)
.L238:
	lw	a5,-136(s0)
	sext.w	a4,a5
	li	a5,4
	ble	a4,a5,.L239
	ld	a5,-160(s0)
	ld	a4,0(a5)
	ld	a5,-160(s0)
	lw	a5,8(a5)
	addi	a5,a5,-5
	add	a3,a4,a5
	ld	a0,-152(s0)
	li	a5,5
	li	a4,0
	li	a2,3
	ld	a1,-160(s0)
	call	make_token
	j	.L123
.L237:
	lw	a5,-140(s0)
	sext.w	a5,a5
	beq	a5,zero,.L240
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L240:
	ld	a0,-160(s0)
	call	is_digit
	mv	a5,a0
	beq	a5,zero,.L241
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_number
	j	.L123
.L241:
	ld	a0,-160(s0)
	call	can_continue_name
	mv	a5,a0
	beq	a5,zero,.L242
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	tokenize_name
	j	.L123
.L242:
	ld	a5,-152(s0)
	ld	a1,-160(s0)
	mv	a0,a5
	call	try_tokenize_operator
.L123:
	ld	a0,-152(s0)
	ld	ra,152(sp)
	ld	s0,144(sp)
	addi	sp,sp,160
	jr	ra
	.size	try_tokenize_keyword_tree, .-try_tokenize_keyword_tree
	.section	.rodata
	.align	3
.LC54:
	.string	"Unexpected indent"
	.text
	.align	1
	.globl	next_token
	.type	next_token, @function
next_token:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-48(s0)
	lw	a5,20(a5)
	beq	a5,zero,.L244
	ld	a5,-48(s0)
	lbu	a5,32(a5)
	beq	a5,zero,.L245
.L244:
	sw	zero,-20(s0)
	j	.L246
.L251:
	ld	a0,-48(s0)
	call	tok_consume
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	ld	a5,-48(s0)
	lw	a4,16(a5)
	lw	a5,-20(s0)
	sext.w	a5,a5
	bne	a5,a4,.L246
	ld	a0,-48(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L247
	ld	a0,-48(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,32
	bne	a4,a5,.L247
	li	a5,1
	j	.L248
.L247:
	li	a5,0
.L248:
	andi	a5,a5,1
	andi	a4,a5,0xff
	ld	a5,-48(s0)
	sb	a4,32(a5)
	ld	a5,-48(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	lw	a5,8(a5)
	mv	a3,a5
	lw	a5,-20(s0)
	sub	a5,a3,a5
	add	a3,a4,a5
	lw	a5,-20(s0)
	ld	a0,-40(s0)
	li	a4,0
	li	a2,68
	ld	a1,-48(s0)
	call	make_token
	j	.L249
.L246:
	ld	a0,-48(s0)
	call	is_eof
	mv	a5,a0
	xori	a5,a5,1
	andi	a5,a5,0xff
	beq	a5,zero,.L250
	ld	a0,-48(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,32
	beq	a4,a5,.L251
.L250:
	lw	a5,-20(s0)
	sext.w	a5,a5
	beq	a5,zero,.L245
	ld	a4,-40(s0)
	lui	a5,%hi(.LC54)
	addi	a2,a5,%lo(.LC54)
	ld	a1,-48(s0)
	mv	a0,a4
	call	make_error_token
	j	.L249
.L245:
	ld	a0,-48(s0)
	call	skip_whitespace
	ld	a0,-48(s0)
	call	is_eof
	mv	a5,a0
	beq	a5,zero,.L252
	ld	a5,-48(s0)
	ld	a3,0(a5)
	ld	a0,-40(s0)
	li	a5,0
	li	a4,0
	li	a2,66
	ld	a1,-48(s0)
	call	make_token
	j	.L249
.L252:
	ld	a0,-48(s0)
	call	tok_peek
	mv	a5,a0
	mv	a4,a5
	li	a5,10
	bne	a4,a5,.L253
	ld	a0,-48(s0)
	call	tok_consume
	ld	a5,-48(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	lw	a5,8(a5)
	addi	a5,a5,-1
	add	a3,a4,a5
	ld	a0,-40(s0)
	li	a5,1
	li	a4,0
	li	a2,69
	ld	a1,-48(s0)
	call	make_token
	j	.L249
.L253:
	ld	a5,-40(s0)
	ld	a1,-48(s0)
	mv	a0,a5
	call	try_tokenize_keyword_tree
.L249:
	ld	a0,-40(s0)
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	next_token, .-next_token
	.ident	"GCC: () 13.2.0"
