	.text
.align 2
	.globl	find_free_block
find_free_block:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L2
.L4:
	ld	a5,-24(s0)
	ld	a5,16(a5)
	sd	a5,-24(s0)
.L2:
	ld	a5,-24(s0)
	beq	a5,zero,.L3
	ld	a5,-24(s0)
	lbu	a5,8(a5)
	xori	a5,a5,1
	andi	a5,a5,0xff
	bne	a5,zero,.L4
	ld	a5,-24(s0)
	ld	a5,0(a5)
	ld	a4,-48(s0)
	bgtu	a4,a5,.L4
.L3:
	ld	a5,-24(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.globl	my_alloc
my_alloc:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-48(s0)
	andi	a5,a5,7
	sd	a5,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L7
	ld	a4,-48(s0)
	ld	a5,-32(s0)
	sub	a5,a4,a5
	addi	a5,a5,8
	sd	a5,-48(s0)
.L7:
	ld	a1,-48(s0)
	ld	a0,-40(s0)
	call	find_free_block
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L8
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	addi	a5,a5,24
	slli	a5,a5,3
	add	a4,a4,a5
	ld	a5,-40(s0)
	ld	a5,8(a5)
	bleu	a4,a5,.L9
	li	a5,0
	j	.L10
.L9:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	ld	a4,-48(s0)
	sd	a4,0(a5)
	ld	a5,-24(s0)
	sb	zero,8(a5)
	ld	a5,-24(s0)
	sd	zero,16(a5)
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	addi	a5,a5,24
	slli	a5,a5,3
	add	a4,a4,a5
	ld	a5,-40(s0)
	sd	a4,0(a5)
	j	.L11
.L8:
	ld	a5,-24(s0)
	sb	zero,8(a5)
.L11:
	ld	a5,-24(s0)
	addi	a5,a5,24
.L10:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.globl	my_free
my_free:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-48(s0)
	beq	a5,zero,.L15
	ld	a5,-48(s0)
	addi	a5,a5,-24
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	li	a4,1
	sb	a4,8(a5)
	j	.L12
.L15:
	nop
.L12:
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
