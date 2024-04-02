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
	.globl	my_free
my_free:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-48(s0)
	beq	a5,zero,.L9
	ld	a5,-48(s0)
	addi	a5,a5,-24
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	li	a4,1
	sb	a4,8(a5)
	j	.L6
.L9:
	nop
.L6:
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.globl	my_memcpy
my_memcpy:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	sd	zero,-24(s0)
	j	.L11
.L12:
	ld	a4,-48(s0)
	ld	a5,-24(s0)
	add	a4,a4,a5
	ld	a3,-40(s0)
	ld	a5,-24(s0)
	add	a5,a3,a5
	lbu	a4,0(a4)
	sb	a4,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
.L11:
	ld	a4,-24(s0)
	ld	a5,-56(s0)
	bltu	a4,a5,.L12
	nop
	nop
	ld	s0,56(sp)
	addi	sp,sp,64
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
	beq	a5,zero,.L14
	ld	a4,-48(s0)
	ld	a5,-32(s0)
	sub	a5,a4,a5
	addi	a5,a5,8
	sd	a5,-48(s0)
.L14:
	ld	a1,-48(s0)
	ld	a0,-40(s0)
	call	find_free_block
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L15
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-48(s0)
	addi	a5,a5,24
	slli	a5,a5,3
	add	a4,a4,a5
	ld	a5,-40(s0)
	ld	a5,8(a5)
	bleu	a4,a5,.L16
	li	a5,0
	j	.L17
.L16:
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
	j	.L18
.L15:
	ld	a5,-24(s0)
	sb	zero,8(a5)
.L18:
	ld	a5,-24(s0)
	addi	a5,a5,24
.L17:
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.globl	my_realloc
my_realloc:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	ld	a5,-64(s0)
	addi	a5,a5,-24
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	ld	a4,-72(s0)
	bgtu	a4,a5,.L20
	ld	a5,-64(s0)
	j	.L21
.L20:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	sw	a5,-28(s0)
	j	.L22
.L25:
	ld	a5,-24(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	sext.w	a4,a5
	lw	a5,-28(s0)
	addw	a5,a4,a5
	sext.w	a5,a5
	sw	a5,-28(s0)
	lw	a5,-28(s0)
	ld	a4,-72(s0)
	bgtu	a4,a5,.L23
	lw	a4,-28(s0)
	ld	a5,-24(s0)
	sd	a4,0(a5)
	ld	a5,-24(s0)
	ld	a5,16(a5)
	ld	a4,16(a5)
	ld	a5,-24(s0)
	sd	a4,16(a5)
	ld	a5,-64(s0)
	j	.L21
.L23:
	ld	a5,-24(s0)
	ld	a5,16(a5)
	sd	a5,-24(s0)
.L22:
	ld	a5,-24(s0)
	ld	a5,16(a5)
	beq	a5,zero,.L24
	ld	a5,-24(s0)
	ld	a5,16(a5)
	lbu	a5,8(a5)
	bne	a5,zero,.L25
.L24:
	ld	a5,-24(s0)
	ld	a5,16(a5)
	bne	a5,zero,.L26
	ld	a5,-64(s0)
	j	.L21
.L26:
	ld	a1,-72(s0)
	ld	a0,-56(s0)
	call	my_alloc
	sd	a0,-40(s0)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	mv	a2,a5
	ld	a1,-64(s0)
	ld	a0,-40(s0)
	call	my_memcpy
	ld	a1,-64(s0)
	ld	a0,-56(s0)
	call	my_free
	ld	a5,-40(s0)
.L21:
	mv	a0,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
