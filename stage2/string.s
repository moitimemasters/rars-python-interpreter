	.text
.align 2
	.globl	my_strlen
my_strlen:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	j	.L2
.L3:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L2:
	ld	a5,-40(s0)
	addi	a4,a5,1
	sd	a4,-40(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L3
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.globl	my_strcpy
my_strcpy:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	j	.L6
.L7:
	ld	a5,-32(s0)
	lbu	a4,0(a5)
	ld	a5,-24(s0)
	sb	a4,0(a5)
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	addi	a5,a5,1
	sd	a5,-32(s0)
.L6:
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	bne	a5,zero,.L7
	ld	a5,-24(s0)
	sb	zero,0(a5)
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	my_strcmp
my_strcmp:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	j	.L9
.L11:
	ld	a5,-24(s0)
	addi	a5,a5,1
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	addi	a5,a5,1
	sd	a5,-32(s0)
.L9:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	beq	a5,zero,.L10
	ld	a5,-24(s0)
	lbu	a4,0(a5)
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	beq	a4,a5,.L11
.L10:
	ld	a5,-24(s0)
	lbu	a5,0(a5)
	sext.w	a4,a5
	ld	a5,-32(s0)
	lbu	a5,0(a5)
	sext.w	a5,a5
	subw	a5,a4,a5
	sext.w	a5,a5
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	empty
empty:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	li	a1,24
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	sd	zero,0(a5)
	ld	a5,-24(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-24(s0)
	sw	zero,12(a5)
	ld	a5,-24(s0)
	sw	zero,8(a5)
	nop
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.globl	from_c_str
from_c_str:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	li	a1,24
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a0,-48(s0)
	call	my_strlen
	mv	a5,a0
	addiw	a5,a5,1
	sext.w	a5,a5
	mv	a1,a5
	ld	a0,-40(s0)
	call	my_alloc
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,0(a5)
	ld	a0,-48(s0)
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-24(s0)
	sw	a4,8(a5)
	ld	a5,-24(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-24(s0)
	lw	a5,8(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,12(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.globl	from_string_view
from_string_view:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-56(s0)
	sd	a2,-48(s0)
	li	a1,24
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-48(s0)
	mv	a1,a5
	ld	a0,-40(s0)
	call	my_alloc
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,0(a5)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	ld	a4,-56(s0)
	ld	a3,-48(s0)
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	my_memcpy
	ld	a5,-24(s0)
	ld	a4,-40(s0)
	sd	a4,16(a5)
	ld	a5,-48(s0)
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,8(a5)
	ld	a5,-24(s0)
	lw	a5,8(a5)
	addiw	a5,a5,1
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,12(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.globl	append_string_view
append_string_view:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-40(s0)
	sd	a2,-32(s0)
	ld	a5,-24(s0)
	lw	a5,8(a5)
	mv	a4,a5
	ld	a5,-32(s0)
	add	a5,a4,a5
	ld	a4,-24(s0)
	lw	a4,12(a4)
	bltu	a5,a4,.L19
	ld	a5,-24(s0)
	lw	a5,8(a5)
	sext.w	a4,a5
	ld	a5,-32(s0)
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a5,a5
	addiw	a5,a5,1
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,12(a5)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	bne	a5,zero,.L20
	ld	a5,-24(s0)
	ld	a5,16(a5)
	ld	a4,-32(s0)
	mv	a1,a4
	mv	a0,a5
	call	my_alloc
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,0(a5)
	j	.L19
.L20:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	beq	a5,zero,.L19
	ld	a5,-24(s0)
	ld	a4,16(a5)
	ld	a5,-24(s0)
	ld	a3,0(a5)
	ld	a5,-24(s0)
	lw	a5,12(a5)
	mv	a2,a5
	mv	a1,a3
	mv	a0,a4
	call	my_realloc
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,0(a5)
.L19:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	ld	a4,-24(s0)
	lw	a4,8(a4)
	add	a5,a5,a4
	ld	a4,-40(s0)
	ld	a3,-32(s0)
	mv	a2,a3
	mv	a1,a4
	mv	a0,a5
	call	my_memcpy
	ld	a5,-24(s0)
	lw	a5,8(a5)
	sext.w	a4,a5
	ld	a5,-32(s0)
	sext.w	a5,a5
	addw	a5,a4,a5
	sext.w	a5,a5
	sext.w	a4,a5
	ld	a5,-24(s0)
	sw	a4,8(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.globl	string_destroy
string_destroy:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a4,16(a5)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	mv	a1,a5
	mv	a0,a4
	call	my_free
	ld	a5,-24(s0)
	sd	zero,0(a5)
	ld	a5,-24(s0)
	sw	zero,12(a5)
	ld	a5,-24(s0)
	sw	zero,8(a5)
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
