	.text
.align 2
	.globl	lock
lock:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	ld	a5,-64(s0)
	ld	a5,8(a5)
	ld	a5,0(a5)
	beq	a5,zero,.L2
	ld	a5,-64(s0)
	ld	a5,0(a5)
	sd	a5,-48(s0)
	ld	a5,-64(s0)
	ld	a5,8(a5)
	sd	a5,-40(s0)
	ld	a5,-64(s0)
	ld	a5,16(a5)
	sd	a5,-32(s0)
	ld	a5,-40(s0)
	ld	a4,0(a5)
	addi	a4,a4,1
	sd	a4,0(a5)
	ld	a5,-56(s0)
	ld	a1,-48(s0)
	ld	a2,-40(s0)
	ld	a3,-32(s0)
	ld	a4,-24(s0)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	j	.L1
.L2:
	sd	zero,-48(s0)
	sd	zero,-40(s0)
	sd	zero,-32(s0)
	ld	a5,-64(s0)
	ld	a5,24(a5)
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
.L1:
	ld	a0,-56(s0)
	ld	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.globl	release_weak
release_weak:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a5,16(a5)
	ld	a4,0(a5)
	addi	a4,a4,-1
	sd	a4,0(a5)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	ld	a5,0(a5)
	bne	a5,zero,.L6
	ld	a5,-24(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	bne	a5,zero,.L6
	ld	a5,-24(s0)
	ld	a4,24(a5)
	ld	a5,-24(s0)
	ld	a5,16(a5)
	mv	a1,a5
	mv	a0,a4
	call	my_free
.L6:
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.globl	retain_weak
retain_weak:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a5,16(a5)
	ld	a4,0(a5)
	addi	a4,a4,1
	sd	a4,0(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	make_weak
make_weak:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	ld	a5,-64(s0)
	ld	a5,0(a5)
	sd	a5,-48(s0)
	ld	a5,-64(s0)
	ld	a5,8(a5)
	sd	a5,-40(s0)
	ld	a5,-64(s0)
	ld	a5,16(a5)
	sd	a5,-32(s0)
	ld	a5,-64(s0)
	ld	a5,24(a5)
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	ld	a4,0(a5)
	addi	a4,a4,1
	sd	a4,0(a5)
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
	ld	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.globl	release_shared
release_shared:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	ld	a4,0(a5)
	addi	a4,a4,-1
	sd	a4,0(a5)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	ld	a5,0(a5)
	bne	a5,zero,.L12
	ld	a5,-24(s0)
	ld	a4,24(a5)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	mv	a1,a5
	mv	a0,a4
	call	my_free
	ld	a5,-24(s0)
	ld	a4,24(a5)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	mv	a1,a5
	mv	a0,a4
	call	my_free
	ld	a5,-24(s0)
	ld	a5,16(a5)
	ld	a5,0(a5)
	bne	a5,zero,.L12
	ld	a5,-24(s0)
	ld	a4,24(a5)
	ld	a5,-24(s0)
	ld	a5,16(a5)
	mv	a1,a5
	mv	a0,a4
	call	my_free
.L12:
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.globl	retain_shared
retain_shared:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	ld	a4,0(a5)
	addi	a4,a4,1
	sd	a4,0(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	make_shared
make_shared:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	addi	s0,sp,80
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	sd	a2,-72(s0)
	ld	a5,-72(s0)
	sd	a5,-48(s0)
	li	a1,8
	ld	a0,-64(s0)
	call	my_alloc
	mv	a5,a0
	sd	a5,-40(s0)
	li	a1,8
	ld	a0,-64(s0)
	call	my_alloc
	mv	a5,a0
	sd	a5,-32(s0)
	ld	a5,-40(s0)
	li	a4,1
	sd	a4,0(a5)
	ld	a5,-32(s0)
	sd	zero,0(a5)
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
	ld	ra,72(sp)
	ld	s0,64(sp)
	addi	sp,sp,80
	jr	ra
	.globl	copy_shared
copy_shared:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	sd	s1,24(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	s1,a1
	mv	a0,s1
	call	retain_shared
	ld	a5,-40(s0)
	ld	a1,0(s1)
	ld	a2,8(s1)
	ld	a3,16(s1)
	ld	a4,24(s1)
	sd	a1,0(a5)
	sd	a2,8(a5)
	sd	a3,16(a5)
	sd	a4,24(a5)
	ld	a0,-40(s0)
	ld	ra,40(sp)
	ld	s0,32(sp)
	ld	s1,24(sp)
	addi	sp,sp,48
	jr	ra
