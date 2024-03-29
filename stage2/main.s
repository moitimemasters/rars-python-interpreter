	.text
.align 2
	.globl	print_token_lexeme
print_token_lexeme:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	addi	s0,sp,48
	mv	s1,a0
	sw	zero,-36(s0)
	j	.L2
.L3:
	ld	a4,8(s1)
	lw	a5,-36(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a0,a5
	call	printchar
	lw	a5,-36(s0)
	addiw	a5,a5,1
	sw	a5,-36(s0)
.L2:
	lw	a4,-36(s0)
	ld	a5,24(s1)
	bltu	a4,a5,.L3
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
	.globl	interpret_arithmetic
interpret_arithmetic:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	lw	a5,0(a5)
	mv	a4,a5
	li	a5,6
	bne	a4,a5,.L5
	ld	a5,-40(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	interpret_arithmetic
	mv	a5,a0
	sw	a5,-20(s0)
	ld	a5,-40(s0)
	ld	a5,16(a5)
	mv	a0,a5
	call	interpret_arithmetic
	mv	a5,a0
	sw	a5,-24(s0)
	ld	a5,-40(s0)
	lw	a5,24(a5)
	mv	a3,a5
	li	a4,17
	beq	a3,a4,.L6
	mv	a3,a5
	li	a4,17
	bgtu	a3,a4,.L7
	mv	a3,a5
	li	a4,15
	beq	a3,a4,.L8
	mv	a3,a5
	li	a4,15
	bgtu	a3,a4,.L7
	mv	a3,a5
	li	a4,10
	beq	a3,a4,.L9
	mv	a4,a5
	li	a5,13
	beq	a4,a5,.L10
	j	.L7
.L9:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	j	.L11
.L10:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	subw	a5,a4,a5
	sext.w	a5,a5
	j	.L11
.L8:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	mulw	a5,a4,a5
	sext.w	a5,a5
	j	.L11
.L6:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	divw	a5,a4,a5
	sext.w	a5,a5
	j	.L11
.L5:
	ld	a5,-40(s0)
	lw	a5,0(a5)
	bne	a5,zero,.L7
	ld	a5,-40(s0)
	lw	a5,8(a5)
	j	.L11
.L7:
	li	a5,0
.L11:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.section	.rodata
.LC0:
	.string	"def foo(a, b, c):\n    if a > b:\n        return a + b"
.LC1:
	.string	"started lexing\n"
.LC2:
	.string	"ended lexing\n"
.LC3:
	.string	"Invalid token at line %d, column %d\n"
.LC4:
	.string	"started parsing ast\n"
.LC5:
	.string	"ended parsing ast\n"
.LC6:
	.string	"Error parsing\n"
	.text
.align 2
	.globl	main
main:
	addi	sp,sp,-176
	sd	ra,168(sp)
	sd	s0,160(sp)
	addi	s0,sp,176
	li	a5,268697600
	sd	a5,-64(s0)
	li	a5,805306368
	sd	a5,-56(s0)
	lui	a5,%hi(.LC0)
	addi	a5,a5,%lo(.LC0)
	sd	a5,-32(s0)
	addi	a5,s0,-64
	sd	a5,-72(s0)
	ld	a5,-32(s0)
	sd	a5,-112(s0)
	ld	a0,-32(s0)
	call	my_strlen
	mv	a5,a0
	sd	a5,-88(s0)
	sw	zero,-104(s0)
	li	a5,1
	sw	a5,-100(s0)
	sw	zero,-92(s0)
	li	a5,4
	sw	a5,-96(s0)
	sb	zero,-80(s0)
	addi	a4,s0,-64
	li	a5,4096
	addi	a1,a5,-96
	mv	a0,a4
	call	my_alloc
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	lui	a5,%hi(.LC1)
	addi	a0,a5,%lo(.LC1)
	call	my_printf
	j	.L13
.L15:
	lw	a5,-20(s0)
	addiw	a4,a5,1
	sw	a4,-20(s0)
	slli	a5,a5,5
	ld	a4,-40(s0)
	add	a5,a4,a5
	ld	a1,-144(s0)
	ld	a2,-136(s0)
	ld	a3,-128(s0)
	ld	a4,-120(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
.L13:
	addi	a5,s0,-144
	addi	a4,s0,-112
	mv	a1,a4
	mv	a0,a5
	call	next_token
	lw	a5,-144(s0)
	mv	a4,a5
	li	a5,66
	beq	a4,a5,.L14
	lw	a5,-144(s0)
	mv	a4,a5
	li	a5,67
	bne	a4,a5,.L15
.L14:
	lui	a5,%hi(.LC2)
	addi	a0,a5,%lo(.LC2)
	call	my_printf
	lw	a5,-144(s0)
	mv	a4,a5
	li	a5,67
	bne	a4,a5,.L16
	lw	a5,-124(s0)
	lw	a4,-92(s0)
	mv	a2,a4
	mv	a1,a5
	lui	a5,%hi(.LC3)
	addi	a0,a5,%lo(.LC3)
	call	my_printf
	call	Exit
.L16:
	sw	zero,-160(s0)
	addi	a5,s0,-64
	sd	a5,-176(s0)
	lw	a5,-20(s0)
	sw	a5,-156(s0)
	ld	a5,-40(s0)
	sd	a5,-168(s0)
	sw	zero,-152(s0)
	lui	a5,%hi(.LC4)
	addi	a0,a5,%lo(.LC4)
	call	my_printf
	addi	a5,s0,-176
	mv	a0,a5
	call	parse
	sd	a0,-48(s0)
	lui	a5,%hi(.LC5)
	addi	a0,a5,%lo(.LC5)
	call	my_printf
	ld	a5,-48(s0)
	bne	a5,zero,.L17
	lui	a5,%hi(.LC6)
	addi	a0,a5,%lo(.LC6)
	call	my_printf
	call	Exit
.L17:
	call	Exit
	li	a5,0
	mv	a0,a5
	ld	ra,168(sp)
	ld	s0,160(sp)
	addi	sp,sp,176
	jr	ra
